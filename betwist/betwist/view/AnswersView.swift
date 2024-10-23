import SwiftUI

struct AnswersView: View {
  @Binding var game: Game
  var viewAction: () -> Void

  var body: some View {
    VStack(spacing: 0) {
      Button("More...") {
        viewAction()
      }
      .capsuled()

      Text(verbatim: String(Array(game.allAnswers).joined(by: "\n")))

      ScrollView {
        Text("Found Words")
          .font(.title3)

        Text(verbatim: game.guesses.preview)
          .frame(width: 150)
      }
      .bold()
      .opacity(game.guesses.isEmpty ? 0 : 1)
    }
  }
}
