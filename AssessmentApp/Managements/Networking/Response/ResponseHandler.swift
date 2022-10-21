//
//  ResponseHandler.swift
//  MyNetworkLayer
//
//  Created by Moataz on 9/22/20.
//  Copyright © 2020 Moataz. All rights reserved.
//

import Foundation

protocol HandleResponse {
    /// Handles request response, never called anywhere but APIRequestHandler
    ///
    /// - Parameters:
    ///   - data: Data from network request, for now  Data response
    ///   - completion: completing processing the json response, and delivering it in the completion handler
    func handleResponse<T: CodableInit>(_ data: Data) throws -> T
}

extension HandleResponse {
    
    func handleResponse<T: CodableInit>(_ data: Data) throws -> T {

        do {
            let modules = try T(data: data)
            return modules

        } catch {
            debugPrint(error)
            throw APIError.DecodeDataFailure

        }

    }
    
}




