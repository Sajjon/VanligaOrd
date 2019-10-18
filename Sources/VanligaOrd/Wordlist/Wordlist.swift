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
