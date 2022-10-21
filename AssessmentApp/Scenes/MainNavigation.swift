//
//  MainNavigation.swift
//  AssessmentApp
//
//  Created by Moataz on 21/10/2022.
//

import Foundation
import UIKit

class MainNavigator: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupUI()
    }
    
    private func setupUI(){
        // Setup Nav
        self.navigationBar.tintColor = DesignSystem.appColor(.primary)
    }

    //MARK:  statusBar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) {
            return .darkContent
        } else {
            // Fallback on earlier versions
            return .default
        }
    }
}
