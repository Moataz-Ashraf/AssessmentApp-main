//
//  ScrollView.swift
//  AssessmentApp
//
//  Created by Moataz on 21/10/2022.
//

import Foundation
import UIKit

/* Documentation
 UIScrollView normal usage just add you flexable view vertical or horizontal inside the content view
*/
@IBDesignable
class ScrollView: UIScrollView {
    lazy var contentView: UIView = {
        let object = UIView()
        object.backgroundColor = .clear
        return object
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.addSubview(self.contentView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.withConstraints(leading: 0, trailing: 0, top: 0, bottom: 0,toSafeArea:false)
    }
}

//MARK: - ScrollStack
/* Documentation
 UIScrollView normal usage just add you flexable view vertical or horizontal inside the content view
*/
@IBDesignable
class ScrollStack: ScrollView {
    @IBInspectable public var spacing: CGFloat = DesignSystem.verticalSpace{
        didSet{
            self.stackView.spacing = spacing
        }
    }
    
    lazy var stackView: VStack = {
        let object = VStack()
        object.spacing = spacing
        return object
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.contentView.addSubview(self.stackView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.stackView.fillParentConstraints()
        self.stackView.withConstraints(toView:self.superview!,
                                       leading:DesignSystem.horizontalSpace, trailing: -DesignSystem.horizontalSpace,
                                       centerHorizontal: true)
    }
    
    func addArrangedSubview(_ vw:UIView,withHeight:CGFloat? = nil, heightPercentage:CGFloat? = nil){
        self.stackView.addArrangedSubview(vw, withHeight:withHeight, heightPercentage:heightPercentage)
    }
}
