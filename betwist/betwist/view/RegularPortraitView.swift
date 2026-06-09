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
      HStack {
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
          StatisticsView(statistics: game.statistics)

          VStack {
            AnswersSummaryView(game: $game)
          }
        }
        Spacer()
      }

      RotatingGridView(
        game: $game,
        handleSelection: handleSelection,
        width: geometry.size.width,
        height: geometry.size.height
      )

      Spacer()

      NewGameButton(game: $game)
        .padding(.bottom, 12)
    }
    .padding(.top, 20)
    .sheet(isPresented: $showAnswers) {
      AnswerDetailsView(
        statistics: game.statistics,
        answers: game.answers,
        allAnswers: game.systemAnswers,
        mode: $game.mode
      )
    }
  }
}
