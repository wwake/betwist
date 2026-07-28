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
  func `knows the license is active when the store says it is`() {
    let sut = Monetizer(store: TestStore(true))
    #expect(sut.hasAppLicense)
  }

  @Test
  func `knows the license is inactive when the store says that`() {
    let sut = Monetizer(store: TestStore(false))
    #expect(!sut.hasAppLicense)
  }

  @Test
  func `knows the number of free games remaining`() async throws {
    let sut = Monetizer(store: TestStore())
    #expect(Monetizer.maxFreeGames > 10)

    Game.timesPlayed = 7
    #expect(sut.freeGamesRemaining == Monetizer.maxFreeGames - 7)
  }

  @Test
  func `knows whether play is allowed when no license present`() async throws {
    let sut = Monetizer(store: TestStore(false))

    Game.timesPlayed = 1
    #expect(sut.allowsPlay)

    Game.timesPlayed = Monetizer.maxFreeGames
    #expect(!sut.allowsPlay)
  }

  @Test
  func `knows play is allowed when license found`() {
    let sut = Monetizer(store: TestStore(true))
    Game.timesPlayed = Monetizer.maxFreeGames
    #expect(sut.allowsPlay)
  }
}
