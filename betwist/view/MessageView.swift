import model
import SwiftUI

struct MessageView: View {
  @Environment(Monetizer.self)
  var monetizer

  static let guessMessage = [
    GuessStatus.ok: "",
    .tooShort: "Too short!",
    .duplicate: "Duplicate!",
    .nonWord: "Not a word!",
  ]

  var mode: GameMode
  var guessStatus: GuessStatus

  var messageBody: String {
    switch mode {
    case .play:
      return MessageView.guessMessage[guessStatus] ?? ""

    case .review:
      if !monetizer.requiresPurchase {
        return "\(monetizer.freeGamesRemaining) free game(s) left"
      }
      return "No more free games"

    @unknown default:
      fatalError("MessageView mode \(mode)")
    }
  }

  var body: some View {
    Text(messageBody)
      .bold()
      .foregroundStyle(.red)
      .opacity(messageBody.isEmpty ? 0.0 : 1.0)
  }
}
