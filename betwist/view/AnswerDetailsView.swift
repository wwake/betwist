import model
import SwiftUI

struct AnswerDetailsView: View {
  @Binding var showAnswers: Bool

  var statistics: Statistics
  var answers: Answers
  var allAnswers: Answers

  fileprivate func wordsSystemFound() -> some View {
    VStack {
      Text("System Found")
        .font(.title2)

      Text("6+ letters only")
        .font(.footnote)

      SortedAnswersView(
        answers: allAnswers,
        matchingAnswers: answers,
      )
      .foregroundStyle(.accent)

      Spacer()
    }
  }

  var body: some View {
    VStack {
      StatisticsView(statistics: statistics)
        .font(.title3)

      HStack {
        YouFoundView(answers: answers)
          .frame(maxWidth: .infinity)

        Divider()
          .frame(width: 2)

        wordsSystemFound()
          .frame(maxWidth: .infinity)
      }

      Button("Done") {
        withAnimation {
          showAnswers = false
        }
      }
      .capsuled()
    }
    .padding()
    .background(Color.white)
  }
}
