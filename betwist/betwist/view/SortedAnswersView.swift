import SwiftUI

struct SortedAnswersView: View {
  let lookupIcon = Image(systemName: "text.magnifyingglass")
    .accessibilityLabel("Definition")

  @State var showDefinition = false
  @State var definitions: Words?

  let answers: Answers
  let matchingAnswers: Answers

  func lookupAction(_ word: String) {
    definitions = nil
    showDefinition = true
  }

  func wordView(_ word: String) -> some View {
    Button(action: { lookupAction(word) }) {
      HStack(spacing: 2) {
        Text(verbatim: word)
          .bold()
          .strikethrough(matchingAnswers.contains(word))
        lookupIcon
      }
    }
//    .popover(isPresented: $showDefinition, arrowEdge: .bottom) {
//      DefinitionsView(definitions: definitions)
//    }
  }

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
              wordView(answer.word)
            }
          }
        }
      }
      .listStyle(.plain)
    }
  }
}

struct DefinitionsView: View {
  var definitions: Words?

  var body: some View {
    Text("Hello world")
  }
}
