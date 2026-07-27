import model
import SwiftUI

struct AnswersView: View {
  var whoFound: String
  var minimumWordSize: Int
  var answers: Answers
  var matchingAnswers: Answers

  var body: some View {
    VStack {
      Group {
        Text("\(whoFound) Found")
          .font(.title2)

        Text("\(minimumWordSize)+ letters only")
          .font(.footnote)

        if answers.isEmpty {
          Text("(None yet)")
            .font(.footnote)
        }
      }
      .foregroundStyle(.black)

      SortedAnswersView(
        answers: answers,
        matchingAnswers: matchingAnswers
      )

      Spacer()
    }
  }
}
