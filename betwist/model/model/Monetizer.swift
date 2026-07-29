import Foundation

@Observable
public class Monetizer {
  public static let maxFreeGames = 20

  private var store: Store

  public init(store: Store) {
    self.store = store
  }

  public var freeGamesRemaining: Int {
    max(0, Self.maxFreeGames - Game.timesPlayed)
  }

  public var allowsPlay: Bool {
    hasAppLicense || freeGamesRemaining > 0
  }

  public var hasAppLicense: Bool {
    store.hasAppLicense
  }

  public var allowsPurchase: Bool {
    store.allowsPurchase
  }
}
