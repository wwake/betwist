import SwiftUI

struct AnswersView: View {
  @Binding var game: Game
  var viewAction: () -> Void

  var body: some View {
    VStack {
      //   Text(verbatim: String(Array(game.allAnswers).joined(by: "\n")))

      Text("Found Words")
        .font(.title3)

      Text(verbatim: game.answers.preview)

      Button("More...") {
        viewAction()
      }
      .capsuled()
    }
    .bold()
    .frame(width: 150)
    .opacity(game.answers.isEmpty ? 0 : 1)
  }
}
