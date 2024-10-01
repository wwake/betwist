import SwiftUI

struct MotionControls: View {
  @Binding var game: Game

  func button(_ direction: Directions, _ imageName: String) -> some View {
    Button {
      withAnimation {
        game.twist(direction)
      }
    } label: {
      Image(systemName: imageName)
        .imageScale(.large)
    }
    .tint(.white)
    .buttonStyle(.bordered)
  }

  var body: some View {
    VStack {
      button(.up, "arrow.up.circle")

      HStack {
        button(.left, "arrow.left.circle")
        button(.right, "arrow.right.circle")
      }

      button(.down, "arrow.down.circle")
    }
  }
}
