@testable import betwist
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
}
