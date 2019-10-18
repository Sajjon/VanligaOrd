//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2019-10-18.
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
