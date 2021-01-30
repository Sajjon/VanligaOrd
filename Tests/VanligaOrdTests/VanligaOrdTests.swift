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

import XCTest
@testable import VanligaOrd

final class VanligaOrdTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
    }
    
    func testIdentifyingUnambiguousWords() {
        // MARK: True
        XCTAssertTrue(Wordlist.unambiguousWords(word: "a", succeededBy: "b"))
        XCTAssertTrue(Wordlist.unambiguousWords(word: "aaab", succeededBy: "aaac"))
        
        XCTAssertTrue(Wordlist.unambiguousWords(word: "cat", succeededBy: "catalog"))
        XCTAssertTrue(Wordlist.unambiguousWords(word: "cat", succeededBy: "catch"))
        XCTAssertTrue(Wordlist.unambiguousWords(word: "cat", succeededBy: "category"))
        XCTAssertTrue(Wordlist.unambiguousWords(word: "cat", succeededBy: "cattle"))
        
        // MARK: False
        
        XCTAssertFalse(Wordlist.unambiguousWords(word: "aaaab", succeededBy: "aaaac"))
        XCTAssertFalse(Wordlist.unambiguousWords(word: "abcde", succeededBy: "abcdf"))
    }
    
    func testNumberOfLanguages() {
        XCTAssertEqual(Language.allCases.count, 9)
    }
    
    func testChinese() {
        let simplified: Language = .chineseSimplified
        let traditional: Language = .chineseTraditional
        basicSanityTestOf(language: simplified, assertMinLengthOfWords: false)
        basicSanityTestOf(language: traditional, assertMinLengthOfWords: false)
        XCTAssertEqual(simplified.nameOfLanguage, "Chinese Simplified")
        XCTAssertEqual(traditional.nameOfLanguage, "Chinese Traditional")
        
        // MARK: Equal between Simplified and Traditional
        XCTAssertEqual(simplified[0], traditional[0])
        XCTAssertEqual(simplified[0], "的")
        
        
        // MARK: Not equal between Simplified and Traditional
        var diffAt = 9
        XCTAssertNotEqual(simplified[diffAt], traditional[diffAt])
        XCTAssertEqual(simplified[diffAt], "这")
        XCTAssertEqual(traditional[diffAt], "這")
        
        diffAt = 12
        XCTAssertNotEqual(simplified[diffAt], traditional[diffAt])
        XCTAssertEqual(simplified[diffAt], "为")
        XCTAssertEqual(traditional[diffAt], "為")
        
        diffAt = 2039
        XCTAssertNotEqual(simplified[diffAt], traditional[diffAt])
        XCTAssertEqual(simplified[diffAt], "尝")
        XCTAssertEqual(traditional[diffAt], "嘗")
    }
    
    func testCzech() {
        let language: Language = .czech
        basicSanityTestOf(language: language)
        
        XCTAssertEqual(language.nameOfLanguage, "Czech")
        
        XCTAssertEqual(language.first, "abdikace")
        XCTAssertEqual(language[1], "abeceda")
        XCTAssertEqual(language.last, "zvyk")
    }
    
    func testEnglish() {
        let language: Language = .english
        basicSanityTestOf(language: language)
        
        XCTAssertEqual(language.nameOfLanguage, "English")
        XCTAssertEqual(language.first, "abandon")
        XCTAssertEqual(language[1], "ability")
        XCTAssertEqual(language.last, "zoo")
    }
    
    func testFrench() {
        let language: Language = .french
        basicSanityTestOf(language: language)
        
        XCTAssertEqual(language.nameOfLanguage, "French")
        
        XCTAssertEqual(language.first, "abaisser")
        XCTAssertEqual(language[1], "abandon")
        XCTAssertEqual(language[2046], "zeste")
        XCTAssertEqual(language.last, "zoologie")
    }
    
    func testItalian() {
        let language: Language = .italian
        
        // Many of the Italian words are `9` characters long instead of `8`
        basicSanityTestOf(language: language, assertMaxLengthOfWords: false)
        
        XCTAssertEqual(language.nameOfLanguage, "Italian")
        
        XCTAssertEqual(language.first, "abaco")
        XCTAssertEqual(language[1], "abbaglio")
        XCTAssertEqual(language[2046], "zulu")
        XCTAssertEqual(language.last, "zuppa")
    }
    
    func testJapanese() {
        let language: Language = .japanese
        basicSanityTestOf(language: language)
        XCTAssertEqual(language.nameOfLanguage, "Japanese")
        
        XCTAssertEqual(language.first, "あいこくしん")
        XCTAssertEqual(language[1], "あいさつ")
        XCTAssertEqual(language[2046], "わらう")
        XCTAssertEqual(language.last, "われる")
    }
    
    func testKorean() {
        let language: Language = .korean
        basicSanityTestOf(language: language, assertMinLengthOfWords: false)
        XCTAssertEqual(language.nameOfLanguage, "Korean")
        
        XCTAssertEqual(language.first, "가격")
        XCTAssertEqual(language[1], "가끔")
        XCTAssertEqual(language[2046], "흰색")
        XCTAssertEqual(language.last, "힘껏")
    }
    
    func testSpanish() {
        let language: Language = .spanish
        basicSanityTestOf(language: language)
        XCTAssertEqual(language.nameOfLanguage, "Spanish")
        
        XCTAssertEqual(language.first, "ábaco")
        XCTAssertEqual(language[1], "abdomen")
        XCTAssertEqual(language[2046], "zumo")
        XCTAssertEqual(language.last, "zurdo")
    }
    
    func testGenerateWordsInEnglish() {
        func doTest(wordCount: Int, in language: Language = .english) {
            let passwordGenerator = Generator.ofPassword(in: language, numberOfWords: wordCount)
            let password = passwordGenerator.generate()
            XCTAssertEqual(password.words.count, wordCount)
            for word in password.words {
                XCTAssertTrue(language.words.contains(word))
            }
        }
        
        for wordCount in 0..<20 {
            doTest(wordCount: wordCount)
        }
    }
    
    func testNumberOfBitsMapsToCorrectNumberOfWords() {
        func doTest(bitsOfEntropy: UInt16, expectedWordCount: Int, in language: Language = .english) {
            let passwordGenerator = Generator(recipe: try! Recipe(purpose: .password, bitsOfEntropy: bitsOfEntropy, in: language))
            
            let password = passwordGenerator.generate()
            
            XCTAssertEqual(password.words.count, expectedWordCount)
        }
        
        doTest(bitsOfEntropy: 0, expectedWordCount: 0)
        for bitsOfEntropyAsInt in 1...Wordlist.bitsOfEntropyPerWords {
            let bitsOfEntropy = UInt16(bitsOfEntropyAsInt)
            doTest(bitsOfEntropy: bitsOfEntropy, expectedWordCount: 1)
        }
        doTest(bitsOfEntropy: 12, expectedWordCount: 2)
        doTest(bitsOfEntropy: 21, expectedWordCount: 2)
        doTest(bitsOfEntropy: 22, expectedWordCount: 2)
        doTest(bitsOfEntropy: 23, expectedWordCount: 3)
        doTest(bitsOfEntropy: 128, expectedWordCount: 12)
        doTest(bitsOfEntropy: 256, expectedWordCount: 24)
    }
    
    func testRandomlyGenerateUInt11() {
        var zeroThrough2047 = Set<UInt11>()
        var counter = 0
        for _ in 0..<2048*100 {
            defer { counter += 1 }
            let random = UInt11(bitArray: try! securelyGenerateBits(count: 11))!
            zeroThrough2047.insert(random)
            if zeroThrough2047.count == 2048 {
                break
            }
        }
        XCTAssertEqual(zeroThrough2047.count, 2048)
    }

    static var allTests = [
        ("testIdentifyingUnambiguousWords", testIdentifyingUnambiguousWords),
        ("testNumberOfLanguages", testNumberOfLanguages),
        ("testChinese", testChinese),
        ("testCzech", testCzech),
        ("testEnglish", testEnglish),
        ("testFrench", testFrench),
        ("testItalian", testItalian),
        ("testJapanese", testJapanese),
        ("testKorean", testKorean),
        ("testSpanish", testSpanish),
        ("testGenerateWordsInEnglish", testGenerateWordsInEnglish),
        ("testNumberOfBitsMapsToCorrectNumberOfWords", testNumberOfBitsMapsToCorrectNumberOfWords),
        ("testRandomlyGenerateUInt11", testRandomlyGenerateUInt11),
    ]
}

private extension VanligaOrdTests {
    func basicSanityTestOf(language: Language, assertMaxLengthOfWords: Bool = true, assertMinLengthOfWords: Bool = true) {
        
        XCTAssertTrue(language.isOnBip39ListOfLanguages)
        XCTAssertEqual(language.count, 2048)
        
        for (index, word) in language.enumerated() {
            
            if assertMaxLengthOfWords {
                XCTAssertLessThanOrEqual(
                    word.count,
                    Wordlist.maximumCharacterCountPerWord,
                    "Word: <\(word)> is too long, at index: `\(index)`"
                )
            }
            
            if assertMinLengthOfWords {
                XCTAssertGreaterThanOrEqual(
                    word.count,
                    Wordlist.minimumCharacterCountPerWord,
                    "Word: <\(word)> is too short, at index: `\(index)`"
                )
            }
            
        }
        
    }
}
