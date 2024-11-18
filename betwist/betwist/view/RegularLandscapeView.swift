import SwiftUI

struct RegularLandscapeView: View {
  var geometry: GeometryProxy
  @Binding var game: Game
  var collectWord: () -> Void
  var handleSelection: (Location) -> Void

  @State private var showAnswers = false
  @State private var progress = 0.0

  var body: some View {
    HStack(alignment: .top) {
      VStack {
        AnswerInProgressView(game: $game, progress: progress, height: 500) {
          collectWord()
        }

        VStack(spacing: 8) {
          MessageView(message: game.message)
            .font(.title)
            .frame(maxWidth: .infinity)
            .padding([.bottom], 20)

          ScoreView(score: game.score)
            .font(.title)
            .padding([.bottom], 20)

          NewGameButton(game: $game)
            .font(.title)
            .padding([.bottom], 20)

          YouFoundView(answers: game.answers)
            .font(.title)
            .frame(width: 250)

          Button("More...") {
            showAnswers.toggle()
          }
          .capsuled()
          .font(.title)
          .padding(12)
        }
      }
      .zIndex(5)

      RotatingGridView(game: $game, handleSelection: handleSelection, width: geometry.size.height)
    }
    .padding(.top, 20)
    .sheet(isPresented: $showAnswers) {
      AnswerDetailsView(answers: game.answers, allAnswers: game.allTheAnswers, mode: $game.mode)
    }
  }
}
