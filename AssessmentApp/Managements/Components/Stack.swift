//
//  Stack.swift
//  AssessmentApp
//
//  Created by Moataz on 21/10/2022.
//

import Foundation
import UIKit

@IBDesignable
class HStack: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .clear
        
    }
    
    private func setupUI() {
        self.axis = .horizontal
        self.spacing = DesignSystem.horizontalSpace
        self.distribution = .fillEqually
    }
    
    func addArrangedSubview(_ vw:UIView,withWidth:CGFloat? = nil, widthPercentage:CGFloat? = nil){
        self.addArrangedSubview(vw)
        
        //Constraints
        if let withWidth = withWidth{
            vw.withConstraints(withWidth: withWidth)
        }else if let widthPercentage = widthPercentage {
            vw.withConstraints(withWidth: ( UIScreen.main.bounds.width * widthPercentage))
        }
    }
}

class VStack: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .clear
        
    }
    
    private func setupUI(){
        self.axis = .vertical
        self.spacing = DesignSystem.verticalSpace
    }
    
    
    func addArrangedSubview(_ vw:UIView,withHeight:CGFloat? = nil, heightPercentage:CGFloat? = nil){
        self.addArrangedSubview(vw)
        
        //Constraints
        if let withHeight = withHeight {
            vw.withConstraints(withHeight: withHeight)
        }else if let heightPercentage = heightPercentage{
            vw.withConstraints(withHeight: ( UIScreen.main.bounds.height * heightPercentage))
        }
    }
}
