import SwiftUI

struct InfiniteGrid: View {
  @Binding var game: Game
  var collectWord: () -> ()

  @State private var offset = CGSize.zero

  var body: some View {
    VStack(spacing: 0) {
      ForEach(1...3, id: \.self) { _ in
        HStack(spacing: 0) {
          ForEach(1...3, id: \.self) { _ in
            GridView(game: $game, collectWord: collectWord)
          }
        }
      }
    }
    .frame(width: 6 * 50, height: 6 * 50)
    .offset(offset)
    .clipShape(Rectangle())
    .gesture(
      DragGesture(minimumDistance: 4)
        .onChanged { dragInfo in
          print("translation \(dragInfo.translation)")
          offset = dragInfo.translation

          offset = offset.translateWrapped(dragInfo.translation, 500)

          print("offset=\(offset)")
        }
        .onEnded { dragInfo in
          withAnimation {
            if abs(offset.width) > 25 || abs(offset.height) > 25 {
                // move the grid

              print("final offset = \(offset)")
            } else {
                offset = .zero
            }
          }
        }
    )
  }
}
