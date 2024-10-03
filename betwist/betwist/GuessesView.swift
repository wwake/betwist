import SwiftUI

struct GuessesView: View {
  @Environment(\.dismiss)
  var dismiss

  var guesses: [String]

  var body: some View {
    VStack {
      ScrollView {
        Text(verbatim: String(guesses.joined(by: "\n")))
          .font(.title)
      }
      Button("Done") {
        dismiss()
      }
      .buttonStyle(.bordered)
      .foregroundStyle(Color.black)
      .padding(8)
    }
  }
}
