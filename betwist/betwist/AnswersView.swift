import SwiftUI

struct AnswersView: View {
  @Binding var game: Game
  var viewAction: () -> Void

  var body: some View {
    VStack {
      HStack {
        Button {
          viewAction()
        } label: {
          Image(systemName: "doc.text.magnifyingglass")
            .accessibilityLabel(Text("View Guesses"))
        }

        ScrollView {
          Text("Found Words")
            .font(.title3)
            .bold()
          Text(verbatim: game.guesses.description)
            .font(.title2)
            .frame(width: 150)
          //            Divider()
          //            Text("All answers")
          //            Text(verbatim: "\(game.allAnswers)")
        }
      }
      .opacity(game.guesses.isEmpty ? 0 : 1)
    }
  }
}
