import model
import SwiftUI

public struct LandscapeView: View {
  var geometry: GeometryProxy
  @Binding var game: Game
  var collectWord: () -> Void
  var handleSelection: (Location) -> Void
  var showOnboarding: () -> Void

  @Binding var showAnswers: Bool

  @State private var progress = 0.0

  public var body: some View {
    HStack(alignment: .top) {
      VStack {
        AnswerInProgressView(
          game: game,
          progress: progress,
          height: 500,
          showOnboarding: showOnboarding,
          acceptWord: { collectWord() },
        )

        VStack(spacing: 8) {
          MessageView(mode: game.mode, guessStatus: game.guessStatus)
            .font(.title)
            .frame(minHeight: 40)

          StatisticsView(statistics: game.statistics)
            .font(.title)
            .padding([.bottom], 20)

          AnswersSummaryView(game: game)
            .font(.title)

          Spacer()

          HStack {
            PrimaryActionButton(game: $game)

            Button("Show Words...") {
              showAnswers = true
            }
            .capsuled()
          }
          .font(.title)
          .padding([.bottom], 20)
        }
      }
      .padding(.top, 64)
      .frame(height: geometry.size.height)

      RotatingGridView(
        game: game,
        handleSelection: handleSelection,
        width: geometry.size.height,
        height: geometry.size.height
      )
      .zIndex(5)
    }
    .padding(.top, 20)
  }
}
