import SwiftUI

struct ScoreView: View {
  var score: Score

  var body: some View {
    VStack(alignment: .leading) {
      Text("Statistics")
        .underline()

      Group {
        Text("Words: \(score.wordCount)")
          .fixedSize()

        Text("Letters: \(score.letterCount)")
          .fixedSize()

        Text("Longest: \(score.mostLetters)")
          .fixedSize()
      }
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
