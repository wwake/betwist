import SwiftUI

struct CompactPortraitView: View {
  var geometry: GeometryProxy
  @Binding var game: Game
  var collectWord: () -> Void
  var handleSelection: (Location) -> Void

  @State private var showAnswers = false
  @State private var progress = 0.0

  func adjustedHeight(_ size: CGSize) -> Double {
    let width = size.width
    let aspectRatio = size.height / width
    return aspectRatio < 1.75 ? 0.85 * width : 1.0 * width
  }

  var body: some View {
    VStack {
      RotatingGridView(
        game: $game,
        handleSelection: handleSelection,
        width: geometry.size.width,
        height: adjustedHeight(geometry.size)
      )
      .zIndex(5)

      MessageView(message: game.message)
        .font(.title)
        .frame(height: 24)
        .frame(maxWidth: .infinity)

      AnswerInProgressView(game: $game, progress: progress, height: 500) {
        collectWord()
      }

      ViewThatFits(in: .vertical) {
        HStack(alignment: .top) {
          ScoreView(score: game.score)
            .font(.title3)

          AnswersSummaryView(game: $game) {
            showAnswers.toggle()
          }
        }

        Text("")
      }

      NewGameButton(game: $game)
        .padding([.top, .bottom], 4)
    }
    .sheet(isPresented: $showAnswers) {
      AnswerDetailsView(score: game.score, answers: game.answers, allAnswers: game.systemAnswers, mode: $game.mode)
    }
  }
}
