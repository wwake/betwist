@testable import betwist
import Testing

struct TheGuesses {
  @Test
  func inserts_word_at_the_beginning() {
    var sut = Guesses()
    sut.guess("STICKS")
    sut.guess("FISH")
    #expect(sut.description == "FISH\nSTICKS")
  }

  @Test
  func moves_duplicate_word_to_the_beginning() {
    var sut = Guesses()
    sut.guess("FISH")
    sut.guess("STICKS")

    sut.guess("FISH")

    #expect(sut.description == "FISH\nSTICKS")
  }
}
