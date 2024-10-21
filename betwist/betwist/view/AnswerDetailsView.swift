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
      .bold()
      .padding(6)
      .foregroundStyle(.white)
      .background(.accent)
      .cornerRadius(10)
    }
    .padding()
  }
}
