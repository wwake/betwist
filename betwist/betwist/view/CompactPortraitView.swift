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
    return aspectRatio < 1.75 ? 0.95 * width : 1.05 * width
  }

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
        .frame(maxHeight: adjustedHeight(geometry.size), alignment: .top)
        .clipped()

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
