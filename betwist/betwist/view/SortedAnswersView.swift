import SwiftUI

struct SortedAnswersView: View {
  let answers: Answers

  var body: some View {
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
