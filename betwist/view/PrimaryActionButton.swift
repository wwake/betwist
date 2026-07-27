import model
import SwiftUI

struct PrimaryActionButton: View {
  @Binding var game: Game

  @Binding var showAnswers: Bool

  var body: some View {
    Group {
      switch game.mode {
      case .play:
        Button("End Game...") {
          withAnimation {
            showAnswers = true
          }
          game.over()
        }
        .capsuled(.red)

      case .review:
        Button("New Game") {
          withAnimation {
            showAnswers = false
          }
          game = Game(game.size, GameGenerator(game.size).make(), game.vocabulary)
          game.start()
        }
        .capsuled(.red)

      case .buy:
        Button("Buy...") {
          print("buy")
        }
        .capsuled()

      @unknown default:
        fatalError("PrimaryActionButton - unexpected case \(game.mode)")
      }
    }
  }
}
