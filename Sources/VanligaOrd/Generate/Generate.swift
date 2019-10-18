//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2019-10-18.
//

import Foundation

public struct Generator {
    public let purpose: Purpose
    public init(purpose: Purpose) {
        self.purpose = purpose
    }
}

public extension Generator {
    func generate() throws -> SecurelyGeneratedWords {
        switch purpose {
        case .password(let passwordPurpose):
            switch passwordPurpose {
            case .strength(let bitsOfEntropy, let language):
                return try generateWords(purpose: purpose, bitsOfEntropy: bitsOfEntropy, in: language)
            }
        }
    }
}

private extension Generator {
    func generateWords(
        purpose: Purpose,
        bitsOfEntropy: Int,
        in language: Language
    ) throws -> SecurelyGeneratedWords {
        let bitArray = try securelyGenerateBits(count: bitsOfEntropy)
        return generateWords(purpose: purpose, securelyRandomlyGeneratedBitArray: bitArray, in: language)
    }
    
    func generateWords(
        purpose: Purpose,
        securelyRandomlyGeneratedBitArray bitArray: BitArray,
        in language: Language
    ) -> SecurelyGeneratedWords {

        let wordlist = language.words

        let wordIndices = bitArray.splitIntoChunks(ofSize: Wordlist.bitsOfEntropyPerWords)
            .map { UInt11(bitArray: $0)! }
            .map { $0.asInt }
        
        let randomWords: [String] = wordIndices.map { wordlist[$0] }
        
        return SecurelyGeneratedWords(words: randomWords, purpose: purpose)
    }
}

public enum Purpose {
    indirect case password(Password)
    
    //    indirect case bip39(BIP39) // BIP39 mnemonic not implemented yet
    
}
public extension Purpose {
    enum Password {
        case strength(bitsOfEntropy: Int, inLanguage: Language)
    }
}

public extension Purpose.Password {
    static func numberOfWords(_ numberOfWords: Int, inLanguage language: Language) -> Purpose.Password {
        return .strength(
            bitsOfEntropy: numberOfWords * Wordlist.bitsOfEntropyPerWords,
            inLanguage: language
        )
    }
}

public struct SecurelyGeneratedWords: CustomStringConvertible {
    public let words: [String]
    public init(words: [String], purpose: Purpose) {
        self.words = words
    }
}

public extension SecurelyGeneratedWords {
    var description: String {
        "Omitted for security purposes"
    }
}

#if DEBUG
extension SecurelyGeneratedWords: CustomDebugStringConvertible {
    public var debugDescription: String {
        words.joined(separator: " ")
    }
}
#endif
