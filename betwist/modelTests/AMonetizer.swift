@testable import model
import Testing

private class TestStore: Store {
  let hasAppLicense: Bool

  init(_ answer: Bool = false) {
    hasAppLicense = answer
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
    #expect(!sut.requiresPurchase)

    Game.timesPlayed = Monetizer.maxFreeGames
    #expect(sut.requiresPurchase)
  }

  @Test
  func `knows the license is active when the store says it is`() {
    let sut = Monetizer(store: TestStore(true))
    #expect(sut.hasAppLicense)
  }

  @Test
  func `knows the license is inactive when the store says that`() {
    let sut = Monetizer(store: TestStore(false))
    #expect(!sut.hasAppLicense)
  }
}
