//
//  UserRequest.swift
//  MyNetworkLayer
//
//  Created by Moataz on 9/22/20.
//  Copyright © 2020 Moataz. All rights reserved.
//

import Foundation

enum UserRouter: URLRequestBuilder {
   
    case products

    // MARK: - Path
    var path: String {
        switch self {
        case .products:
            return "/v3/4e23865c-b464-4259-83a3-061aaee400ba"
        }
    }
    
    // MARK: - Parameters
    var parameters: [String:Any]? {
        switch self {
            
        default:
            return [:]
        }
    }
    
    // MARK: - Methods
    var method: HTTPMethod {
        switch self {
            
        default:
            return HTTPMethod.post
        }
    }
    
    // MARK: - headers
    var headers: [String : String]? {
        switch self {

        default:
            return ["Accept":"application/json","lang":"en"]

        }
    }
    
}
