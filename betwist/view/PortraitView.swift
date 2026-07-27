import model
import SwiftUI

struct PortraitView: View {
  var geometry: GeometryProxy
  @Binding var game: Game
  var collectWord: () -> Void
  var handleSelection: (Location) -> Void
  var showOnboarding: () -> Void

  @State private var showAnswers = false
  @State private var progress = 0.0

  func adjustedHeight(_ size: CGSize) -> Double {
    let width = size.width
    let aspectRatio = size.height / width
    return aspectRatio < 1.75 ? 0.85 * width : 1.0 * width
  }

  func boardView() -> some View {
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

      MessageView(message: game.message)
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

      HStack {
        PrimaryActionButton(
          game: $game,
          showAnswers: $showAnswers
        )

        Button("Show Words...") {
          showAnswers = true
        }
        .capsuled()
      }
      .padding([.top, .bottom], 8)
      .padding([.leading, .trailing], 24)
    }
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
