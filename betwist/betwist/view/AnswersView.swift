import SwiftUI

struct AnswersView: View {
  @Binding var game: Game
  var viewAction: () -> Void

  var body: some View {
    VStack {
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

  }
}
