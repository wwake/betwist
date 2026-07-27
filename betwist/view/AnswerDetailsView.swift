import model
import SwiftUI

struct AnswerDetailsView: View {
  var closeAction: () -> Void
  @Binding var showAnswers: Bool

  var statistics: Statistics
  var answers: Answers
  var allAnswers: Answers

  fileprivate func wordsSystemFound() -> some View {
    VStack {
      Text("System Found")
        .font(.title2)

      if answers.isEmpty {
        Text("(None yet)")
          .font(.footnote)
      }

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
      Text("Game Over")
        .font(.title2)

      StatisticsView(statistics: statistics)
        .font(.title3)

      HStack {
        AnswersView(
          whoFound: "You",
          minimumWordSize: 4,
          answers: answers,
          matchingAnswers: Answers()
        )
          .frame(maxWidth: .infinity)

        Divider()
          .frame(width: 2)

        AnswersView(
          whoFound: "System",
          minimumWordSize: 6,
          answers: allAnswers,
          matchingAnswers: answers,
        )
          .foregroundStyle(.accent)
          .frame(maxWidth: .infinity)
      }

      Button("Back") {
        closeAction()
      }
      .capsuled()
      .frame(width: 100)
    }
    .padding()
    .background(Color.white)
  }
}
