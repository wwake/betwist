@testable import betwist
import Foundation
import Testing

struct AVocabulary {
  @Test
  func finds_word_that_is_there() {
    let sut = Vocabulary(["hello", "world"])

    #expect(sut.contains("world"))
  }

  @Test
  func doesnt_find_word_thats_not_there() {
    let sut = Vocabulary(["hello", "world"])

    #expect(!sut.contains("goodbye"))
  }

  @Test
  func knows_whether_string_is_prefix_of_a_longer_word() {
    let sut = Vocabulary(["ease", "east", "easy", "west"])
    #expect(sut.hasPrefix("eas"))
    #expect(!sut.hasPrefix("east"))
    #expect(!sut.hasPrefix("north"))
    #expect(!sut.hasPrefix("easy"))
    #expect(!sut.hasPrefix("west"))
    #expect(!sut.hasPrefix("zoo"))
  }

  static func load() -> Vocabulary {
    let path = Bundle.main.path(forResource: "words", ofType: "list")!
    let words = try! String(contentsOfFile: path, encoding: .utf8)
      .split(separator: "\n")
      .map { String($0).uppercased() }
    return Vocabulary(words)
  }

  // Before changing linear to binary search:
//  ◇ Test performance_test() started.
//  2024-10-09 18:15:23 +0000
//  count=1000 should be 1000
//  2024-10-09 18:15:32 +0000
//  ✔ Test performance_test() passed after 9.258 seconds.

  // After:
//  ◇ Test performance_test() started.
//  2024-10-09 18:25:42 +0000
//  count=1000 should be 1000
//  2024-10-09 18:25:42 +0000
//  ✔ Test performance_test() passed after 0.116 seconds.

  @Test(.disabled())
  func performance_test_contains() {
    let count = 1_000_000
    let sut = Self.load()
    let randomWords = (0..<count).map { _ in
      sut.words.randomElement()!
    }
    var result = 0
    print(Date())

    (0..<count).forEach { index in
      let found = sut.contains(randomWords[index])
      if found {
        result += 1
      }
    }

    print("count=\(result) should be \(count)")
    print(Date())
  }

  // Before:
//  ◇ Test performance_test_hasPrefix() started.
//  2024-10-09 19:16:56 +0000
//  count=996 needn't be 1000
//  2024-10-09 19:17:13 +0000
//  ✔ Test performance_test_hasPrefix() passed after 16.540 seconds.

  // After:
//  ◇ Test performance_test_hasPrefix() started.
//  2024-10-09 19:06:22 +0000
//  count=996 needn't be 1000
//  2024-10-09 19:06:22 +0000
//  ✔ Test performance_test_hasPrefix() passed after 0.114 seconds.

  @Test(.disabled())
  func performance_test_hasPrefix() {
    let sut = Self.load()
    let randomWords = (0..<10000).map { _ in
      sut.words.randomElement()!
    }
    var result = 0
    print(Date())

    (0..<10000).forEach { index in
      let found = sut.hasPrefix(String(randomWords[index].prefix(4)))
      if found {
        result += 1
      }
    }

    print("count=\(result) needn't be 10000")
    print(Date())
  }

  @Test(.disabled())
  func performance_test_containsAndPrefix() {
    let count = 1_000_000
    let sut = Self.load()
    let randomWords = (0..<count).map { _ in
      sut.words.randomElement()!
    }
    var result = 0
    print(Date())

    (0..<count).forEach { index in
      let word: String = randomWords[index]
      let contained = sut.contains(word)
      let prefixed = sut.hasPrefix(word)
//      let (contained, prefixed) = sut.containsAndPrefixes(randomWords[index])
      if contained {
        result += 1
      }
    }

    print("count=\(result) should be \(count)")
    print(Date())
  }

  @Test
  func contains_can_find_any_word_in_list() {
    let words = ["brother", "ease", "east", "easy", "father", "mother", "sister", "west"]
    let sut = Vocabulary(words)

    words.forEach { word in
      #expect(sut.contains(word))
    }
    #expect(!sut.contains("north"))
  }
}
