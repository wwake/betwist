@testable import betwist
import Testing

struct AGame {
  @Test
  func prepends_a_collected_guess() {
    var game = Game(2, ["A", "B", "C", "D"])
    game.select(Location(0, 0))
    game.select(Location(0, 1))
    game.select(Location(1, 0))
    game.select(Location(1, 1))
    game.collect()
    game.deselectAll()
    game.select(Location(0, 1))
    game.select(Location(1, 1))
    game.select(Location(1, 0))
    game.select(Location(0, 0))

    game.collect()

    #expect(game.guesses == ["BDCA", "ABCD"])
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
  func collecting_empty_word_gets_ignored() {
    var game = Game(2, ["A", "B", "C", "D"])
    game.collect()
    #expect(game.guesses.isEmpty)
    #expect(game.message.isEmpty)
  }

  @Test
  func collecting_doesnt_collect_word_that_got_message() {
    var game = Game(2, ["A", "B", "C", "D"])
    game.select(Location(0, 1))
    game.message = "Word is too short"

    game.collect()

    #expect(game.message == "Word is too short")
    #expect(game.guesses.isEmpty)
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
  func validating_legal_word_gets_no_message() {
    var game = Game(2, ["A", "B", "C", "D"], Vocabulary(["BACD"]))
    game.select(Location(0, 1))
    game.select(Location(0, 0))
    game.select(Location(1, 0))
    game.select(Location(1, 1))

    game.validate()

    #expect(game.message.isEmpty)
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
  }}
