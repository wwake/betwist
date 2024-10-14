import SwiftUI

struct GridView: View {
  @Binding var game: Game
  var collectWord: () -> ()

  var body: some View {
    VStack(spacing: 0) {
      ForEach(game.rowIndexes, id: \.self) { row in
        HStack(spacing: 0) {
          ForEach(game.columnIndexes, id: \.self) { column in
            Button {
              let location = Location(row, column)
              if game.lastLocationSelected(was: location) {
                collectWord()
              } else {
                game.select(location)
              }
            } label: {
              Text("\(game[row, column])")
            }
            .modifier(GridButtonStyle(game, Location(row, column)))
          }
        }
      }.gesture(
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
}
