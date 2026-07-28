@testable import model
import Testing

private class TestStore: Store {
  let hasLicense: Bool

  init(_ answer: Bool = false) {
    hasLicense = answer
  }
}

struct AMonetizer {
  @Test
  func `knows the number of free games remaining`() async throws {
    Game.timesPlayed = 7
    #expect(Monetizer(store: TestStore()).freeGamesRemaining == Monetizer.maxFreeGames - 7)
  }

  @Test
  func `knows whether there are free games remaining`() async throws {
    let sut = Monetizer(store: TestStore())

    Game.timesPlayed = 1
    #expect(sut.hasFreeGamesRemaining)

    Game.timesPlayed = Monetizer.maxFreeGames
    #expect(!sut.hasFreeGamesRemaining)
  }
}
