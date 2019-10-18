//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2019-10-18.
//

import Foundation

public extension Language {
    static func custom(wordlist: Wordlist) -> Language {
        return Language(wordlist: wordlist, isOnBip39ListOfLanguages: false)
    }
}
