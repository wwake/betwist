import model
import SwiftUI

struct AnswerDetailsView: View {
  var closeAction: () -> Void
  @Binding var showAnswers: Bool

  var statistics: Statistics
  var userAnswers: Answers
  var systemAnswers: Answers

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
          answers: userAnswers,
          matchingAnswers: Answers()
        )
        .frame(maxWidth: .infinity)

        Divider()
          .frame(width: 2)

        AnswersView(
          whoFound: "System",
          minimumWordSize: 6,
          answers: systemAnswers,
          matchingAnswers: userAnswers,
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
    .background(.wordBackground)
  }
}
