//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2019-10-18.
//

import Foundation

public struct SecurelyGeneratedWords {
    public let words: [String]
    public let recipe: Recipe
    public init(words: [String], recipe: Recipe) {
        self.words = words
        self.recipe = recipe
    }
}

public extension SecurelyGeneratedWords {
    func joined(separator: String = " ") -> String {
        words.joined(separator: separator)
    }
}
