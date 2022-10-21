//
//  BaseViewController.swift
//  AssessmentApp
//
//  Created by Moataz on 21/10/2022.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

//MARK: -BaseViewController

/* Documentation
 UIViewController with loader and alert
 */
@IBDesignable
class BaseViewController: UIViewController {
    
    lazy private var loader: UIActivityIndicatorView = {
        let loder = UIActivityIndicatorView(style: .large)
        loder.color = DesignSystem.appColor(.primary)
        return loder
        
    }()
    
    public var isLoading = BehaviorRelay<Bool>(value: false)
    public let disposeBag = DisposeBag()
    
    deinit {
        print("\(String(describing: self)) deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.drawMyView()
        self.manageObserver()
    }
    
    
    //Main Action
    private func drawMyView(){
        //Background
        self.view.backgroundColor = DesignSystem.appColor(.white)
        
        //draw SubViews
        self.view.addSubview(self.loader)
        self.loader.withConstraints(withWidth: UIScreen.main.bounds.width*0.15,
                                    withHeight: UIScreen.main.bounds.width*0.15,
                                    centerVertical: true, centerHorizontal: true)
    }
    
    private func manageObserver(){
        self.isLoading
            .asDriver()
            .drive(onNext: {[weak self] in
                $0 ? self?.loader.startAnimating():self?.loader.stopAnimating()
                $0 ? self?.view.bringSubviewToFront(self!.loader):()
            }).disposed(by: disposeBag)
        
    }
    
}
