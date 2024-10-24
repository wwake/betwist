import SwiftUI

struct AnswerDetailsView: View {
  @Environment(\.dismiss)
  var dismiss

  var answers: Answers

  fileprivate func wordsYouFound() -> some View {
    VStack {
      Text("You Found")
        .font(.title2)

      List {
        ForEach(answers.wordSizes, id: \.self) { size in
          Section(header: Text("\(size) letters")) {
            ForEach(answers.words(ofSize: size)) { answer in
              Text(verbatim: answer.word)
                .bold(answer.enteredByUser)
                .foregroundStyle(answer.enteredByUser ? .black : .accent)
            }
          }
        }
      }
      .listStyle(.plain)
    }
  }

  var body: some View {
    VStack {
      HStack {
        wordsYouFound()

        Spacer()

        wordsYouFound()
          .opacity(0)
      }

      Button("Back") {
        dismiss()
      }
      .capsuled()
    }
    .padding()
  }
}
