@testable import betwist
import Testing

struct AGame {
  @Test
  func prepends_a_collected_guess() {
    var game = Game(2, ["A", "B", "C", "D"])
    game.select(Location(0, 0))
    game.collect()
    game.deselectAll()
    game.select(Location(0, 1))

    game.collect()

    #expect(game.guesses == ["B", "A"])
  }
}
