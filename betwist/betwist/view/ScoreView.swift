import SwiftUI

struct ScoreView: View {
  var score: Score

  var body: some View {
    VStack(alignment: .leading) {
      Text("Score")
        .underline()

      Group {
        Text("Words: \(score.wordCount)")
          .fixedSize()

        Text("Letters: \(score.letterCount)")

        Text("Longest: \(score.mostLetters)")
      }
      .scaleEffect(0.9)
    }
    .bold()
    .padding(12)
    .border(.white, width: 2)
  }
}

#Preview {
  ScoreView(score: Score(wordCount: 0, letterCount: 0, mostLetters: 0))

  ScoreView(score: Score(wordCount: 500, letterCount: 9999, mostLetters: 97))
}
