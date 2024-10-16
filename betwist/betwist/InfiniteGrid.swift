import SwiftUI

struct InfiniteGrid: View {
  @Binding var game: Game
  var collectWord: () -> Void

  @State private var offset = CGSize.zero
  @State private var previousTranslation = CGSize.zero

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
          offset.width += dragInfo.translation.width - previousTranslation.width
          offset.height += dragInfo.translation.height - previousTranslation.height
          previousTranslation = dragInfo.translation

          offset = offset.wrap(250)

          print("offset=\(offset) translation=\(dragInfo.translation)")
        }
        .onEnded { _ in
          previousTranslation = CGSize.zero
        }
    )
  }
}
