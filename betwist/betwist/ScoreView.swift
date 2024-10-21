import SwiftUI

struct ScoreView: View {
  var score: Score

  var body: some View {
    VStack(alignment: .leading) {
      Text("Score")
        .font(.title3)

      Text("Words: \(score.wordCount)")

      Text("Letters: \(score.letterCount)")

      Text("Most Letters: \(score.mostLetters)")
    }
    .bold()
  }
}
