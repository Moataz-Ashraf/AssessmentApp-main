//
//  CartListVC.swift
//  AssessmentApp
//
//  Created by Moataz on 21/10/2022.
//

import UIKit
import RxSwift
import RxCocoa

class CartListVC: BaseViewController {
    
    // MARK: - UI
    private
    lazy var scrollStack: ScrollStack = {
        let scroll = ScrollStack()
        scroll.addArrangedSubview(cartTableView)
        return scroll
    }()
    // CartTableView - UITableView -
    private
    lazy var cartTableView: UITableView = {
        let tableView = ContentSizedTableViewWithDefaultSize()
        tableView.register(CartCell.self, forCellReuseIdentifier: .Identifier.CartCellId.value)
        return tableView
    }()
    // CheckOutView - BottomViewWithBtn -
    private
    lazy var checkOutView: BottomViewWithBtn = {
        let obj = BottomViewWithBtn()
        obj.prepareView(leftText: "0", rightButtonText: "Check Out")
        return obj
    }()
    
    // MARK: - Properties
    private
    let viewModel: CartVMProtocol
    
    // MARK: - Initialization
    init(viewModel: CartVMProtocol = CartViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        print("\(String(describing: self)) init")
        self.bindPresenter()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.drawMyView()
        viewModel.viewWillAppear.accept(())
    }
    
    //Main Draw Action
    private
    func drawMyView(){
        //draw SubViews
        self.drawSubviews()
        self.setupNavigationBar()
    }
}

// MARK: - Draw Subviews
extension CartListVC {
    // DrawSubviews
    private
    func drawSubviews(){
        view.addSubview(scrollStack)
        view.addSubview(checkOutView)
        scrollStack.withConstraints(leading: 0, trailing: 0, top: 0)
        scrollStack.withConstraints(toView: checkOutView, bottom: DesignSystem.s_verticalSpace)
        checkOutView.withConstraints(leading: 0, trailing: 0, bottom: 0, toSafeArea: false)
    }
    // SetupNavigationBar
    private
    func setupNavigationBar(){
        self.title = "Cart List"
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        let claer = UIBarButtonItem(title: "Clear All", style: .plain, target: self, action: #selector(clearTapped))
        navigationItem.rightBarButtonItem = add
        navigationItem.leftBarButtonItem = claer
        navigationItem.rightBarButtonItem?.tintColor = DesignSystem.appColor(.primary)
        navigationItem.leftBarButtonItem?.tintColor = DesignSystem.appColor(.primary)
    }
}

// MARK: - handle UIBarButtonItem * Actions *
extension CartListVC {
    // Add Product - Tapped -
    @objc
    func addTapped() {
        self.navigationController?.pushViewController(ProductsVC(), animated: true)
    }
    // Clear All Product - Tapped -
    @objc
    func clearTapped() {
        self.alertMessage(title: "Notice", btnTitle: "Clear All", message: "Are you need to clear your cart ?") { [weak self] in
            self?.viewModel.clearAllProducts.accept(())
        }
    }
}

// MARK: - Bind Presenter
extension CartListVC {
    private
    func bindPresenter() {
        // loading Indicator
        viewModel.loadingObservable
            .bind(to: isLoading)
            .disposed(by: disposeBag)
        
        // Handle Error
        viewModel.errorObservable
            .asDriver(onErrorJustReturn: "")
            .drive(onNext: {[weak self] error in
                guard let self = self else { return }
                self.MAK_ShowToast(message: error )
                debugPrint(error)
            }).disposed(by: disposeBag)
        
        // Handle checkOutView
        viewModel.totalCostObservable
            .asDriver(onErrorJustReturn: "")
            .drive(onNext : {[weak self] in
                self?.checkOutView.prepareView(leftText: $0, rightButtonText: "Check Out")
            })
            .disposed(by: disposeBag)
        
        // Handle Empty Data TableView
        viewModel.cartObservable
            .map{$0.isEmpty}
            .asDriver(onErrorJustReturn: false)
            .drive(onNext : {[weak self] in
                $0 ? self?.cartTableView.setEmptyMessage() : self?.cartTableView.removeEmptyMessage()
            })
            .disposed(by: disposeBag)
        
        // Handle TableView Data
        viewModel.cartObservable
            .asDriver(onErrorJustReturn: [])
            .drive(cartTableView.rx.items(cellIdentifier: .Identifier.CartCellId.value, cellType: CartCell.self)) {(index, model, cell) in
                cell.handleCell(model: model)
            }
            .disposed(by: disposeBag)
    }
}
