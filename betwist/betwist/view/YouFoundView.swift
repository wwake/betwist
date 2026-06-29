import SwiftUI

struct YouFoundView: View {
  var answers: Answers

  var body: some View {
    VStack {
      Text("You Found")
        .font(.title2)

      if answers.isEmpty {
        Text("(None yet)")
          .font(.footnote)
      }

      SortedAnswersView(
        answers: answers,
        matchingAnswers: Answers()
      )
    }
  }
}
