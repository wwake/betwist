import SwiftUI

struct AnswersView: View {
  @Binding var game: Game
  var viewAction: () -> Void

  var body: some View {
    VStack {
        ScrollView {
          Text("Found Words")
            .font(.title3)
            .bold()

          Text(verbatim: game.guesses.preview)
            .font(.title2)
            .frame(width: 150)

          Button("More...") {
            viewAction()
          }
          .capsuled()
        }
      .opacity(game.guesses.isEmpty ? 0 : 1)
    }
  }
}
