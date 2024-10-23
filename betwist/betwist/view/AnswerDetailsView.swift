import SwiftUI

struct AnswerDetailsView: View {
  @Environment(\.dismiss)
  var dismiss

  var answers: Answers

  var body: some View {
    VStack {
      Text("Words You Found")
        .font(.title)

      ScrollView {
        ForEach(answers.values) {
          Text(verbatim: $0.word)
            .bold($0.enteredByUser)
            .foregroundStyle($0.enteredByUser ? .black : .accent)
        }
      }

      Button("Back") {
        dismiss()
      }
      .capsuled()
    }
    .padding()
  }
}
