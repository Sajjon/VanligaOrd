//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2019-10-18.
//

import Foundation

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
    var words: [String] { wordlist.words.contents }
    var first: Element { words.first! }
    var last: Element { words.last! }
}
