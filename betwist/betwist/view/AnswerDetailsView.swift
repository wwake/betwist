import SwiftUI

struct AnswerDetailsView: View {
  @Environment(\.dismiss)
  var dismiss

  var answers: Answers

  var body: some View {
    VStack {
      Text("Words You Found")
        .font(.title)

//      List {
//        ForEach(answers.wordSizes) { size in
//          Section(header: Text("\(size) letters")) {
//            ForEach(answers.words(ofSize: size)) { answer in
//              Text(verbatim: answer.word)
//                .bold(answer.enteredByUser)
//                .foregroundStyle(answer.enteredByUser ? .black : .accent)
//            }
//          }
//        }
//      }

      Button("Back") {
        dismiss()
      }
      .capsuled()
    }
    .padding()
  }
}
