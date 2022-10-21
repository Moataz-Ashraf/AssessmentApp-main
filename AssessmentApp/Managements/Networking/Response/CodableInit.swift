//
//  CodableInit.swift
//  MyNetworkLayer
//
//  Created by Moataz on 9/22/20.
//  Copyright © 2020 Moataz. All rights reserved.
//

import Foundation

protocol CodableInit {
    init(data: Data) throws
}

extension CodableInit where Self: Codable {
    init(data: Data) throws {
        print(data)
        let decoder = JSONDecoder()

        self = try decoder.decode(Self.self, from: data)
    }
}
