import SwiftUI

struct AnswerInProgressView: View {
  let boxWidth: CGFloat = 200

  @Binding var game: Game
  var progress: Double
  var height: Double

  var action: () -> Void

  var body: some View {
    HStack {
      ZStack {
        Text(" ")
          .frame(width: boxWidth, height: 40)
          .padding(4)
          .background(Color(white: 1.0))
          .border(.black, width: 2)

        Text(game.answer)
          .font(.largeTitle)
          .foregroundStyle(game.message.isEmpty ? Color.black : Color.red)
          .frame(minWidth: boxWidth)
          .frame(height: 40)
          .padding(4)
          .background(Color(white: 1.0))
          .border(.black, width: 2)
          .accessibilityAddTraits(.isButton)
          .offset(x: 80 * progress, y: progress * height)
          .opacity(1 - 0.8 * progress)
          .scaleEffect(1 - 0.1 * progress)
          .onTapGesture {
            action()
          }
      }

      Button {
        action()
      } label: {
        Image(systemName: "checkmark.circle.fill")
          .accessibilityLabel(Text("Enter"))
          .font(.largeTitle)
          .background(.buttonForeground)
          .tint(.accent)
          .clipShape(Circle())
      }
    }
    .zIndex(10)
  }
}
