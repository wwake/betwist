import SwiftUI

struct ScoreView: View {
  var score: Score

  var body: some View {
    VStack(alignment: .leading) {
      Text("Score")

      Group {
        Text("Words: \(score.wordCount)")

        Text("Letters: \(score.letterCount)")

        Text("Most Letters: \(score.mostLetters)")
      }
      .scaleEffect(0.9)
    }
    .bold()
    .padding(12)
    .border(.white, width: 2)
  }
}
