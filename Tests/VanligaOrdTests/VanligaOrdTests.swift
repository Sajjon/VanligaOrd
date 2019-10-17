import XCTest
@testable import VanligaOrd

final class VanligaOrdTests: XCTestCase {
    
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

    func testEnglish() {
        XCTAssertEqual(English.words.count, 2048)
        XCTAssertEqual(Language.english.wordlist.words.count, 2048)
        XCTAssertEqual(Language.english.nameOfLanguage, "English")
        XCTAssertEqual(Language.english.first, "abandon")
        XCTAssertEqual(Language.english[1], "ability")
        XCTAssertEqual(Language.english.last, "zoo")
    }
    
    static var allTests = [
        ("testIdentifyingUnambiguousWords", testIdentifyingUnambiguousWords),
        ("testEnglish", testEnglish),
    ]
}
