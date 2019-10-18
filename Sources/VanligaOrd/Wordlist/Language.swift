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

public struct Language: WordlistForLanguage, CustomStringConvertible {
    
    public let wordlist: Wordlist

    /// https://github.com/bitcoin/bips/blob/master/bip-0039/bip-0039-wordlists.md
    public let isOnBip39ListOfLanguages: Bool
    
    internal init(wordlist: Wordlist, isOnBip39ListOfLanguages: Bool) {
        self.wordlist = wordlist
        self.isOnBip39ListOfLanguages = isOnBip39ListOfLanguages
    }
}

// MARK: CustomStringConvertible
public extension Language {
    var description: String { wordlist.nameOfLanguage }
}

