import SwiftUI

struct AnswersSummaryView: View {
  @Binding var game: Game
  var viewAction: () -> Void

  var body: some View {
    VStack {
      if !game.answers.isEmpty {
        Text("Found Words")
          .font(.title3)

        Text(verbatim: game.answers.preview)
      }

      Button("All Answers...") {
        viewAction()
      }
      .capsuled()
    }
    .bold()
  }
}
