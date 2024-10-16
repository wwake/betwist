import SwiftUI

struct ScoreView: View {
  @Binding var game: Game


  var body: some View {
    VStack(alignment: .leading) {
        Text("Score")
          .font(.title3)

      Text("Words: \(game.wordCount)")
        .bold()

      Text("Letters: \(game.letterCount)")

      Text("Most Letters: \(game.mostLetters)")
    }
    .bold()
  }
}


//#Preview {
//    ScoreView()
//}
