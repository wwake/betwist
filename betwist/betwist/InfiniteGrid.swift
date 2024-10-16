import SwiftUI

struct InfiniteGrid: View {
  @Binding var game: Game
  var collectWord: () -> Void

  @State private var offset = CGSize.zero
  @State private var priorOffset = CGSize.zero

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
          offset.width = priorOffset.width + dragInfo.translation.width
          offset.height = priorOffset.height + dragInfo.translation.height

          offset = offset.wrap(250)
        }
        .onEnded { _ in
          priorOffset = offset
        }
    )
  }
}
