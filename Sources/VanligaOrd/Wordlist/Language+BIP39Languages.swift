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

private extension Language {
    init(words: OrderedSet<String>, _ function: String = #function) {
        let wordlist =  Wordlist(words: words, nameOfLanguage: function.capitalized)
        self.init(wordlist: wordlist, isOnBip39ListOfLanguages: true)
    }
}

public extension Language {
    
    // MARK: - 🇨🇳
    static var chineseSimplified: Language {
        .init(wordlist: .init(words: ChineseSimplified.words, nameOfLanguage: "Chinese Simplified"), isOnBip39ListOfLanguages: true)
    }
    
    static var chineseTraditional: Language {
        .init(wordlist: .init(words: ChineseTraditional.words, nameOfLanguage: "Chinese Traditional"), isOnBip39ListOfLanguages: true)
    }
    
    // MARK: - 🇨🇿
    static var czech:  Language { .init(words: Czech.words) }
    
    // MARK: - 🇬🇧
    static var english:  Language { .init(words: English.words) }
    
    // MARK: - 🇫🇷
    static var french:   Language { .init(words: French.words) }
    
    // MARK: - 🇮🇹
    static var italian:  Language { .init(words: Italian.words) }
    
    // MARK: - 🇯🇵
    static var japanese: Language { .init(words: Japanese.words) }
    
    // MARK: - 🇰🇷
    static var korean:   Language { .init(words: Korean.words) }
    
    // MARK: - 🇪🇸
    static var spanish:  Language { .init(words: Spanish.words) }
}

// MARK: - CaseIterable
extension Language: CaseIterable {}
public extension Language {
    static var allCases: [Language] {
        [
            .chineseSimplified,
            .chineseTraditional,
            .czech,
            .english,
            .french,
            .italian,
            .japanese,
            .korean,
            .spanish
        ]
    }
}
