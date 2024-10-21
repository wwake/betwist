import SwiftUI

struct GuessView: View {
  @Binding var game: Game
  var guessProgress: Double
  var height: Double

  var action: () -> Void

  var body: some View {
    HStack {
      Image("TheIcon")
        .resizable()
        .scaledToFit()
        .frame(width: 40, height: 40)
        .accessibilityLabel(Text("Betwist"))

      ZStack {
        Text(" ")
          .frame(width: 230, height: 40)
          .padding(4)
          .background(Color(white: 1.0))
          .border(.black, width: 2)

        Text(game.guess)
          .font(.largeTitle)
          .foregroundStyle(game.message.isEmpty ? Color.black : Color.red)
          .frame(minWidth: 230)
          .frame(height: 40)
          .padding(4)
          .background(Color(white: 1.0))
          .border(.black, width: 2)
          .accessibilityAddTraits(.isButton)
          .offset(x: 80 * guessProgress, y: guessProgress * height)
          .opacity(1 - 0.8 * guessProgress)
          .scaleEffect(1 - 0.1 * guessProgress)
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
          .background(.white)
          .tint(.accent)
          .clipShape(Circle())
      }
    }
    .zIndex(10)
  }
}
