//
//  EmptyMessageView.swift
//  AssessmentApp
//
//  Created by Moataz on 21/10/2022.
//

import Foundation
import UIKit

@IBDesignable
class EmptyMessage: UIView {
    //MARK: - UI
    
    lazy private var image: UIImageView = {
        let object = UIImageView(image: DesignSystem.appImage(.noData))
        object.contentMode = .scaleAspectFit
        return object
    }()
    lazy private var label: UILabel = {
        let object = UILabel()
        object.prepare(textColor: .black, font: .h5, textAlignment: .center)
        object.text = "No Data Found"
        return object
    }()
    lazy private var mainStack: UIStackView = {
        let object = [image, label].vStacked
        return object
    }()

    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .clear
        image.withConstraints(top: 0,
                              withWidth: DesignSystem.halfWidthView*0.5, withHeight: DesignSystem.halfWidthView*0.5)
        mainStack.withConstraints(leading: DesignSystem.horizontalSpace,centerVertical: true,centerHorizontal: true)
        
    }
    
    private func setupUI(){
        self.addSubview(mainStack)
        
    }

}
