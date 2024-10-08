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

  @Test
  func knows_whether_string_is_prefix_of_a_longer_word() {
    let sut = Vocabulary(["ease", "east", "easy", "west"])
    #expect(sut.hasPrefix("eas"))
    #expect(!sut.hasPrefix("east"))
    #expect(!sut.hasPrefix("north"))
  }
}
