//
//  UIString.swift
//  AssessmentApp
//
//  Created by Moataz on 21/10/2022.
//

import Foundation
import UIKit

extension String {
    //  CollectionView Cell identifiers
    enum Identifier: String {
        case ProductsCellId
        case CartCellId

        var value: String {
            return self.rawValue
        }
    }
}
