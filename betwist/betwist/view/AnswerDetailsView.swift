import SwiftUI

struct AnswerDetailsView: View {
  @Environment(\.dismiss)
  var dismiss

  var guesses: Guesses

  var body: some View {
    VStack {
      ScrollView {
        Text(verbatim: guesses.description)
          .font(.title)
      }
      Button("Done") {
        dismiss()
      }
      .capsuled()
    }
    .padding()
  }
}
