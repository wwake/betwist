import SwiftUI

struct SortedAnswersView: View {
  let lookupIcon = Image(systemName: "text.magnifyingglass")
    .accessibilityLabel("Definition")

  let answers: Answers
  let matchingAnswers: Answers

  var body: some View {
    VStack {
      List {
        ForEach(answers.wordSizes, id: \.self) { size in
          Section(
            header: Text("\(size) letters").foregroundStyle(
              .userWordListForeground
            )
          ) {
            ForEach(answers.words(ofSize: size)) { answer in
              Button(action: { print("lookup \(answer.word)") }) {
                HStack(spacing: 2) {
                  Text(verbatim: answer.word)
                    .bold()
                    .strikethrough(matchingAnswers.contains(answer.word))
                  lookupIcon
                }
              }
            }
          }
        }
      }
      .listStyle(.plain)
    }
  }
}
