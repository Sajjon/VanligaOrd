//
// MIT License
//
// Copyright (c) 2019- Alexander Cyon ( https://github.com/Sajjon )
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
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
