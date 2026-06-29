import SwiftUI

struct NewGameButton: View {
  @Binding var game: Game

  @Binding var showAnswers: Bool

  var body: some View {
    Group {
      if game.mode == .play {
        Button("Reveal...") {
          withAnimation {
            showAnswers = true
          }
          game.over()
        }
        .capsuled()
      } else {
        Button("New Game") {
          withAnimation {
            showAnswers = false
          }
          game = Game(game.size, GameGenerator(game.size).make(), game.vocabulary)
          game.start()
        }
        .capsuled()
      }
    }
  }
}
