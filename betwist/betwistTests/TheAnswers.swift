@testable import betwist
import Testing

struct TheAnswers {
  @Test
  func inserts_word_at_the_beginning() {
    var sut = Answers()
    sut.submit("STICKS")
    sut.submit("FISH")
    #expect(sut.preview == "FISH\nSTICKS")
  }

  @Test
  func allows_duplicate_words() {
    var sut = Answers()
    sut.submit("FISH")
    sut.submit("STICKS")

    sut.submit("FISH")

    #expect(sut.preview == "FISH\nSTICKS\nFISH")
  }

  @Test
  func knows_whether_it_contains_a_word() {
    var sut = Answers()
    sut.submit("FRIED")

    #expect(sut.contains("FRIED"))
    #expect(!sut.contains("BOILED"))
  }
}
