# Be Safe 🛡
<p align="left">
<a href="https://swift.org/package-manager/"><img src="https://img.shields.io/badge/SPM-supported-blue.svg?style=flat"></a>
<a href="https://https://github.com/Sajjon/VanligaOrd/blob/master/LICENSE"><img src="https://img.shields.io/badge/License-MIT-yellow.svg"></a>
</p>

### Generate passwords that are
#### 🔐💪 Cryptographically secure 
#### 🧠💡 Easy to remember 

A minimal [BIP39](https://github.com/bitcoin/bips/blob/master/bip-0039.mediawiki) compatible library for generation of common words as password or BIP39 mnemonic.

<p align="center">
<a href="https://xkcd.com/936"><img src="https://imgs.xkcd.com/comics/password_strength.png" alt="Xkcd 936" title="Password security" width="600"/>
</p>

## Recommended Strength

Reddit user `HelmedHorror` has created this amazing table about password strength.

<p align="center">
<a href="https://www.reddit.com/r/dataisbeautiful/comments/322lbk/time_required_to_bruteforce_crack_a_password"><img src="http://i.imgur.com/gfYw57t.png" alt="Reddit" title="Entropy" width="1400"/>
</p>

[In 2012 a cluster of 25 GPUs achived a hashrate of 10^12](https://arstechnica.com/%20information-technology/2012/12/25-gpu-cluster-cracks-every-standard-windows-password-in-6-hours/). Due to exponential growth in computer power ([Moore’s law](https://en.wikipedia.org/wiki/Moore%27s_law)), we are over 10^13 in 2019 (time of writing). To generate a safe password it is thus recommended you achive 80 bits of entropy.

### Required word count

| Bits                                  | 60   | 62  | 64  | 66   | 68  | 70  | 72  | 74   | 76   | 78    | 80      | 82      | 84       | 86       |
|---------------------------------------|------|-----|-----|------|-----|-----|-----|------|------|-------|---------|---------|----------|----------|
| Time until cracked                    | 13 h | 2 d | 8 d | 34 d | 4 m | 1 y | 6 y | 24 y | 96 y | 383 y | 1,500 y | 6,100 y | 25,000 y | 98,000 y |
| #Words needed (wordlist of size 2048) | 6    | 6   | 6   | 6    | 7   | 7   | 7   | 7    | 7    | 8     | 8       | 8       | 8        | 8        |

## Run in terminal (CLI support)

```zsh
swift run GeneratePassword | less
```

The piping to `less` is of course optional - but recommended for maximum security (it automatically clears the password from your screen after you press `Q` to exit `less`).

## Installation

Installable via [Swift Package Manager (SPM)](https://swift.org/package-manager/):

### Xcode 11
From Xcode 11, you can use SPM to add `VanligaOrd` to your project:

1.  Select File > Swift Packages > Add Package Dependency, Enter
`https://github.com/Sajjon/VanligaOrd.git` in the *"Choose Package Repository"* dialog.
2.  In the next page, specify the version resolving rule as "Up to Next Major" with "0.0.1" as its earliest version.
3.  After Xcode checking out the source and resolving the version, you can choose the "VanligaOrd" library and add it to your app target.

If you encounter any problem or have a question on adding package to an Xcode project, take a look at the [Adding Package Dependencies to Your App](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app) guide article from Apple.

**- or -**

### Package.swift file
Add in your `Package.swift` file

```swift
dependencies: [
    .package(url: "https://github.com/Sajjon/VanligaOrd", from: "0.0.1"),
],
```

## Usage

All BIP39 languages are supported, which are:
* 🇨🇳 Chinese (simplified and traditional) 
* 🇨🇿 Czech 
* 🇬🇧 English 
* 🇫🇷 French 
* 🇮🇹 Italian  
* 🇯🇵 Japanese  
* 🇰🇷 Korean. 
* 🇪🇸 Spanish

### BIP39 Mnemonic
Support coming soon, stay tuned 📣.

### Passwords

#### By word count
You can either generate a password by specifying the number of words you want.

```swift
let passwordGenerator = Generator.ofPassword(in: .english, numberOfWords: 8)
let password = passwordGenerator.generate() // type: `SecurelyGeneratedWords`
print(password.words) 	 // `["misery", "excess", "garage", "result", "sense", "sweet", "track", "enact"]`
print(password.joined()) // `"misery excess garage result sense sweet track enact"`
print(password.recipe) 	 // `"Password in English with entropy of #88 bits"`
```

#### By entropy

```swift
let passwordGenerator = Generator(recipe: try! Recipe(purpose: .password, bitsOfEntropy: 128, in: .english))
let password = passwordGenerator.generate()
print(password.joined()) // `"century false own baby talk column embrace notable hollow pond soccer absorb"`
print(password.recipe)   // `"Password in English with entropy of #128 bits"`
```

## Wordlist
You can find [the wordlists in BIP39 docs here](https://github.com/bitcoin/bips/blob/master/bip-0039/bip-0039-wordlists.md).

## Custom Language

You can create your own custom language like so:
```swift
let swedish = Language.custom(wordlist:
    Wordlist(unchecked: 
    	[
            "hej", 
            /* ...  2048 unique words fulfilling BIP39 requirements ... */,
             "zoo"
        ],
        nameOfLanguage: "Swedish"
    )
)
```

## Reference
You can always check the correctness of this library against the reference test code (a.k.a. 'test vectors') of the [BIP39 (Bitcoin Improvement Proposal) reference](https://github.com/bitcoin/bips/blob/master/bip-0039.mediawiki#Test_vectors) or using [Ian Coleman's excellent online tool](https://iancoleman.io/bip39/#english)

## Etymology
"Vanliga ord" is Swedish 🇸🇪 for "Common Words".
