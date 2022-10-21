//
//  UITableView.swift
//  AssessmentApp
//
//  Created by Moataz on 21/10/2022.
//

import Foundation
import UIKit

//MARK: - UITableView
extension UITableView {
    func setEmptyMessage() {
        let object = EmptyMessage(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        self.backgroundView = object;
    }

    func removeEmptyMessage() {
        self.backgroundView = nil
    }
}

//MARK: - ContentSizedTableView
class ContentSizedTableView: UITableView {
    init(backgroundColor: DesignSystem.sysColor = .clear,
         separatorStyle: UITableViewCell.SeparatorStyle = .none){
        super.init(frame: .zero, style: .plain)
        
        self.backgroundColor = DesignSystem.appColor(.white)
        self.separatorStyle = separatorStyle
        self.isScrollEnabled = false
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var contentSize:CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }

    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}

//MARK: - ContentSizedTableViewWithDefaultSize
class ContentSizedTableViewWithDefaultSize: ContentSizedTableView {
    let defaultHeight: CGFloat
    
    init(backgroundColor: DesignSystem.sysColor = .clear,
         separatorStyle: UITableViewCell.SeparatorStyle = .none,
         defaultHeight: CGFloat = (UIScreen.main.bounds.height*0.6)){
        
        self.defaultHeight = defaultHeight
        super.init(backgroundColor: backgroundColor, separatorStyle: separatorStyle)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        let height = ((contentSize.height > 0) ? contentSize.height: defaultHeight)

        return CGSize(width: UIView.noIntrinsicMetric, height: height)
    }
}
