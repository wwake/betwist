@testable import betwist
import Testing

struct Vocabulary {
  let words: [String]

  init(_ words: [String]) {
    self.words = words
  }

  func contains(_ word: String) -> Bool {
    words.contains(word)
  }
}

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
}
