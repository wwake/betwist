import model
import SwiftUI

struct AnswersSummaryView: View {
  var game: Game

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
