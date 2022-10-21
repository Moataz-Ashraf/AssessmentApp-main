//
//  ProductsVMProtocol.swift
//  AssessmentApp
//
//  Created by Moataz on 22/10/2022.
//

import Foundation
import RxCocoa
import RxSwift

protocol ProductsVMProtocol: AnyObject {
    var productsObservable: Observable<[String: Product]> { get }
    var loadingObservable: Observable<Bool> { get }
    var errorObservable: Observable<String> { get }
    var viewDidLoad: PublishRelay<Void> { get }
    var addToCart: PublishRelay<Int> { get }
    var popViewController: PublishRelay<Void> { get }
}
