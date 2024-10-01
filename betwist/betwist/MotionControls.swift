import SwiftUI

struct MotionControls: View {
  @Binding var game: Game

  var body: some View {
    VStack {
      Button {
        withAnimation {
          game.twist(.up)
        }
      } label: {
        Image(systemName: "arrow.up.circle")
          .imageScale(.large)
      }
      .buttonStyle(.bordered)
      .tint(.mint)

      HStack {
        Button {
          withAnimation {
            game.twist(.left)
          }
        } label: {
          Image(systemName: "arrow.left.circle")
            .imageScale(.large)
        }
        .buttonStyle(.bordered)
        .tint(.mint)

        Button {
          withAnimation {
            game.twist(.right)
          }
        } label: {
          Image(systemName: "arrow.right.circle")
            .imageScale(.large)
        }
      }
      .buttonStyle(.bordered)
      .tint(.mint)

      Button {
        withAnimation {
          game.twist(.down)
        }
      } label: {
        Image(systemName: "arrow.down.circle")
          .imageScale(.large)
      }
      .buttonStyle(.bordered)
      .tint(.mint)

    }
  }
}
