@testable import betwist
import Testing

struct TheGuesses {
  @Test
  func inserts_word_at_the_beginning() {
    var sut = Guesses()
    sut.prepend("STICKS")
    sut.prepend("FISH")
    #expect(sut.description == "FISH\nSTICKS")
  }

  @Test
  func moves_duplicate_word_to_the_beginning() {
    var sut = Guesses()
    sut.prepend("FISH")
    sut.prepend("STICKS")

    sut.prepend("FISH")

    #expect(sut.description == "FISH\nSTICKS")
  }
}
