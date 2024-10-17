import SwiftUI

struct ScoreView: View {
  @Binding var game: Game

  var body: some View {
    VStack(alignment: .leading) {
        Text("Score")
          .font(.title3)

      Text("Words: \(game.score.wordCount)")

      Text("Letters: \(game.score.letterCount)")

      Text("Most Letters: \(game.score.mostLetters)")
    }
    .bold()
  }
}


//#Preview {
//    ScoreView()
//}
