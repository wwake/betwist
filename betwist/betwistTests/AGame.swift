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
  func deselectAll_clears_the_message() {
    var game = Game(2, ["A", "B", "C", "D"])
    game.select(Location(0, 0))
    game.message = "hi"

    game.deselectAll()

    #expect(game.message.isEmpty)
  }

  @Test
  func collecting_short_word_gets_message() {
    var game = Game(2, ["A", "B", "C", "D"])
    game.select(Location(0, 1))
    game.select(Location(0, 0))
    game.select(Location(1, 1))

    game.collect()

    #expect(game.message == "Word is too short")
  }
}
