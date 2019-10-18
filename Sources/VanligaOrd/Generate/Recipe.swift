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

public struct Recipe: CustomStringConvertible {
    public let purpose: Purpose
    
    /// Requested strength measured In bits of entropy
    /// Assuming no one will ever need more than `65556` bits of entropy
    /// Famous last words? 😅
    public let bitsOfEntropy: UInt16
    
    public let language: Language
    
    public init(purpose: Purpose, bitsOfEntropy: UInt16, in language: Language) throws {
        if !language.isOnBip39ListOfLanguages && purpose != .password {
            throw Error.unsupportedLanguage(language, forPurpose: purpose)
        }
        self.purpose = purpose
        self.bitsOfEntropy = bitsOfEntropy
        self.language = language
    }
}

// MARK: Error
public extension Recipe {
    enum Error: Swift.Error {
        case unsupportedLanguage(Language, forPurpose: Purpose)
    }
}

// MARK: Password
public extension Recipe {
    static func password(numberOfWords: Int, in language: Language) -> Recipe {
        
        guard let bitsOfEntropy = UInt16(exactly: numberOfWords * Wordlist.bitsOfEntropyPerWords) else {
            fatalError("Too many words requested max is (2^16)/11 = 5957")
        }
        
        return try! Recipe(
            purpose: .password,
            bitsOfEntropy: bitsOfEntropy,
            in: language
        )
    }
}

// MARK: CustomStringConvertible
public extension Recipe {
    var description: String {
        "\(purpose.description.capitalized) in \(language.description) with entropy of #\(bitsOfEntropy) bits"
    }
}
