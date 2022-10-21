//
//  HTTPMethod.swift
//  TaskVWN
//
//  Created by Moataz on 27/06/2022.
//

import Foundation

enum HTTPMethod {
    case get
    case post

    var rawValue: String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        }
    }

}
