import SwiftUI

struct ScoreDetailView: View {
  @Environment(\.dismiss)
  var dismiss

  var score: Score

  var body: some View {
    VStack {
      Spacer()
      ScoreView(score: score)
        .border(.black, width: 2)
        .scaleEffect(1.5)

      Spacer()
      
      Button("Back") {
        dismiss()
      }
      .capsuled()
    }
    .padding()
  }
}


#Preview {
  ScoreDetailView(score: Score(wordCount: 10, letterCount: 20, mostLetters: 30))
}
