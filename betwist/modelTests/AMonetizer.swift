@testable import model
import Testing

struct AMonetizer {
  @Test
  func `knows the number of free games remaining`() async throws {
    Game.timesPlayed = 7
    #expect(Monetizer().freeGamesRemaining == Monetizer.maxFreeGames - 7)
  }

  @Test
  func `knows whether there are free games remaining`() async throws {
    Game.timesPlayed = 1
    #expect(Monetizer().hasFreeGamesRemaining)

    Game.timesPlayed = Monetizer.maxFreeGames
    #expect(!Monetizer().hasFreeGamesRemaining)
  }
}
