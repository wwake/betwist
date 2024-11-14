import SwiftUI

struct YouFoundView: View {
  var answers: Answers

  var body: some View {
    VStack {
      Text("You Found")
        .bold()

      if answers.isEmpty {
        Text("(None yet)")
      }

      SortedAnswersView(answers: answers)
    }
  }
}
