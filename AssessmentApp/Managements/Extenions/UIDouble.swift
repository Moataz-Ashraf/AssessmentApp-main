//
//  UIDouble.swift
//  AssessmentApp
//
//  Created by Moataz on 21/10/2022.
//

import Foundation

extension Array where Element == Double {
    func sum() -> String {
        var res: Double = 0.0
        self.forEach { num in
            res += num
        }
        return "\(res)"
    }
}
