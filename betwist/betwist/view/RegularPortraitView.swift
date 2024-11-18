import SwiftUI

struct RegularPortraitView: View {
  var geometry: GeometryProxy
  @Binding var game: Game
  var collectWord: () -> Void
  var handleSelection: (Location) -> Void

  @State private var showAnswers = false
  @State private var progress = 0.0

  var body: some View {
    VStack {
      if ContentView.showMakerView {
        MakerView(game: game)
      }

      HStack {
        Spacer()
        VStack {
          AnswerInProgressView(game: $game, progress: progress, height: 500) {
            collectWord()
          }

          MessageView(message: game.message)
            .font(.title)
            .frame(height: 40)
        }
        Spacer()

        HStack {
          ScoreView(score: game.score)

          VStack {
            AnswersSummaryView(game: $game) {
              showAnswers.toggle()
            }

          }
        }
        Spacer()
      }
      .zIndex(5)

      RotatingGridView(game: $game, handleSelection: handleSelection, width: geometry.size.width)

      Spacer()

      NewGameButton(game: $game)
        .padding(.bottom, 12)
    }
    .padding(.top, 20)
    .sheet(isPresented: $showAnswers) {
      AnswerDetailsView(answers: game.answers, allAnswers: game.allTheAnswers, mode: $game.mode)
    }
  }
}
