//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2019-10-17.
//

import Foundation

// MARK: - Wordlist
public struct Wordlist {
    
    public let words: [String]
    public let nameOfLanguage: String
    
    internal init(words: [String], nameOfLanguage: String) {
        
        assert(words.count == Self.count)
        
        self.words = words
        self.nameOfLanguage = nameOfLanguage
    }

    public init(unchecked uncheckedUnsortedWords: [String], nameOfLanguage: String) throws {
        guard uncheckedUnsortedWords.count == Self.count else {
            throw Error.invalidLengthOfWordlist(expectedWordCount: Self.count, butGot: uncheckedUnsortedWords.count)
        }
        
        let uncheckedWordsAscending = uncheckedUnsortedWords.sorted(by: { $0.lexicographicallyPrecedes($1) })
        
        var checkedWords = [String]()
        var lastWord: String?
        for uncheckedWord in uncheckedWordsAscending {
            let checkedWord = try Self.check(word: uncheckedWord, earlierWord: lastWord)
            checkedWords.append(checkedWord)
            lastWord = checkedWord
        }
        
        assert(checkedWords.count == Self.count)
        
        self.init(words: checkedWords, nameOfLanguage: nameOfLanguage)
    }
}

// MARK: - Validate
internal extension Wordlist {
    
    static func unambiguousWords(word alphabeticallyEarlierWord: String, succeededBy succeedingWord: String) -> Bool {
        
        guard
            alphabeticallyEarlierWord.lexicographicallyPrecedes(succeedingWord)
        else {
            print("Words need to be in ascending order, but '\(alphabeticallyEarlierWord)' doe NOT lexicographically precede '\(succeedingWord)'.")
            return false
        }
        
        func relevantSubstring(of fullString: String) -> String {
            String(fullString.prefix(Self.requiredUniqueCharactersForDisambiguation))
        }
            
        let needle = relevantSubstring(of: succeedingWord)
        let haystack = relevantSubstring(of: alphabeticallyEarlierWord)

        return !haystack.starts(with: needle)
    }
        
    static func check(word: String, earlierWord: String? = nil) throws -> String {
        guard
            word.count >= Self.minimumCharacterCountPerWord,
            word.count <= Self.maximumCharacterCountPerWord
            else {
                throw Error.invalidLengthOfWord(
                    minimumCharacterCount: Self.minimumCharacterCountPerWord,
                    maximumCharacterCount: Self.maximumCharacterCountPerWord,
                    butWord: word,
                    hasInvalidLength: word.count
                )
        }
        
        guard let earlierWord = earlierWord else {
            return word
        }
        
        guard unambiguousWords(word: earlierWord, succeededBy: word) else {
            throw Error.ambiguousWord(word, sharedFirstFourCharactersWith: earlierWord)
        }
        
        return word
    }
    
}

// MARK: - Constants
public extension Wordlist {
    static let count: Int = 2048
    
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
