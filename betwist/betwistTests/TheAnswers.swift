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
  func moves_duplicate_word_to_the_beginning() {
    var sut = Answers()
    sut.submit("FISH")
    sut.submit("STICKS")

    sut.submit("FISH")

    #expect(sut.preview == "FISH\nSTICKS")
  }
}
