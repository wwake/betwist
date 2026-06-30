import SwiftUI

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
