import SwiftUI

struct AnswerDetailsView: View {
  @Environment(\.dismiss)
  var dismiss

  var answers: Answers
  var allAnswers: Set<String>
  @Binding var mode: GameMode
  
  fileprivate func wordsYouFound() -> some View {
    VStack {
      Text("You Found")
        .font(.title2)

      SortedAnswersView(answers: answers)
    }
  }

  fileprivate func wordsSystemFound() -> some View {
    VStack {
      Text("System Found")
        .font(.title2)

      if mode == .play {
        VStack {
          Button("Show Me!") {
            mode = .review
          }
          .capsuled()

          Text("(ends the game)")
            .font(.footnote)
        }
      }

      if mode == .review {
          Text(allAnswers.joined(separator: "\n"))
          //        List {
          //          ForEach(answers.wordSizes, id: \.self) { size in
          //            Section(header: Text("\(size) letters")) {
          //              ForEach(answers.words(ofSize: size)) { answer in
          //                Text(verbatim: answer.word)
          //                  .bold(answer.enteredByUser)
          //                  .foregroundStyle(answer.enteredByUser ? .black : .accent)
          //              }
          //            }
          //          }
          //        }
          //        .listStyle(.plain)
      }
      Spacer()
    }
  }

  var body: some View {
    VStack {
      HStack {
        wordsYouFound()
          .frame(maxWidth: .infinity)

        Divider()
          .frame(width: 2)

        wordsSystemFound()
          .frame(maxWidth: .infinity)
      }

      Button("Back") {
        dismiss()
      }
      .capsuled()
    }
    .padding()
  }
}
