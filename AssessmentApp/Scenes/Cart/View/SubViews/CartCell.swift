//
//  CartCell.swift
//  AssessmentApp
//
//  Created by Moataz on 21/10/2022.
//

import UIKit
import RxCocoa
import RxSwift

class CartCell: UITableViewCell {
    // ProductImgView - UIImageView -
    private
    let productImgView: UIImageView = {
        let object = UIImageView()
        object.withRoundedCorner((DesignSystem.halfWidthView*0.5)*0.3)
        return object
    }()
    // NameLabel - UILabel -
    private
    let nameLabel: UILabel = {
        let object = UILabel()
        object.prepare(textColor: .black, font: .h5, numberOfLines: 1)
        object.adjustsFontSizeToFitWidth = true
        object.minimumScaleFactor = 0.7
        return object
    }()
    // PriceLabel - UILabel -
    private
    let priceLabel: UILabel = {
        let object = UILabel()
        object.prepare(textColor: .secondry, font: .h6, numberOfLines: 1)
        object.adjustsFontSizeToFitWidth = true
        object.minimumScaleFactor = 0.7
        return object
    }()
    // SubVStack - UIStackView -
    private lazy
    var subStack: UIStackView = {
        let stack = VStack()
        stack.layoutMargins = UIEdgeInsets(top: DesignSystem.verticalSpace, left: 0, bottom: DesignSystem.verticalSpace, right: 0)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.addArrangedSubview(nameLabel)
        stack.addArrangedSubview(priceLabel)
        return stack
    }()
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    //MARK: - SetupView
    private func setupView() {
        contentView.addSubview([productImgView, subStack].hStackedFilled)
        productImgView.superview?.fillParentConstraints(heightPercentage: 0.8)
        productImgView.withConstraints(top: 0, bottom: 0, withWidth: DesignSystem.halfWidthView*0.5, withHeight: DesignSystem.halfWidthView*0.5)
        backgroundColor = DesignSystem.appColor(.secondry)
        contentView.backgroundColor = DesignSystem.appColor(.white)
        contentView.withConstraints(leading: 0, trailing: 0, top: 0, bottom: -1, toSafeArea: true)
        selectionStyle = .none
    }
    
    //MARK: - HandleCell
    public func handleCell(model: CartProduct) {
        print(model)
        productImgView.fromURL(model.imageURL)
        nameLabel.text = model.name
        priceLabel.text = "\(model.retailPrice) $"
    }
}
