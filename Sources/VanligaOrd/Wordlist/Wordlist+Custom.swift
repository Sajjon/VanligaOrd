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
