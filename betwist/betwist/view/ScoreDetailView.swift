import SwiftUI

struct ScoreDetailView: View {
  var score: Score

  var body: some View {
    Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
  }
}

#Preview {
  ScoreDetailView(score: Score(wordCount: 10, letterCount: 20, mostLetters: 30))
}
