//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2019-10-18.
//

import Foundation

internal let numberOfBitsPerByte: UInt = 8

extension Data {
    var binaryString: String {
        var result: [String] = []
        for byte in self {
            let byteString = String(byte, radix: 2)
            let padding = String(repeating: "0",
                                 count: 8 - byteString.count)
            result.append(padding + byteString)
        }
        return result.joined()
    }
}
