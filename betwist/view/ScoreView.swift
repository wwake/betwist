import model
import SwiftUI

struct StatisticsView: View {
  var statistics: Statistics

  var body: some View {
    VStack(alignment: .leading) {
      Text("Statistics")
        .underline()

      Group {
        Text("Words: \(statistics.wordCount)")
          .fixedSize()

        Text("Letters: \(statistics.letterCount)")
          .fixedSize()

        Text("Longest: \(statistics.mostLetters)")
          .fixedSize()
      }
    }
    .bold()
    .padding(12)
    .border(.white, width: 2)
  }
}

#Preview {
  StatisticsView(statistics: Statistics(wordCount: 0, letterCount: 0, mostLetters: 0))

  StatisticsView(statistics: Statistics(wordCount: 500, letterCount: 9999, mostLetters: 97))
}
