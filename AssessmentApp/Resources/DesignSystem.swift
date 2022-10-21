//
//  DesignSystem.swift
//  AssessmentApp
//
//  Created by Moataz on 21/10/2022.
//

import Foundation
import UIKit

//MARK: - Common constraints
class DesignSystem {
    //space
    static let headersVerticalSpace = (UIScreen.main.bounds.height * 0.04)
    static let verticalSpace = (UIScreen.main.bounds.height * 0.02)
    static let s_verticalSpace = (UIScreen.main.bounds.height * 0.005)
    static let horizontalSpace = (UIScreen.main.bounds.width * 0.04)
    static let s_horizontalSpace = (UIScreen.main.bounds.width * 0.01)
    
    // View
    static let halfWidthView: CGFloat = (((UIScreen.main.bounds.width * 0.9) - (horizontalSpace))/2)
    
    //button
    static let buttonHeight = (UIScreen.main.bounds.height * 0.05)
    static let buttonWidth = (UIScreen.main.bounds.width * 0.34)
    static let s_buttonWidth = (UIScreen.main.bounds.width * 0.25)
}

//MARK: - Images
extension DesignSystem {

    enum sysImage: String {
        case noData

        var value: UIImage {
            return UIImage(named: self.rawValue) ?? UIImage()
        }
    }
    
    static func appImage(_ img: sysImage)-> UIImage {
        return img.value
    }
}

//MARK: - Colors
extension DesignSystem {
    
    enum sysColor: String {
        case secondry
        case primary
        
        case white
        case black
        
        case clear
        
        var value: UIColor {
            return UIColor(named: self.rawValue) ?? UIColor.clear
        }
    }
    static func appColor(_ color:sysColor)->UIColor {
        return color.value
    }
}

//MARK: - Fonts
extension DesignSystem {
    enum sysFont {
        case h1
        case h2
        case h3
        case h4
        case h5
        case h6
        case h7
        case h8

     
        enum FontWeight: String {
            case Regular
            case Medium
        }

        //value
        var value:UIFont{
            switch self {
            case .h1:
                return .systemFont(ofSize: 48,weight: .bold)
            case .h2:
                return .systemFont(ofSize: 30,weight: .bold)
            case .h3:
                return .systemFont(ofSize: 24,weight: .medium)
            case .h4:
                return .systemFont(ofSize: 20,weight: .regular)
            case .h5:
                return .systemFont(ofSize: 18,weight: .regular)
            case .h6:
                return .systemFont(ofSize: 16,weight: .regular)
            case .h7:
                return .systemFont(ofSize: 14,weight: .regular)
            case .h8:
                return .systemFont(ofSize: 12,weight: .regular)

            }
        }
    }

    static func appFont(_ font:sysFont)->UIFont{
        return font.value
    }
}
