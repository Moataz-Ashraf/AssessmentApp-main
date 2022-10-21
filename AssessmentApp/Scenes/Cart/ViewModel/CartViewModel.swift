//
//  CartViewModel.swift
//  AssessmentApp
//
//  Created by Moataz on 21/10/2022.
//

import Foundation
import RxCocoa
import RxSwift
import CoreData

protocol CartVMProtocol: AnyObject {
    var cartObservable: Observable<[CartProduct]> { get }
    var totalCostObservable : Observable<String> { get }
    var loadingObservable: Observable<Bool> { get }
    var errorObservable: Observable<String> { get }
    var viewWillAppear: PublishRelay<Void> { get }
    var clearAllProducts: PublishRelay<Void> { get }
}

class CartViewModel: CartVMProtocol {
    private let managedContext = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
    let viewWillAppear = PublishRelay<Void>()
    var clearAllProducts = PublishRelay<Void>()
    private var disposeBag = DisposeBag()
    
    private var cartSubject = BehaviorRelay<[CartProduct]>(value: [])
    var cartObservable: Observable<[CartProduct]> {
        return cartSubject.asObservable()
    }
    
    private var totalCostBehavior = PublishRelay<String>()
    var totalCostObservable : Observable<String> {
        return totalCostBehavior.asObservable()
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
        // when viewWillAppear
        viewWillAppear
            .asObservable()
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                Task {
                    await self.fetchProducts()
                }
            })
            .disposed(by: disposeBag)
        
        // clearAllProducts - Tabbed -
        clearAllProducts
            .asObservable()
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                Task {
                    await self.deleteProducts()
                }
            })
            .disposed(by: disposeBag)
        
        // Cart Subscribe - handle (TotalCost)
        cartSubject.asObservable()
            .subscribe(onNext: { [weak self] in
                self?.totalCostBehavior.accept($0.compactMap{$0.retailPrice}.sum())
            })
            .disposed(by: disposeBag)
        
    }
    
    // MARK: - FetchProducts
    private
    func fetchProducts() async {
        loadingBehavior.accept(true)
        let noteFetch: NSFetchRequest<CartProduct> = CartProduct.fetchRequest()
        do {
            let results = try managedContext.fetch(noteFetch)
            cartSubject.accept(results)
            loadingBehavior.accept(false)
        } catch let error as NSError {
            loadingBehavior.accept(false)
            guard let error = error as? APIError else { return }
            errorBehavior.accept(error.description)
        }
    }
    
    // MARK: - ClearAllProducts
    private
    func deleteProducts() async {
        for object in cartSubject.value {
            managedContext.delete(object)
        }
        // Save Changes
        await AppDelegate.sharedAppDelegate.coreDataStack.saveContext()
        cartSubject.accept([])
    }
}
