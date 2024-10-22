import SwiftUI

struct AnswerDetailsView: View {
  @Environment(\.dismiss)
  var dismiss

  var guesses: Guesses

  var body: some View {
    VStack {
      Text("Words You Found")
        .font(.title)

      ScrollView {
        ForEach(guesses.guesses) {
          Text(verbatim: $0.word)
            .bold($0.userGuessed)
            .foregroundStyle($0.userGuessed ? .black : .accent)
        }
      }

      Button("Done") {
        dismiss()
      }
      .capsuled()
    }
    .padding()
  }
}
