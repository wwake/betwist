import SwiftUI

struct AnswerDetailsView: View {
  @Environment(\.dismiss)
  var dismiss

  var answers: Answers
  var allAnswers: Answers

  @Binding var mode: GameMode

  fileprivate func wordsSystemFound() -> some View {
    VStack {
      if mode == .review {
        Text("System Found")
          .font(.title2)

        Text("6+ letters only")
          .font(.footnote)

        SortedAnswersView(answers: allAnswers)
      }
      Spacer()
    }
  }

  var body: some View {
    VStack {
      HStack {
        YouFoundView(answers: answers)
          .frame(maxWidth: .infinity)

        Divider()
          .frame(width: 2)

        wordsSystemFound()
          .frame(maxWidth: .infinity)
      }

      Button("Done") {
        dismiss()
      }
      .capsuled()
    }
    .padding()
  }
}
