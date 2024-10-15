import SwiftUI

struct InfiniteGrid: View {
  @Binding var game: Game
  var collectWord: () -> ()

  @State private var offset = CGSize.zero

  fileprivate func adjustOffset(_ initialOffset: CGSize, _ translation: CGSize) -> CGSize {

    var offset = initialOffset

    let visibleSize: CGFloat = 250
    while (offset.width < -25) {
      offset.width += visibleSize
    }
    while (offset.width >= 25) {
      offset.width -= visibleSize
    }
    
    while (offset.height < 0) {
      offset.height += visibleSize - 25
    }
    while (offset.height >= visibleSize) {
      offset.height -= visibleSize
    }

    return offset
  }
  
  var body: some View {
    VStack(spacing: 0) {
      ForEach(1...3, id: \.self) { row in
        HStack(spacing: 0) {
          ForEach(1...3, id: \.self) { column in
            GridView(game: $game, collectWord: collectWord)
          }
        }
      }
    }
    .frame(width: 6*50, height: 6*50)
    .offset(offset)
    .clipShape(Rectangle())
    .gesture(
      DragGesture(minimumDistance: 4)
        .onChanged { dragInfo in
          print("translation \(dragInfo.translation)")
          offset = dragInfo.translation

          offset = adjustOffset(offset, dragInfo.translation)

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
