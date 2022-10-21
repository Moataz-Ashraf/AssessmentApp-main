//
//  UICollectionView.swift
//  AssessmentApp
//
//  Created by Moataz on 21/10/2022.
//

import Foundation
import UIKit

//MARK: - UICollectionView
extension UICollectionView {
    func setEmptyMessage() {
        let object = EmptyMessage(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        self.backgroundView = object;
    }

    func removeEmptyMessage() {
        self.backgroundView = nil
    }
}

 class ContentSizedCollectionView: UICollectionView {
    override var contentSize:CGSize {
        didSet {
            invalidateIntrinsicContentSize()
            
            self.backgroundColor = .clear
            self.isScrollEnabled = false
        }
    }

    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}

class ContentSizedCollectionViewWithDefaultSize: ContentSizedCollectionView {
    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        let height = ((contentSize.height > 0) ? contentSize.height:(UIScreen.main.bounds.height*0.6))

        return CGSize(width: UIView.noIntrinsicMetric, height: height)
    }
}
