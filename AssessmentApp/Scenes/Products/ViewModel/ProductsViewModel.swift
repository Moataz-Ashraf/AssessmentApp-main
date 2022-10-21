//
//  ProductsViewModel.swift
//  AssessmentApp
//
//  Created by Moataz on 21/10/2022.
//

import Foundation
import RxCocoa
import RxSwift

class ProductsViewModel: ProductsVMProtocol {
    let viewDidLoad = PublishRelay<Void>()
    var addToCart = PublishRelay<Int>()
    var popViewController = PublishRelay<Void>()
    private var disposeBag = DisposeBag()
    
    private var productsSubject = BehaviorRelay<[String: Product]>(value: [:])
    var productsObservable: Observable<[String: Product]> {
        return productsSubject.asObservable()
    }

    private var loadingBehavior = BehaviorRelay<Bool>(value: false)
    var loadingObservable : Observable<Bool> {
        return loadingBehavior.asObservable()
    }

    private var errorBehavior = PublishRelay<String>()
    var errorObservable : Observable<String> {
        return errorBehavior.asObservable()
    }
    
    // MARK: -> Initialization
    init() {
        print("\(String(describing: self)) init")
        self.manageViewModel()
    }
    
    deinit {
        print("\(String(describing: self)) deinit")
    }
    
    // MARK: - Management
    private
    func manageViewModel() {
        // when viewDidLoad
        viewDidLoad
            .asObservable()
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                Task {
                    await self.fetchProducts()
                }
            })
            .disposed(by: disposeBag)
        
        // AddToCart - Tabbed -
        addToCart
            .asObservable()
            .subscribe(onNext: { [weak self] indx in
                guard let self = self else { return }
                Task {
                    await self.addToCart(product: Array(self.productsSubject.value)[indx].value)
                }
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - FetchProducts
    private
    func fetchProducts() async {
        loadingBehavior.accept(true)

        do {
            let products = try await UserRouter.products.send(Products.self)

            productsSubject.accept(products)
            loadingBehavior.accept(false)

        }catch {
            loadingBehavior.accept(false)
            guard let error = error as? APIError else { return }
            errorBehavior.accept(error.description)
        }
    }

    // MARK: - AddToCart
    private
    func addToCart(product: Product) async {
        let managedContext = await AppDelegate.sharedAppDelegate.coreDataStack.managedContext
           let newCartProduct = CartProduct(context: managedContext)
        newCartProduct.setValue(product.name, forKey: #keyPath(CartProduct.name))
        newCartProduct.setValue(product.imageURL, forKey: #keyPath(CartProduct.imageURL))
        newCartProduct.setValue(product.retailPrice, forKey: #keyPath(CartProduct.retailPrice))
        await AppDelegate.sharedAppDelegate.coreDataStack.saveContext() // Save changes in CoreData
        self.popViewController.accept(())
    }
}

