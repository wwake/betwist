import SwiftUI

struct AnswersSummaryView: View {
  @Binding var game: Game

  var body: some View {
    VStack {
      Text("Latest Found")
        .font(.title3)
        .underline()

      if game.answers.isEmpty {
        Text("(None yet)")
      }

      Text(verbatim: game.answers.preview)
    }
    .bold()
  }
}
