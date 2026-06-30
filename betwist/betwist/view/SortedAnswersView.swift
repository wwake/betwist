import SwiftUI

struct SortedAnswersView: View {
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
              WordView(word: answer.word, matchingAnswers: matchingAnswers)
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

struct WordView: View {
  let word: String
  let matchingAnswers: Answers

  @State var definitions: Words?

  @State var showDefinition = false

  let lookupIcon = Image(systemName: "text.magnifyingglass")
    .accessibilityLabel("Definition")

  func lookupAction(_ word: String) {
    definitions = nil
    showDefinition = true
  }

  var body: some View {
    Button(action: { lookupAction(word) }) {
      HStack(spacing: 2) {
        Text(verbatim: word)
          .bold()
          .strikethrough(matchingAnswers.contains(word))
        lookupIcon
      }
    }
    .popover(isPresented: $showDefinition, arrowEdge: .trailing) {
      DefinitionsView(definitions: definitions)
    }
  }
}

#Preview {
  @Previewable @State var showPopover = false

  return Button("Show Popover") {
    showPopover = true
  }
  .popover(isPresented: $showPopover) {
    Text("Hello SwiftUI!")
      .padding()
  }
}
