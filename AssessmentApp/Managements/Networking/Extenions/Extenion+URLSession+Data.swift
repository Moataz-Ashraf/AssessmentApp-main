//
//  Extenion+Session+Data.swift
//  TaskVWN
//
//  Created by Moataz on 27/06/2022.
//
import UIKit

extension URLSession {
    func dataa(from url: URLRequest) async throws -> (Data, URLResponse) {
        return try await withCheckedThrowingContinuation{ continuation in
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data,
                      let response = response
                else {
                    continuation.resume(throwing: APIError.NoInternetConnection)
                    return
                }
                continuation.resume(returning: (data, response))
                return
            }
            .resume()
        }
    }
}

extension Data {
    mutating func addMultiPart(boundary: String, name: String, filename: String, contentType: String, data: Data) {
        print("adding boundary: \(boundary), name: \(name), filename: \(filename), contentType: \(contentType) data length: \(data.count) ")
        self.append("Content-Disposition: form-data; name=\"\(name)\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
        self.append("Content-Type: \(contentType)\r\n\r\n".data(using: .utf8)!)
        self.append(data)
    }
    mutating func addMultiPartStart(boundary: String) {
        self.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
    }
    mutating func addMultiPartEnd(boundary: String) {
        self.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
    }
}

