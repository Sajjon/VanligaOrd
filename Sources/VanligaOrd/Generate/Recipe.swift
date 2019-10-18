//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2019-10-18.
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
