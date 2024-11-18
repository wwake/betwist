import SwiftUI

struct CompactPortraitView: View {
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

      AnswerInProgressView(game: $game, progress: progress, height: 500) {
        collectWord()
      }
      .zIndex(5)

      MessageView(message: game.message)
        .frame(height: 24)
        .frame(maxWidth: .infinity)
        .font(.title)

      RotatingGridView(game: $game, handleSelection: handleSelection, width: geometry.size.width)

      HStack(alignment: .top) {
        VStack {
          ScoreView(score: game.score)
            .font(.title3)

          NewGameButton(game: $game)
        }

        AnswersSummaryView(game: $game) {
          showAnswers.toggle()
        }
      }
      .padding(.top, 12)

      Spacer()
    }
    .sheet(isPresented: $showAnswers) {
      AnswerDetailsView(answers: game.answers, allAnswers: game.allTheAnswers, mode: $game.mode)
    }
  }
}
