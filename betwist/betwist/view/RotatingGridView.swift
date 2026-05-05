import SwiftUI

struct RotatingGridView: View {
  static var cellSize = 51.0

  @State private var twistBoard: CGAffineTransform = CGAffineTransformIdentity
  @State private var twistLetter: CGAffineTransform = CGAffineTransformIdentity

  @State private var yAnimationAngle = Angle.zero
  @State private var zAnimationAngle = Angle.zero

  @Binding var game: Game
  var handleSelection: (Location) -> Void
  var width: CGFloat

  var body: some View {
    VStack {
      HStack {
        RotateButton(
          clockwise: false,
          game: $game,
          zAnimationAngle: $zAnimationAngle,
          twistBoard: $twistBoard,
          untwistLetter: $twistLetter,
          cellWidth: Self.cellSize,
        )

        MirrorButton(
          iconName: "arrow.left.arrow.right",
          label: "Mirror Horizontally",
          game: $game,
          yAnimationAngle: $yAnimationAngle,
          twistBoard: $twistBoard,
          untwistLetter: $twistLetter,
          width: width,
          cellSize: Self.cellSize
        )

        RotateButton(
          clockwise: true,
          game: $game,
          zAnimationAngle: $zAnimationAngle,
          twistBoard: $twistBoard,
          untwistLetter: $twistLetter,
          cellWidth: Self.cellSize,
        )
      }
      .padding(.top, 5)
      .padding([.leading, .trailing], 8)
      .background(Capsule().fill(.thinMaterial))

      InfiniteGrid(
        game: $game,
        handleSelection: handleSelection,
        cellSize: Self.cellSize,
        boardSize: width,
        yAnimationAngle: yAnimationAngle,
        zAnimationAngle: zAnimationAngle,
        twistBoard: twistBoard,
        twistLetter: twistLetter
      )
      .rotation3DEffect(yAnimationAngle, axis: (x: 0, y: -1, z: 0))
      .rotation3DEffect(zAnimationAngle, axis: (x: 0, y: 0, z: 1))
    }
    .frame(width: width)
    .zIndex(1)
  }
}
