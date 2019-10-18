//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2019-10-18.
//

import Foundation

public struct Generator {
    public let recipe: Recipe
    public init(recipe: Recipe) {
        self.recipe = recipe
    }
}

public extension Generator {
    static func ofPassword(in language: Language, numberOfWords: Int) -> Generator {
        .init(recipe: .password(numberOfWords: numberOfWords, in: language))
    }
}

public extension Generator {
    func generate() -> SecurelyGeneratedWords {
        switch recipe.purpose {
        case .password:
            return generateWords(recipe: recipe)
        }
    }
}

// MARK: - Private
private extension Generator {
    func generateWords(recipe: Recipe) -> SecurelyGeneratedWords {
        do {
            let bitArray = try securelyGenerateBits(count: UInt(recipe.bitsOfEntropy))
            
            return generateWords(
                recipe: recipe,
                securelyRandomlyGeneratedBitArray: bitArray
            )
            
        } catch {
            fatalError("`SecRandomCopyBytes` failed to generate bytes, error: \(error), read more: https://developer.apple.com/documentation/security/1399291-secrandomcopybytes")
        }
    }
    
    func generateWords(
        recipe: Recipe,
        securelyRandomlyGeneratedBitArray bitArray: BitArray
    ) -> SecurelyGeneratedWords {

        let wordlist = recipe.language.words

        let wordIndices = bitArray.splitIntoChunks(ofSize: Wordlist.bitsOfEntropyPerWords)
            .map { UInt11(bitArray: $0)! }
            .map { $0.asInt }
        
        let randomWords: [String] = wordIndices.map { wordlist[$0] }
        
        return SecurelyGeneratedWords(words: randomWords, recipe: recipe)
    }
}
