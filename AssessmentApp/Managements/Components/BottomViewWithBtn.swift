//
//  BottomViewWithBtn.swift
//  AssessmentApp
//
//  Created by Moataz on 21/10/2022.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

@IBDesignable
class BottomViewWithBtn: UIView {
    //MARK: - UI
    // HStack
    private
    lazy var hstack: UIView = {
        let obj = [leftLabel, rightButton].hStackedFilled
        obj.layoutMargins = UIEdgeInsets(top: DesignSystem.verticalSpace, left: 0, bottom: DesignSystem.verticalSpace, right: 0)
        obj.isLayoutMarginsRelativeArrangement = true
        return obj
    }()
    // LeftLabel
    private
    let leftLabel: UILabel = {
        let object = UILabel()
        object.prepare(textColor: .black, font: .h3, numberOfLines: 0)
        return object
    }()
    // RightButton
    private
    let rightButton: UIButton = {
        let object = UIButton()
        object.titleLabel?.font = DesignSystem.appFont(.h5)
        object.setTitleColor(DesignSystem.appColor(.white), for: .normal)
        object.backgroundColor = DesignSystem.appColor(.primary)
        object.withRoundedCorner(DesignSystem.buttonHeight*0.3)
        object.alpha = 0.6
        object.contentHorizontalAlignment = .center
        return object
    }()
    
    // MARK: - properties
    public var rightBtnAction = PublishRelay<Void>()
    private let disposeBag = DisposeBag()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
        viewBinding()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = DesignSystem.appColor(.white)
        hstack.fillParentConstraints(widthPercentage: 0.9)
        rightButton.withConstraints(withWidth: DesignSystem.buttonWidth, withHeight: DesignSystem.buttonHeight)
        withRoundedCorner(DesignSystem.buttonHeight*0.4, topEdgesOnly: true, bottomEdgesOnly: false)
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.lightGray.cgColor
    }
    
    //MARK: - SetUP UI
    private func setupUI(){
        self.addSubview(hstack)
    }
    
    //MARK: - Binding
    private func viewBinding() {
        rightButton.rx.tap
            .asObservable()
            .bind(to: rightBtnAction)
            .disposed(by: disposeBag)
    }
    
    //MARK: - Prepare View
    func prepareView(leftText: String, rightButtonText: String) {
        leftLabel.text = "Total: \(leftText) $"
        rightButton.setTitle(rightButtonText, for: .normal)
      
    }
}
