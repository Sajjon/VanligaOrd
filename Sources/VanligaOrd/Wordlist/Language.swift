//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2019-10-17.
//

import Foundation

public struct Language: WordlistForLanguage, CustomStringConvertible {
    
    public let wordlist: Wordlist

    /// https://github.com/bitcoin/bips/blob/master/bip-0039/bip-0039-wordlists.md
    public let isOnBip39ListOfLanguages: Bool
    
    internal init(wordlist: Wordlist, isOnBip39ListOfLanguages: Bool) {
        self.wordlist = wordlist
        self.isOnBip39ListOfLanguages = isOnBip39ListOfLanguages
    }
}

// MARK: CustomStringConvertible
public extension Language {
    var description: String { wordlist.nameOfLanguage }
}

