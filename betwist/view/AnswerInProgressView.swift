import model
import SwiftUI

struct AnswerInProgressView: View {
  let boxWidth: CGFloat = 200

  var game: Game
  var progress: Double
  var height: Double

  var showOnboarding: () -> Void
  var acceptWord: () -> Void

  var body: some View {
    HStack {
      Button {
        showOnboarding()
      } label: {
        Image(systemName: "info.circle.fill")
          .accessibilityLabel(Text("Instructions"))
          .font(.largeTitle)
          .background(.buttonForeground)
          .tint(.accent)
          .clipShape(Circle())
      }

      Text(game.answer)
        .font(.largeTitle)
        .foregroundStyle(game.guessStatus == .ok ? Color.black : Color.red)
        .frame(maxWidth: 400, minHeight: 40)
        .padding([.leading, .trailing], 8)
        .padding([.bottom], 4)
        .background { Color(white: 1.0) }
        .border(.black, width: 2)
        .offset(x: 80 * progress, y: progress * height)
        .opacity(1 - 0.8 * progress)
        .scaleEffect(1 - 0.1 * progress)
        .accessibilityAddTraits(.isButton)
        .onTapGesture {
          acceptWord()
        }

      Button {
        acceptWord()
      } label: {
        Image(systemName: "checkmark.circle.fill")
          .accessibilityLabel(Text("Enter"))
          .font(.largeTitle)
          .background(.buttonForeground)
          .tint(.accent)
          .clipShape(Circle())
      }
    }
    .padding([.leading, .trailing], 8)
    .padding(.bottom, 8)
  }
}
