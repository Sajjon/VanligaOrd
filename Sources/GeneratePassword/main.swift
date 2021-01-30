//
//  File.swift
//  
//
//  Created by Alexander Cyon on 2021-01-30.
//

import Foundation
import VanligaOrd

func outputStrongPassword() {
    let numberOfWords = 7
    let width = 10 * numberOfWords
    func printRepeating(char: String, halfWidth: Bool = false) {
        let count = Double(width) * (halfWidth ? 0.5 : 1.0)
        print(String(repeating: char, count: Int(count)))
    }
    print("\n")
    printRepeating(char: "=")
    print("Be Safe 🛡")
    printRepeating(char: "-")
    let passwordGenerator = Generator.ofPassword(in: .english, numberOfWords: numberOfWords)
    let password = passwordGenerator.generate()
    print(password.recipe)
    let attackerStrength: AttackerStrength = .botNet
    let timeUntilCracked = password.timeUntilCracked(attackerStrength: attackerStrength)
    print([
        "\n",
        "Time until cracked: ~\(timeUntilCracked)\n",
        "(\n",
        "\tAssuming attacker strength:\n",
        "\t\(attackerStrength) (\(attackerStrength.rawValue) guesses/s)",
        "\n)\n"
    ].joined())
    
    let ornament = "🔑"
    printRepeating(char: ornament, halfWidth: true)

    let passwordJoined = password.joined()
    let numberOfSpacesTotal = (width - passwordJoined.count - 2*2*ornament.count)
    let numberOfSpacesPerSide = Int(round(Double(numberOfSpacesTotal / 2)))
    let spacing = String(repeating: " ", count: numberOfSpacesPerSide)
    
    print([
        ornament,
        spacing,
        passwordJoined,
        spacing,
        ornament
    ].joined())
    
    printRepeating(char: ornament, halfWidth: true)
    
    print("\n")
    print("🔐💪 Cryptographically secure")
    print("🧠💡 Easy to remember")
    printRepeating(char: "=")
    print("\n")
}

outputStrongPassword()
