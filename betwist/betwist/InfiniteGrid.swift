import SwiftUI

struct InfiniteGrid: View {
  @Binding var game: Game
  var collectWord: () -> ()

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
    .clipShape(Rectangle())
    .gesture(
      DragGesture(minimumDistance: 25)
// Spike live scrolling
//              .onChanged { dragInfo in
//                print("Start: \(dragInfo.startLocation.x) \(dragInfo.startLocation.y)")
//                print("Move horizontally \(Int(dragInfo.location.x - dragInfo.startLocation.x) / 50)")
//                print("Move vertically \(Int(dragInfo.location.y - dragInfo.startLocation.y)/50)")
//              }
        .onEnded { dragInfo in
          withAnimation {
            game.twist(dragInfo.startLocation.direction(to: dragInfo.location))
          }
        }
    )
  }
}
