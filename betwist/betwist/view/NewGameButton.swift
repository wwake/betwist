import SwiftUI

struct NewGameButton: View {
  @Binding var game: Game

  @State private var showAnswers = false

  var body: some View {
    Group {
      if game.mode == .play {
        Button("Reveal...") {
          showAnswers = true
          game.over()
        }
        .capsuled()
      } else {
        Button("New Game") {
          showAnswers = false
          game = Game(game.size, GameGenerator(game.size).make(), game.vocabulary)
          game.start()
        }
        .capsuled()
      }
    }
    .sheet(isPresented: $showAnswers) {
      AnswerDetailsView(
        statistics: game.statistics,
        answers: game.answers,
        allAnswers: game.systemAnswers,
      )
    }
  }
}
