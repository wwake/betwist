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

  public var hasFreeGamesRemaining: Bool {
    freeGamesRemaining > 0
  }
}
