import model
import SwiftUI

struct LandscapeView: View {
  var geometry: GeometryProxy
  @Binding var game: Game
  var collectWord: () -> Void
  var handleSelection: (Location) -> Void
  var showOnboarding: () -> Void

  @State private var showAnswers = false
  @State private var progress = 0.0

  func boardView() -> some View {
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
          MessageView(message: game.message)
            .font(.title)
            .frame(minHeight: 40)

          StatisticsView(statistics: game.statistics)
            .font(.title)
            .padding([.bottom], 20)

          AnswersSummaryView(game: game)
            .font(.title)

          Spacer()

          HStack {
            PrimaryActionButton(
              game: $game,
              showAnswers: $showAnswers
            )

            Button("Show Words...") {
              print("show words")
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

  var body: some View {
    if showAnswers {
      AnswerDetailsView(
        closeAction: {
          withAnimation {
            showAnswers = false
          }
        },
        showAnswers: $showAnswers,
        statistics: game.statistics,
        userAnswers: game.answers,
        systemAnswers: game.systemAnswers,
      )
      .transition(
        .asymmetric(
          insertion: .push(from: .trailing),
          removal: .push(from: .leading)
        )
      )
    } else {
      boardView()
    }
  }
}
