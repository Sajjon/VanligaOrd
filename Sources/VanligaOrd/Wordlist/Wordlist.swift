//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2019-10-17.
//

import Foundation

// MARK: - Wordlist
public struct Wordlist {
    
    public let words: OrderedSet<String>
    public let nameOfLanguage: String
    
    internal init(words: OrderedSet<String>, nameOfLanguage: String) {
        
        assert(words.count == Self.count)
        
        self.words = words
        self.nameOfLanguage = nameOfLanguage
    }
}

// MARK: - Constants
public extension Wordlist {
    static let count: Int = 2048
    static let bitsOfEntropyPerWords: Int = 11 // 2^11 = 2048
    
    /// According to BIP30 'smart selection of words', each word in the list
    /// needs to be unambiguously identified, using only the first four letters
    ///
    /// https://github.com/bitcoin/bips/blob/master/bip-0039.mediawiki#wordlist
    static let requiredUniqueCharactersForDisambiguation: Int = 4
    
    static let minimumCharacterCountPerWord: Int = 3
    static let maximumCharacterCountPerWord: Int = 8
}

// MARK: - Error
public extension Wordlist {
    enum Error: Swift.Error, Equatable {
        
        case invalidLengthOfWordlist(expectedWordCount: Int, butGot: Int)
        
        case invalidLengthOfWord(
            minimumCharacterCount: Int,
            maximumCharacterCount: Int,
            butWord: String,
            hasInvalidLength: Int
        )
        
        case ambiguousWord(String, sharedFirstFourCharactersWith: String)
        
    }
}
