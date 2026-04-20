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
  func helper_split_turns_array_of_strings_to_one_letter_strings() {
    #expect(split(["ABC", "D", "EF"]) == ["A", "B", "C", "D", "E", "F"])
  }

  @Test
  func starts_in_play_mode() {
    let sut = Game(2, ["A", "B", "C", "D"])
    #expect(sut.mode == .play)
  }

  @Test
  func prepends_a_collected_answer() {
    var game = Game(2, ["A", "B", "C", "D"])
    game.select(Location(0, 0))
    game.select(Location(0, 1))
    game.select(Location(1, 0))
    game.select(Location(1, 1))
    game.submit(game.answer)
    game.deselectAll()
    game.select(Location(0, 1))
    game.select(Location(1, 1))
    game.select(Location(1, 0))
    game.select(Location(0, 0))

    game.submit(game.answer)

    #expect(game.answers.preview == "BDCA\nABCD")
  }

  @Test
  func message_starts_empty() {
    let game = Game(2, ["A", "B", "C", "D"])
    #expect(game.message.isEmpty)
  }

  @Test
  func select_clears_the_message() {
    var game = Game(2, ["A", "B", "C", "D"])
    game.message = "hi"

    game.select(Location(0, 0))

    #expect(game.message.isEmpty)
  }

  @Test
  func selectingLastCell_false_if_nothing_selected() {
    let game = Game(2, ["A", "B", "C", "D"])
    #expect(!game.lastLocationSelected(was: Location(0, 0)))
  }

  @Test
  func selectingLastCell_true_only_if_location_matches() {
    var game = Game(2, ["A", "B", "C", "D"])
    game.select(Location(0, 0))

    #expect(game.lastLocationSelected(was: Location(0, 0)))
    #expect(!game.lastLocationSelected(was: Location(0, 1)))
  }

  @Test
  func deselectAll_clears_the_message() {
    var game = Game(2, ["A", "B", "C", "D"])
    game.select(Location(0, 0))
    game.message = "hi"

    game.deselectAll()

    #expect(game.message.isEmpty)
  }

  @Test
  func validating_empty_word_gets_no_message() {
    var game = Game(2, ["A", "B", "C", "D"])

    game.validate()

    #expect(game.message.isEmpty)
  }

  @Test
  func validating_short_word_gets_message() {
    var game = Game(2, ["A", "B", "C", "D"])
    game.select(Location(0, 1))
    game.select(Location(0, 0))
    game.select(Location(1, 1))

    game.validate()

    #expect(game.message == "Word is too short")
  }

  @Test
  func validating_illegal_word_gets_a_message() {
    var game = Game(2, ["A", "B", "C", "D"], Vocabulary(["ABCD"]))
    game.select(Location(0, 1))
    game.select(Location(0, 0))
    game.select(Location(1, 0))
    game.select(Location(1, 1))

    game.validate()

    #expect(game.message == "That's not a word!")
  }

  @Test
  func validating_duplicate_word_gets_a_message() {
    var game = Game(2, ["A", "B", "C", "D"], Vocabulary(["ABCD"]))
    game.select(Location(0, 0))
    game.select(Location(0, 1))
    game.select(Location(1, 0))
    game.select(Location(1, 1))
    game.submit(game.answer)
    game.select(Location(0, 0))
    game.select(Location(0, 1))
    game.select(Location(1, 0))
    game.select(Location(1, 1))

    game.validate()

    #expect(game.message == "Duplicate word!")
  }

  @Test
  func hue_for_same_location_is_the_same() {
    let game = Game(2, ["A", "B", "C", "D"], Vocabulary(["ABCD"]))
    #expect(game.hue(at: Location(1, 0)) == game.hue(at: Location(1, 0)))
  }

  @Test
  func hue_for_different_locations_is_different() {
    let game = Game(2, ["A", "B", "C", "D"], Vocabulary(["ABCD"]))
    #expect(game.hue(at: Location(1, 0)) != game.hue(at: Location(1, 1)))
  }

  @Test
  func collect_collects_prefix_words_long_to_short_and_clears_selection() {
    var game = Game(
      3,
      [
        "M", "A", "S",
        "T", "E", "R",
        "Y", "X", "X",
      ],
      Vocabulary(["MAST", "MASTER", "MASTERY", "TEAM"])
    )

    game.select(Location(0, 0))
    game.select(Location(0, 1))
    game.select(Location(0, 2))
    game.select(Location(1, 0))
    game.select(Location(1, 1))
    game.select(Location(1, 2))
    game.select(Location(2, 0))
    game.submit(game.answer)

    #expect(game.answers.preview == "MASTERY\nMASTER\nMAST")
    #expect(game.selection.isEmpty)
  }

  @Test
  func submit_rejects_invalid_words_and_deselects() {
    var game = Game(2, ["A", "B", "C", "D"], Vocabulary(["ABCD"]))
    game.select(Location(0, 1))
    game.select(Location(0, 0))
    game.select(Location(1, 0))
    game.select(Location(1, 1))

    game.submit(game.answer)

    #expect(!game.hasAnswers)
    #expect(!game.hasSelection)
  }

  @Test
  func scores_answers() {
    var game = Game(2, ["F", "U", "N", "D"], Vocabulary(["FUND"]))
    game.select(Location(0, 0))
    game.select(Location(0, 1))
    game.select(Location(1, 0))
    game.select(Location(1, 1))

    game.submit(game.answer)

    #expect(game.score == Score(wordCount: 1, letterCount: 4, mostLetters: 4))
  }
}
