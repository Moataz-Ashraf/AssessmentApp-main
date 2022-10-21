//
//  URLRequestBuilder.swift
//  MyNetworkLayer
//
//  Created by Moataz on 9/22/20.
//  Copyright © 2020 Moataz. All rights reserved.
//

import Foundation

protocol URLRequestBuilder: APIRequestHandler {
    
    var mainURL: URL { get }
    var requestURL: URL { get }
    // MARK: - Path
    var path: String { get }
    
    // MARK: - Parameters
    var parameters: [String: Any]? { get }

    // MARK: - The headers to be used in the request.
    
    var headers: [String: String]? { get }
    
    // MARK: - Methods
    var method: HTTPMethod { get }
    
    var urlRequest: URLRequest { get }
}


extension URLRequestBuilder {
    
    var mainURL: URL {
        return URL(string:"https://run.mocky.io")!
    }

    var requestURL: URL {
        return mainURL.appendingPathComponent(path)
    }
    
    var urlRequest: URLRequest {
        var components = URLComponents(url: requestURL, resolvingAgainstBaseURL: false)!
            components.queryItems = parameters!.map { (key, value) in
            URLQueryItem(name: key, value: "\(value)")
        }

        var request = URLRequest(url: components.url!)
            request.httpMethod = method.rawValue
            request.allHTTPHeaderFields = self.headers

        return request
    }

}
