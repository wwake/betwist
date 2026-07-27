public struct Monetizer {
  public static let maxFreeGames = 20

  public init() {}

  public var freeGamesRemaining: Int {
    max(0, Self.maxFreeGames - Game.timesPlayed)
  }

  public var hasFreeGamesRemaining: Bool {
    false
    // freeGamesRemaining > 0
  }
}
