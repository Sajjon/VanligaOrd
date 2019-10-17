//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2019-10-17.
//

import Foundation

public struct Language: WordlistForLanguage {
    
    public let wordlist: Wordlist
    
    init(wordlist: Wordlist) {
        self.wordlist = wordlist
    }
    
}

private extension Language {
    init(words: [String], _ function: String = #function) {
        let wordlist =  Wordlist(words: words, nameOfLanguage: function.capitalized)
        self.init(wordlist: wordlist)
    }
}

public extension Language {
    static var english: Language { .init(words: English.words) }
    static var french: Language { .init(words: French.words) }
}

// MARK: - CaseIterable
extension Language: CaseIterable {}
public extension Language {
    static var allCases: [Language] { [Self.english] }
}

// MARK: - Collection
extension Language: Collection {}
public extension Language {
    typealias Index = Array<String>.Index
    typealias Element = Array<String>.Element
    var startIndex: Index { words.startIndex }
    var endIndex: Index { words.endIndex }

    subscript(position: Index) -> Element {
        get {
            return words[position]
        }
    }
    
    func index(after referenceIndex: Index) -> Index {
        words.index(after: referenceIndex)
    }
}

public extension Language {
    
    var words: [String] { wordlist.words }
    
    var first: Element { words.first! }
    var last: Element { words.last! }
}
