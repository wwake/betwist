public struct Monetizer {
  public static let maxFreeGames = 20

  public var freeGamesRemaining: Int {
    max(0, Self.maxFreeGames - Game.timesPlayed)
  }

  public var hasFreeGamesRemaining: Bool {
    freeGamesRemaining > 0
  }
}
