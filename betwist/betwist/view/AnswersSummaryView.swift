import SwiftUI

struct AnswersSummaryView: View {
  @Binding var game: Game
  var viewAction: () -> Void

  var body: some View {
    VStack {
      if !game.answers.isEmpty {
        Text("Latest Found")
          .font(.title3)
          .underline()

        Text(verbatim: game.answers.preview)
      }

      Button("Your Answers...") {
        viewAction()
      }
      .capsuled()
    }
    .bold()
  }
}
