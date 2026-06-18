@testable import betwist
import Testing

struct AGame {
  fileprivate func split(_ input: [String]) -> [String] {
    input
      .map { Array($0) }
      .flatMap { $0 }
      .map { String($0) }
  }

  @Test
  func `split turns array of strings to one-letter strings`() {
    #expect(split(["ABC", "D", "EF"]) == ["A", "B", "C", "D", "E", "F"])
  }

  @Test
  func `game starts in play mode`() {
    let sut = Game(2, ["A", "B", "C", "D"])
    #expect(sut.mode == .play)
    #expect(sut.message.isEmpty)
  }

  @Test
  func `starting a game clears the message`() {
    var sut = Game(2, ["F", "U", "N", "D"], Vocabulary(["FUND"]))
    sut.message = "Any message"
    sut.mode = .review

    sut.start()

    #expect(sut.mode == .play)
    #expect(sut.message.isEmpty)
  }

  @Test
  func `selection is ignored when in review mode`() {
    var sut = Game(2, ["F", "U", "N", "D"], Vocabulary(["FUND"]))
    sut.mode = .review
    sut.select(Location(0, 0))

    #expect(!sut.hasSelection)
  }

  @Test
  func `finishing a game clears the selection`() {
    var sut = Game(2, ["F", "U", "N", "D"], Vocabulary(["FUND"]))
    sut.select(Location(0, 0))

    sut.over()

    #expect(sut.mode == .review)
    #expect(!sut.hasSelection)
    #expect(sut.message == "Game Over")
  }

  @Test
  func `prepends a collected answer`() {
    var sut = Game(2, ["A", "B", "C", "D"])
    sut.select(Location(0, 0))
    sut.select(Location(0, 1))
    sut.select(Location(1, 0))
    sut.select(Location(1, 1))
    sut.submit(sut.answer)
    sut.deselectAll()
    sut.select(Location(0, 1))
    sut.select(Location(1, 1))
    sut.select(Location(1, 0))
    sut.select(Location(0, 0))

    sut.submit(sut.answer)

    #expect(sut.answers.preview == "BDCA\nABCD")
  }

  @Test
  func `select clears the message`() {
    var sut = Game(2, ["A", "B", "C", "D"])
    sut.message = "hi"

    sut.select(Location(0, 0))

    #expect(sut.message.isEmpty)
  }

  @Test
  func `lastLocationSelected false if nothing selected`() {
    let sut = Game(2, ["A", "B", "C", "D"])
    #expect(!sut.lastLocationSelected(was: Location(0, 0)))
  }

  @Test
  func `lastLocationSelected true only if location matches`() {
    var sut = Game(2, ["A", "B", "C", "D"])
    sut.select(Location(0, 0))

    #expect(sut.lastLocationSelected(was: Location(0, 0)))
    #expect(!sut.lastLocationSelected(was: Location(0, 1)))
  }

  @Test
  func `deselectAll clears the message`() {
    var sut = Game(2, ["A", "B", "C", "D"])
    sut.select(Location(0, 0))
    sut.message = "hi"

    sut.deselectAll()

    #expect(sut.message.isEmpty)
  }

  @Test
  func `validating empty word gets no message`() {
    var sut = Game(2, ["A", "B", "C", "D"])

    sut.validate()

    #expect(sut.message.isEmpty)
  }

  @Test
  func validating_short_word_gets_message() {
    var sut = Game(2, ["A", "B", "C", "D"])
    sut.select(Location(0, 1))
    sut.select(Location(0, 0))
    sut.select(Location(1, 1))

    sut.validate()

    #expect(sut.message == "Too short!")
  }

  @Test
  func validating_illegal_word_gets_a_message() {
    var sut = Game(2, ["A", "B", "C", "D"], Vocabulary(["ABCD"]))
    sut.select(Location(0, 1))
    sut.select(Location(0, 0))
    sut.select(Location(1, 0))
    sut.select(Location(1, 1))

    sut.validate()

    #expect(sut.message == "Not a word!")
  }

  @Test
  func validating_duplicate_word_gets_a_message() {
    var sut = Game(2, ["A", "B", "C", "D"], Vocabulary(["ABCD"]))
    sut.select(Location(0, 0))
    sut.select(Location(0, 1))
    sut.select(Location(1, 0))
    sut.select(Location(1, 1))
    sut.submit(sut.answer)
    sut.select(Location(0, 0))
    sut.select(Location(0, 1))
    sut.select(Location(1, 0))
    sut.select(Location(1, 1))

    sut.validate()

    #expect(sut.message == "Duplicate!")
  }

  @Test
  func hue_for_same_location_is_the_same() {
    let sut = Game(2, ["A", "B", "C", "D"], Vocabulary(["ABCD"]))
    #expect(sut.hue(at: Location(1, 0)) == sut.hue(at: Location(1, 0)))
  }

  @Test
  func hue_for_different_locations_is_different() {
    let sut = Game(2, ["A", "B", "C", "D"], Vocabulary(["ABCD"]))
    #expect(sut.hue(at: Location(1, 0)) != sut.hue(at: Location(1, 1)))
  }

  @Test
  func collect_collects_prefix_words_long_to_short_and_clears_selection() {
    var sut = Game(
      3,
      [
        "M", "A", "S",
        "T", "E", "R",
        "Y", "X", "X",
      ],
      Vocabulary(["MAST", "MASTER", "MASTERY", "TEAM"])
    )

    sut.select(Location(0, 0))
    sut.select(Location(0, 1))
    sut.select(Location(0, 2))
    sut.select(Location(1, 0))
    sut.select(Location(1, 1))
    sut.select(Location(1, 2))
    sut.select(Location(2, 0))
    sut.submit(sut.answer)

    #expect(sut.answers.preview == "MASTERY\nMASTER\nMAST")
    #expect(sut.selection.isEmpty)
  }

  @Test
  func submit_rejects_invalid_words_and_deselects() {
    var sut = Game(2, ["A", "B", "C", "D"], Vocabulary(["ABCD"]))
    sut.select(Location(0, 1))
    sut.select(Location(0, 0))
    sut.select(Location(1, 0))
    sut.select(Location(1, 1))

    sut.submit(sut.answer)

    #expect(!sut.hasAnswers)
    #expect(!sut.hasSelection)
  }

  @Test
  func `generates statistics for answers`() {
    var sut = Game(2, ["F", "U", "N", "D"], Vocabulary(["FUND"]))
    sut.select(Location(0, 0))
    sut.select(Location(0, 1))
    sut.select(Location(1, 0))
    sut.select(Location(1, 1))

    sut.submit(sut.answer)

    #expect(sut.statistics == Statistics(wordCount: 1, letterCount: 4, mostLetters: 4))
  }
}
