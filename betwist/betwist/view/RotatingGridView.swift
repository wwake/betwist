import SwiftUI

struct RotatingGridView: View {
  static var cellSize = 50.0

  @State private var angle = Angle.zero

  @Binding var game: Game
  var handleSelection: (Location) -> Void
  var width: CGFloat

  var body: some View {
    VStack {
      HStack {
        RotateButton(clockwise: false, angle: $angle, game: $game)
          .padding([.leading], 20)

        Spacer()
        Image("TheIcon")
          .resizable()
          .scaledToFit()
          .frame(width: 40, height: 40)
          .accessibilityLabel(Text("Betwist"))

        Text("Betwist")
          .bold()
          .font(.title)
          .padding([.leading], 8)

        Spacer()

        RotateButton(clockwise: true, angle: $angle, game: $game)
          .padding([.trailing], 20)
      }

      InfiniteGrid(
        game: $game,
        handleSelection: handleSelection,
        cellSize: Self.cellSize,
        boardSize: width
      )
      .rotationEffect(angle)
    }
    .frame(width: width)
    .zIndex(1)
  }
}
