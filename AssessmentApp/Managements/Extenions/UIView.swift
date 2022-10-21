//
//  UIView.swift
//  AssessmentApp
//
//  Created by Moataz on 21/10/2022.
//

import Foundation
import UIKit

extension UIView {
    //MARK: - Constraints
    func fillParentConstraints(widthPercentage:CGFloat = 1,heightPercentage:CGFloat = 1){
        guard let superview = self.superview else{return}
        self.centerXAnchor.constraint(equalTo:  superview.centerXAnchor).isActive = true
        self.centerYAnchor.constraint(equalTo:  superview.centerYAnchor).isActive = true
        
        self.widthAnchor.constraint(equalTo:  superview.widthAnchor, multiplier: widthPercentage).isActive = true
        self.heightAnchor.constraint(equalTo:  superview.heightAnchor, multiplier: heightPercentage).isActive = true
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    // Constraints Function
    func withConstraints(toView:UIView? = nil,
                         leading:CGFloat? = nil, trailing:CGFloat? = nil,
                         top:CGFloat? = nil, bottom:CGFloat? = nil,
                         
                         withWidth:CGFloat? = nil, withHeight:CGFloat? = nil,
                         
                         minWidth:CGFloat? = nil, minHeight:CGFloat? = nil,
                         maxWidth:CGFloat? = nil, maxHeight:CGFloat? = nil,
                         
                         widthPercentage:CGFloat? = nil, heightPercentage:CGFloat? = nil,
                         
                         centerVertical:Bool = false,centerHorizontal:Bool = false,
                         
                         leadingToViewTrailing:CGFloat? = nil, trailingToViewLeading:CGFloat? = nil,
                         topToViewBottom:CGFloat? = nil, bottomToViewTop:CGFloat? = nil,
                         toSafeArea:Bool = true){
        
        guard let superview = toView ?? self.superview else{return}
        
        //Normal
        if let leading = leading{
            self.leadingAnchor.constraint(equalTo:  !toSafeArea ? superview.leadingAnchor:superview.safeAreaLayoutGuide.leadingAnchor,constant: leading).isActive = true
        }
        if let trailing = trailing{
            self.trailingAnchor.constraint(equalTo:  !toSafeArea  ? superview.trailingAnchor:superview.safeAreaLayoutGuide.trailingAnchor,constant: trailing).isActive = true
        }
        if let top = top{
            self.topAnchor.constraint(equalTo:  !toSafeArea  ? superview.topAnchor:superview.safeAreaLayoutGuide.topAnchor,constant: top).isActive = true
        }
        if let bottom = bottom{
            self.bottomAnchor.constraint(equalTo:  !toSafeArea  ? superview.bottomAnchor:superview.safeAreaLayoutGuide.bottomAnchor,constant: bottom).isActive = true
        }
        
        //Upnormal
        if let leadingToViewTrailing = leadingToViewTrailing{
            self.leadingAnchor.constraint(equalTo:  !toSafeArea  ? superview.trailingAnchor:superview.safeAreaLayoutGuide.trailingAnchor,constant: leadingToViewTrailing).isActive = true
        }
        if let trailingToViewLeading = trailingToViewLeading{
            self.trailingAnchor.constraint(equalTo:  !toSafeArea  ? superview.leadingAnchor:superview.safeAreaLayoutGuide.leadingAnchor,constant: trailingToViewLeading).isActive = true
        }
        if let topToViewBottom = topToViewBottom{
            self.topAnchor.constraint(equalTo:  !toSafeArea  ? superview.bottomAnchor:superview.safeAreaLayoutGuide.bottomAnchor,constant: topToViewBottom).isActive = true
        }
        if let bottomToViewTop = bottomToViewTop{
            self.bottomAnchor.constraint(equalTo:  !toSafeArea  ? superview.topAnchor:superview.safeAreaLayoutGuide.topAnchor,constant: bottomToViewTop).isActive = true
        }
        
        //Centering
        if centerVertical{
            self.centerYAnchor.constraint(equalTo:  superview.centerYAnchor).isActive = true
        }
        if centerHorizontal{
            self.centerXAnchor.constraint(equalTo:  superview.centerXAnchor).isActive = true
        }
        
        //withExactSizeConstraints
        if let withWidth = withWidth{
            self.widthAnchor.constraint(equalToConstant: withWidth).isActive = true
        }
        if let withHeight = withHeight{
            self.heightAnchor.constraint(equalToConstant: withHeight).isActive = true
        }
        
        //Min size
        if let minWidth = minWidth {
            self.widthAnchor.constraint(greaterThanOrEqualToConstant: minWidth).isActive = true
        }
        if let minHeight = minHeight {
            self.heightAnchor.constraint(greaterThanOrEqualToConstant: minHeight).isActive = true
        }
        
        //Max size
        if let maxWidth = maxWidth {
            self.widthAnchor.constraint(lessThanOrEqualToConstant: maxWidth).isActive = true
        }
        if let maxHeight = maxHeight {
            self.heightAnchor.constraint(lessThanOrEqualToConstant: maxHeight).isActive = true
        }
        
        if let widthPercentage = widthPercentage{
            self.widthAnchor.constraint(equalTo:  superview.widthAnchor, multiplier: widthPercentage).isActive = true
        }
        if let heightPercentage = heightPercentage{
            self.heightAnchor.constraint(equalTo:  superview.heightAnchor, multiplier: heightPercentage).isActive = true
        }
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

//MARK: - UIView where Array
extension Array where Element : UIView {
    //MARK: Horizontal Stack
    var hStacked: HStack {
        let object = HStack()
        self.forEach({object.addArrangedSubview($0)})
        return object
    }
    
    //MARK: Horizontal Stack with Fill
    var hStackedFilled: HStack {
        let object = hStacked
        object.distribution = .fill
        return object
    }
    
    //MARK: Vertical Stack
    var vStacked: VStack {
        let object = VStack()
        self.forEach({object.addArrangedSubview($0)})
        return object
    }
}

//MARK: - Design
extension UIView {
    //MARK: withRoundedCorner
    func withRoundedCorner(_ radius: CGFloat = DesignSystem.halfWidthView*0.35,topEdgesOnly:Bool = false,bottomEdgesOnly:Bool = false) {
        if topEdgesOnly {
            self.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        }
        if bottomEdgesOnly {
            self.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        }
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
}
