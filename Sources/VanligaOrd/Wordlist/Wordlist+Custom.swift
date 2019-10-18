//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2019-10-18.
//

import Foundation

// MARK: - Custom list
public extension Wordlist {
    init(unchecked uncheckedUnsortedWords: OrderedSet<String>, nameOfLanguage: String) throws {
        guard uncheckedUnsortedWords.count == Self.count else {
            throw Error.invalidLengthOfWordlist(expectedWordCount: Self.count, butGot: uncheckedUnsortedWords.count)
        }
        
        let uncheckedWordsAscending = uncheckedUnsortedWords.sorted(by: { $0.lexicographicallyPrecedes($1) })
        
        var checkedWords = OrderedSet<String>()
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

internal extension Wordlist {
    
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
    
    
}
