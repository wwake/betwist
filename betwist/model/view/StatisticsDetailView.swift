import SwiftUI

struct StatisticsDetailView: View {
  @Environment(\.dismiss)
  var dismiss

  var statistics: Statistics

  var body: some View {
    VStack {
      Spacer()
      StatisticsView(statistics: statistics)
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
  StatisticsDetailView(statistics: Statistics(wordCount: 10, letterCount: 20, mostLetters: 30))
}
