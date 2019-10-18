//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2019-10-18.
//

import Foundation
import Security

public func securelyGenerateBytes(count unsignedCount: UInt) throws -> Data {
    let count = Int(unsignedCount)
    var randomBytes = [UInt8](repeating: 0, count: count)
    let statusRaw = SecRandomCopyBytes(kSecRandomDefault, count, &randomBytes) as OSStatus
    let status = Status(status: statusRaw)
    guard status == .success else { throw status }
    return Data(randomBytes)
}

public func securelyGenerateBits(count numberOfBits: UInt) throws -> BitArray {
    let bitArray: BitArray
    if numberOfBits.isMultiple(of: numberOfBitsPerByte) {
        let data = try securelyGenerateBytes(count: numberOfBits/numberOfBitsPerByte)
        bitArray = BitArray(data: data)
    } else {
        // its complicated
        let (quotient, _) = numberOfBits.quotientAndRemainder(dividingBy: numberOfBitsPerByte)
        let tooMuchData = try securelyGenerateBytes(count: quotient + 1)
        let tooLongBitArray = BitArray(data: tooMuchData)
        bitArray = BitArray(tooLongBitArray.prefix(Int(numberOfBits)))
    }
    
    return bitArray
}
