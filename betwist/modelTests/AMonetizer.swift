import Foundation
@testable import model
import Testing

private class TestStore: Store {
  let hasAppLicense: Bool
  let allowsPurchase = true

  init(_ answer: Bool = false) {
    hasAppLicense = answer
  }
}

@Suite(.serialized)   // serialize since multiple tests change Game.timesPlayed
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

    sut.setTimesPlayed(7)

    #expect(sut.freeGamesRemaining == Monetizer.maxFreeGames - 7)
  }

  @Test
  func `counts the number of times played`() {
    let sut = Monetizer(store: TestStore())
    let original = sut.timesPlayed
    sut.startedNewGame()
    #expect(sut.timesPlayed == original + 1)
    #expect(UserDefaults.standard.integer(forKey: "timesPlayed") == sut.timesPlayed)
  }

  @Test
  func `knows whether play is allowed when no license present`() async throws {
    let sut = Monetizer(store: TestStore(false))

    sut.setTimesPlayed(1)
    #expect(sut.allowsPlay)

    sut.setTimesPlayed(Monetizer.maxFreeGames)
    #expect(!sut.allowsPlay)
  }

  @Test
  func `knows play is allowed when license found`() {
    let sut = Monetizer(store: TestStore(true))
    sut.setTimesPlayed(Monetizer.maxFreeGames)
    #expect(sut.allowsPlay)
  }
}
