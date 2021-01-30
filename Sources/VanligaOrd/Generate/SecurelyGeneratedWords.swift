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
import Darwin

/// The strength of the attacker trying to brute force crack your password
/// Measured in guesses/second. Please refer to [brute force table][bruteForce].
///
/// [bruteForce]: https://www.reddit.com/r/dataisbeautiful/comments/322lbk/time_required_to_bruteforce_crack_a_password/
///
public enum AttackerStrength: Double, CustomStringConvertible {

    /// Bitcoin - the most powerful network on earth.
    ///
    /// The Bitcoin network as a whole has a computing power of
    /// ~150 exa hashes per seconds (as per 2021-01-30). Meaning
    /// it is capable of performing 150,000,000,000,000,000,000
    /// SHA hashes per second, see [hashrate table][table]
    ///
    /// [table]: https://bitinfocharts.com/comparison/bitcoin-hashrate.html
    ///
    case bitcoin = 150_000_000_000_000_000_000
    
    /// A powerful network of strong computers.
    case powerfulBotNet = 100_000_000_000_000
    
    /// A network of strong computers.
    case botNet = 1_000_000_000_000
    
    /// A single strong computer.
    case strongComputer = 100_000_000_000
}

public extension AttackerStrength {
    
    static let strongest = bitcoin
    
    var description: String {
        switch self {
        case .bitcoin:
            return "Bitcoin - the most powerful network on earth."
        case .powerfulBotNet:
            return "A powerful network of strong computers."
        case .botNet:
            return "A network of strong computers."
        case .strongComputer:
            return "A single strong computer."
        }
    }
}

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
    
    func timeUntilCracked(attackerStrength: AttackerStrength = .strongest) -> String {
        return Self.timeUntilCracked(entropy: self.recipe.bitsOfEntropy, attackerStrength: attackerStrength)
    }
}

private extension SecurelyGeneratedWords {
    static func timeUntilCracked(entropy: UInt16, attackerStrength: AttackerStrength) -> String {
        let untilCrackedSeconds = secondsUntilCracked(entropy: entropy, attackerStrength: attackerStrength)
        
        let dateComponentsFormatter = DateComponentsFormatter()
        dateComponentsFormatter.maximumUnitCount = 1
        dateComponentsFormatter.unitsStyle = .full
        guard let dateComponentsString = dateComponentsFormatter.string(from: TimeInterval(untilCrackedSeconds)) else {
            return "unknown"
        }
        
        return dateComponentsString
    }
    
    static func secondsUntilCracked(entropy: UInt16, attackerStrength: AttackerStrength) -> UInt {
        let guessesPerSeconds = attackerStrength.rawValue
        let seconds = pow(2, Double(entropy)) / guessesPerSeconds
        return UInt(seconds)
    }
}
