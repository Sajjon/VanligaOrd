//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2019-10-17.
//

import Foundation

public protocol WordlistForLanguage {
    var nameOfLanguage: String { get }
    var wordlist: Wordlist { get }
}

public extension WordlistForLanguage {
    var nameOfLanguage: String { wordlist.nameOfLanguage }
}
