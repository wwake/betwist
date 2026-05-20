import SwiftUI

struct NewGameButton: View {
  @Binding var game: Game

  @State private var showAnswers = false

  var body: some View {
    Group {
      if game.mode == .play {
        Button("Done") {
          game.mode = .review
          showAnswers = true
        }
        .capsuled()
      } else {
        Button("Start New Game") {
          showAnswers = false
          game = Game(game.size, GameGenerator(game.size).make(), game.vocabulary)
        }
        .capsuled()
      }
    }
    .sheet(isPresented: $showAnswers) {
      AnswerDetailsView(answers: game.answers, allAnswers: game.systemAnswers, mode: $game.mode)
    }
  }
}
