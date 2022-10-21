//
//  APIRequestHandler.swift
//  MyNetworkLayer
//
//  Created by Moataz on 9/22/20.
//  Copyright © 2020 Moataz. All rights reserved.
//

import Foundation

/// API protocol, The API wrapper
protocol APIRequestHandler: HandleResponse { }

extension APIRequestHandler where Self: URLRequestBuilder {

    func send<T: CodableInit>(_ decoder: T.Type, data: UploadData? = nil, ArrData: [UploadData]? = nil, progress: ((Progress) -> Void)? = nil) async throws -> T {
        if let data = data {
            return try await uploadToServerWith(decoder, data: data, request: urlRequest, parameters: self.parameters!, progress: progress)

        }else if let ArrData = ArrData {
            return try await uploadToServerWithArr(decoder, data: ArrData, request: urlRequest, parameters: self.parameters!, progress: progress)

        }else {
            let (data, _) = try await URLSession.shared.dataa(from: urlRequest)
            return try self.handleResponse(data)

        }
    }
    
    func cancelRequest() -> Void  {
        let sessionManager = URLSession.shared
        sessionManager.getTasksWithCompletionHandler { dataTasks, uploadTasks, downloadTasks in
            dataTasks.first(where: { $0.originalRequest?.url == self.requestURL})?.cancel()
            uploadTasks.first(where: { $0.originalRequest?.url == self.requestURL})?.cancel()
            downloadTasks.first(where: { $0.originalRequest?.url == self.requestURL})?.cancel()

        }
    }
}


extension APIRequestHandler {

    private func uploadToServerWith<T: CodableInit>(_ decoder: T.Type, data: UploadData, request: URLRequest, parameters: [String:Any], progress: ((Progress) -> Void)?) async throws -> T {

        let boundary = UUID().uuidString
        var CurRequest = request
        CurRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        var tempData = Data()
        tempData.addMultiPartStart(boundary: boundary)
        tempData.addMultiPart(boundary: boundary, name: data.name, filename: data.fileName, contentType: data.mimeType, data: data.data)
        tempData.addMultiPartEnd(boundary: boundary)
        CurRequest.httpBody = tempData

        let (Curdata, _) = try await URLSession.shared.dataa(from: CurRequest)

        return try self.handleResponse(Curdata)

    }

    private func uploadToServerWithArr<T: CodableInit>(_ decoder: T.Type, data: [UploadData], request: URLRequest, parameters: [String:Any], progress: ((Progress) -> Void)?) async throws -> T {

        let boundary = UUID().uuidString
        var CurRequest = request
        CurRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        var tempData = Data()
        tempData.addMultiPartStart(boundary: boundary)

        for CuData in data{
            tempData.addMultiPart(boundary: boundary, name: CuData.name, filename: CuData.fileName, contentType: CuData.mimeType, data: CuData.data)
        }

        tempData.addMultiPartEnd(boundary: boundary)
        CurRequest.httpBody = tempData

        let (Curdata, _) = try await URLSession.shared.dataa(from: CurRequest)
        return try self.handleResponse(Curdata)

    }
    
}


