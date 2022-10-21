//
//  ProductsVC.swift
//  AssessmentApp
//
//  Created by Irfan Saeed on 19/01/2022.
//

import UIKit
import RxSwift
import RxCocoa

class ProductsVC: BaseViewController {
    
    // MARK: - UI
    private
    lazy var scrollStack: ScrollStack = {
        let scroll = ScrollStack()
        scroll.addArrangedSubview(collectionView)
        return scroll
    }()
    
    // CollectionView
    private
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        flowLayout.minimumInteritemSpacing = DesignSystem.horizontalSpace
        flowLayout.minimumLineSpacing =  DesignSystem.verticalSpace*2
        let object = ContentSizedCollectionViewWithDefaultSize(frame: .zero, collectionViewLayout: flowLayout)
        //Register cell
        object.register(ProductsCell.self, forCellWithReuseIdentifier: .Identifier.ProductsCellId.value)
        return object
    }()
    
    // MARK: - Properties
    private
    let viewModel: ProductsVMProtocol
    
    // MARK: - Initialization
    init(viewModel: ProductsVMProtocol = ProductsViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        print("\(String(describing: self)) init")
        self.bindPresenter()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.drawMyView()
    }
    
    //Main Draw Action
    private
    func drawMyView(){
        //draw SubViews
        self.drawSubviews()
    }
}

// MARK: - Draw Subviews
extension ProductsVC {
    private
    func drawSubviews(){
        self.title = "Products"
        view.addSubview(scrollStack)
        scrollStack.withConstraints(leading: 0, trailing: 0, top: 0, bottom: 0)
    }
}

// MARK: - Bind Presenter
extension ProductsVC {
    private
    func bindPresenter() {
        // Loading Indicator
        viewModel.loadingObservable
            .bind(to: isLoading)
            .disposed(by: disposeBag)
        
        // ViewDidLoad
        viewModel.viewDidLoad.accept(())
        
        // Handle Error
        viewModel.errorObservable
            .asDriver(onErrorJustReturn: "")
            .drive(onNext: {[weak self] error in
                guard let self = self else { return }
                self.MAK_ShowToast(message: error )
                debugPrint(error)
            }).disposed(by: disposeBag)
        
        // Handle Empty Data CollectionView
        viewModel.productsObservable
            .skip(1)
            .map{$0.isEmpty}
            .asDriver(onErrorJustReturn: false)
            .drive(onNext : {[weak self] in
                $0 ? self?.collectionView.setEmptyMessage() : self?.collectionView.removeEmptyMessage()
            })
            .disposed(by: disposeBag)
        
        // CollectionView Data
        viewModel.productsObservable
            .asDriver(onErrorJustReturn: [:])
            .drive(collectionView.rx.items(cellIdentifier: .Identifier.ProductsCellId.value, cellType: ProductsCell.self)) {(index, model, cell) in
                cell.handleCell(model: model.value)
            }
            .disposed(by: disposeBag)
        
        // CollectionView - itemSelected
        collectionView.rx.itemSelected
            .subscribe(onNext: {[weak self] indx in
                self?.alertMessage(title: "Notice", btnTitle: "Add To Cart") { [weak self] in
                    self?.viewModel.addToCart.accept(indx.row)
                }
            })
            .disposed(by: disposeBag)
        
        // popViewController - Router -
        viewModel.popViewController
            .asDriver(onErrorJustReturn: ())
            .drive(onNext : {[weak self] in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
    }
}
