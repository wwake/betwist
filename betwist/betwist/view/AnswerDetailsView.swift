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

  fileprivate func wordsSystemFound() -> some View {
    VStack {
      Text("System Found")
        .font(.title2)

      if mode == .play {
        Button("Show Me!") {
          mode = .review
        }
        .capsuled()
      }

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
        .opacity(mode == .review ? 1 : 0)
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
