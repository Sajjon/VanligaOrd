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
