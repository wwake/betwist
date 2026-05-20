@testable import betwist
import Foundation
import Testing

extension Vocabulary {
  func hasPrefix(_ prefix: String) -> Bool {
    containsAndPrefixes(prefix).isProperPrefix
  }
}

struct AVocabulary {
  @Test
  func finds_word_that_is_there() {
    let sut = Vocabulary(["HELLO", "WORLD"])

    #expect(sut.contains("WORLD"))
  }

  @Test
  func doesnt_find_word_thats_not_there() {
    let sut = Vocabulary(["hello", "world"])

    #expect(!sut.contains("goodbye"))
  }

  @Test
  func knows_whether_string_is_prefix_of_a_longer_word() {
    let sut = Vocabulary(["EASE", "EAST", "EASY", "WEST"])
    #expect(sut.hasPrefix("EAS"))
    #expect(!sut.hasPrefix("EAST"))
    #expect(!sut.hasPrefix("NORTH"))
    #expect(!sut.hasPrefix("EASY"))
    #expect(!sut.hasPrefix("WEST"))
    #expect(!sut.hasPrefix("ZOO"))
  }

  static func load() -> Vocabulary {
    let path = Bundle.main.path(forResource: "words", ofType: "list")!
    let words = try! String(contentsOfFile: path, encoding: .utf8)
      .split(separator: "\n")
      .map { String($0).uppercased() }
    return Vocabulary(words)
  }

  @Test
  func contains_can_find_any_word_in_list() {
    let words = ["brother", "ease", "east", "easy", "father", "mother", "sister", "west"]
      .map { $0.uppercased(with: .autoupdatingCurrent) }

    let sut = Vocabulary(words)

    words.forEach { word in
      #expect(sut.contains(word))
    }
    #expect(!sut.contains("NORTH"))
  }
}
