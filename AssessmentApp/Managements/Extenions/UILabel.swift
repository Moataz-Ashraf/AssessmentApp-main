//
//  UILabel.swift
//  AssessmentApp
//
//  Created by Moataz on 21/10/2022.
//

import UIKit

extension UILabel{
    func prepare(textColor: DesignSystem.sysColor,
                 font: DesignSystem.sysFont,
                 textAlignment: NSTextAlignment = .natural,
                 numberOfLines:Int = 0,
                 lineBreakMode:NSLineBreakMode = .byWordWrapping) {
        
        self.textColor = DesignSystem.appColor(textColor)
        self.font = DesignSystem.appFont(font)
        self.textAlignment = textAlignment
        self.lineBreakMode = lineBreakMode
        self.numberOfLines = numberOfLines
    }
}
