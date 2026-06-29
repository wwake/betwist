import SwiftUI

struct AnswerInProgressView: View {
  let boxWidth: CGFloat = 200

  var game: Game
  var progress: Double
  var height: Double

  var action: () -> Void

  var body: some View {
    HStack {
      Text("   ")
        .accessibilityHidden(true)

      Text(game.answer)
        .font(.largeTitle)
        .foregroundStyle(game.message.isEmpty ? Color.black : Color.red)
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
          action()
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
    .padding(.trailing, 2)
    .padding(.bottom, 8)
  }
}
