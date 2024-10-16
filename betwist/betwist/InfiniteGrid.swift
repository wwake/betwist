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
      DragGesture(minimumDistance: 2)
        .onChanged { dragInfo in
          offset = dragInfo.translation
          let previousOffset = offset
          offset = offset.wrap(250)

          print("offset=\(offset) \(previousOffset)")
        }
        .onEnded { _ in
//          withAnimation {
//            if abs(offset.width) > 25 || abs(offset.height) > 25 {
//                // move the grid
//
//              print("final offset = \(offset)")
//            } else {
//                offset = .zero
//            }
//          }
        }
    )
  }
}
