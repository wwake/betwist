import SwiftUI

struct GuessView: View {
  @Binding var game: Game
  var offset: CGFloat

  var action: () -> Void
  
  var body: some View {
    HStack {
      Image("TheIcon")
        .resizable()
        .scaledToFit()
        .frame(maxWidth: 128, maxHeight: 128)
        .accessibilityLabel(Text("Betwist"))
      Text(game.guess)
        .font(.largeTitle)
        .foregroundStyle(game.message.isEmpty ? Color.black : Color.red)
        .frame(minWidth: 230)
        .frame(height: 40)
        .padding(4)
        .background(Color(white: 1.0, opacity: 0.85))
        .border(.black, width: 2)
        .accessibilityAddTraits(.isButton)
        .offset(y: offset)
        .onTapGesture {
          action()
        }
      Button {
        action()
      } label: {
        Image(systemName: "checkmark.circle.fill")
          .accessibilityLabel(Text("Enter"))
          .font(.largeTitle)
          .foregroundStyle(.green)
      }
    }
    .zIndex(1)
  }
}
