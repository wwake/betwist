import SwiftUI

struct SortedAnswersView: View {
  let answers: Answers

  var body: some View {
    VStack {
      List {
        ForEach(answers.wordSizes, id: \.self) { size in
          Section(header: Text("\(size) letters")) {
            ForEach(answers.words(ofSize: size)) { answer in
              Text(verbatim: answer.word)
                .bold()
                .foregroundStyle(answer.enteredByUser ? .userWordListForeground : .accent)
            }
          }
        }
      }
      .listStyle(.plain)
    }
  }
}
