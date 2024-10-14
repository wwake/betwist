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

    #expect(game.guesses.description == "BDCA\nABCD")
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
  func collect_collects_prefix_words_long_to_short() {
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
    game.collect()

    #expect(game.guesses.description == "MASTERY\nMASTER\nMAST")
  }

  @Test
  func finds_all_answers_in_1_cell_board() {
    let game = Game(1, ["A"], Vocabulary(["A"]))
    #expect(game.allAnswers == Set(["A"]))
  }

  @Test()
  func finds_all_answers_in_4_cell_board() {
    let game = Game(2, ["F", "U", "N", "D"], Vocabulary(["FUN", "FUND"]))
    #expect(game.allAnswers == Set(["FUN", "FUND"]))
  }

  @Test
  func finds_all_answers_in_16_cell_board() {
    let game = Game(
      4,
      ["F", "U", "N", "D", "E", "R", "S", "T", "W", "H", "I", "L", "E", "A", "L", "S"],
      Vocabulary(["FUN", "FUND", "FUNDER", "FUNDERS", "WHILE", "UNDER", "TWIST", "BECKON", "ERSTWHILE"].sorted())
    )
    #expect(game.allAnswers == Set(["FUN", "FUND", "FUNDER", "FUNDERS", "UNDER", "WHILE", "ERSTWHILE"]))
  }

  @Test
  func knows_openNeighbors() {
    let game = Game(2, ["F", "U", "N", "D"])
    var selection = Selection(game.grid)
    selection.select(Location(0, 0))

    #expect(game.openNeighbors(selection) == [Location(0, 1), Location(1, 0), Location(1, 1)])
  }

  @Test
  func knows_openNeighbors_when_some_selected() {
    let game = Game(2, ["F", "U", "N", "D"])
    var selection = Selection(game.grid)

    selection.select(Location(0, 1))
    selection.select(Location(1, 0))
    selection.select(Location(0, 0))

    #expect(game.openNeighbors(selection) == [Location(1, 1)])
  }
}
