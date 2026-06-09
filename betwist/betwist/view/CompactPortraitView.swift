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
      Spacer()
        .frame(height: 12)

      RotatingGridView(
        game: $game,
        handleSelection: handleSelection,
        width: geometry.size.width,
        height: adjustedHeight(geometry.size)
      )
      .zIndex(5)

      MessageView(message: game.message)
        .font(.title)
        .frame(maxWidth: .infinity, minHeight: 40)

      AnswerInProgressView(game: $game, progress: progress, height: 500) {
        collectWord()
      }

      ScrollView {
        HStack(alignment: .top) {
          Spacer()

          ScoreView(score: game.score)
            .font(.title3)

          Spacer()

          AnswersSummaryView(game: $game)

          Spacer()
        }
      }

      Spacer()

      NewGameButton(game: $game)
        .padding([.top, .bottom], 8)
    }
    .sheet(isPresented: $showAnswers) {
      AnswerDetailsView(
        score: game.score,
        answers: game.answers,
        allAnswers: game.systemAnswers,
        mode: $game.mode
      )
    }
  }
}
