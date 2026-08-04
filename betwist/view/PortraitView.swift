import model
import SwiftUI

public struct PortraitView: View {
  var geometry: GeometryProxy
  @Binding var game: Game
  var collectWord: () -> Void
  var handleSelection: (Location) -> Void
  var showOnboarding: () -> Void

  @Binding var showAnswers: Bool
  @State private var progress = 0.0

  func adjustedHeight(_ size: CGSize) -> Double {
    let width = size.width
    let aspectRatio = size.height / width
    return aspectRatio < 1.75 ? 0.85 * width : 1.0 * width
  }

  public var body: some View {
    VStack {
      Spacer()
        .frame(height: 12)

      RotatingGridView(
        game: game,
        handleSelection: handleSelection,
        width: geometry.size.width,
        height: adjustedHeight(geometry.size)
      )
      .zIndex(5)

      MessageView(mode: game.mode, guessStatus: game.guessStatus, )
        .font(.title)
        .frame(maxWidth: .infinity, minHeight: 40)

      AnswerInProgressView(
        game: game,
        progress: progress,
        height: 500,
        showOnboarding: showOnboarding,
        acceptWord: { collectWord() }
      )

      ScrollView {
        HStack(alignment: .top) {
          Spacer()

          StatisticsView(statistics: game.statistics)
            .font(.title3)

          Spacer()

          AnswersSummaryView(game: game)

          Spacer()
        }
      }

      Spacer()

      GameButtons(game: $game, showAnswers: $showAnswers)
      .padding([.top, .bottom], 8)
      .padding([.leading, .trailing], 24)
    }
  }
}
