import Foundation

@Observable
public class Monetizer {
  public static let maxFreeGames = 20

  private var store: Store
  private(set) var timesPlayed: Int

  public init(store: Store) {
    self.store = store
    timesPlayed = UserDefaults.standard.integer(forKey: "timesPlayed")
  }

  public var freeGamesRemaining: Int {
    max(0, Self.maxFreeGames - timesPlayed)
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

  public func startedNewGame() {
    timesPlayed += 1
    UserDefaults.standard.set(timesPlayed, forKey: "timesPlayed")
  }

  func setTimesPlayed(_ value: Int) {
    timesPlayed = value
    UserDefaults.standard.set(value, forKey: "timesPlayed")
  }
}
