//
//  ProductsCell.swift
//  AssessmentApp
//
//  Created by Moataz on 21/10/2022.
//

import Foundation
import UIKit

class ProductsCell: UICollectionViewCell {
    // MARK: -> UI
    private
    let productImgView: UIImageView = {
        let object = UIImageView()
        object.withRoundedCorner()
        return object
    }()

    private
    let nameLabel: UILabel = {
        let object = UILabel()
        object.prepare(textColor: .black, font: .h7, textAlignment: .center, numberOfLines: 1)
        object.adjustsFontSizeToFitWidth = true
        object.minimumScaleFactor = 0.7
        return object
    }()

    // MARK: ->Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -> setupUI
    private
    func setupUI(){
        let stack = [productImgView, nameLabel].vStacked
        self.contentView.backgroundColor = .clear
        self.contentView.addSubview(stack)
        //Add Constraints
        stack.fillParentConstraints()
        productImgView.withConstraints(withWidth: DesignSystem.halfWidthView, withHeight: DesignSystem.halfWidthView)
    }
    
    // MARK: -> handleCell
    public
    func handleCell(model: Product) {
        productImgView.fromURL(model.imageURL)
        nameLabel.text = model.name
    }
}
