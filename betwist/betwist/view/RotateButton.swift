import SwiftUI

struct Twist {
  static let quarterTurn = .pi / 2.0

  let label: Label<Text, Image>
  let rotationRadians: Double
  let rotationAxis: Axis
  let twist: CGAffineTransform
  let untwist: CGAffineTransform

  static let rotateLeft = Twist(
    label: Label("Rotate Left", systemImage: "arrow.counterclockwise"),
    rotationRadians: -Self.quarterTurn,
    rotationAxis: Axis(x: 0, y: 0, z: 1),

    twist:
      CGAffineTransformMakeRotation(-Self.quarterTurn)
      .concatenating(
        CGAffineTransformMakeTranslation(0, Double(Game.defaultSize) * RotatingGridView.cellSize)
      ),

    untwist:
      CGAffineTransformMakeRotation(Self.quarterTurn)
      .concatenating(
        CGAffineTransformMakeTranslation(RotatingGridView.cellSize, 0)
      )
  )

  static let rotateRight = Twist(
    label: Label("Rotate Right", systemImage: "arrow.clockwise" ),
    rotationRadians: Self.quarterTurn,
    rotationAxis: Axis(x: 0, y: 0, z: 1),

    twist: CGAffineTransformMakeRotation(Self.quarterTurn)
      .concatenating(
        CGAffineTransformMakeTranslation(
          Double(Game.defaultSize) * RotatingGridView.cellSize,
          0
        )
      ),

    untwist: CGAffineTransformMakeRotation(-Self.quarterTurn)
      .concatenating(CGAffineTransformMakeTranslation(0, RotatingGridView.cellSize))
  )

  static let mirrorHorizontally = Twist(
    label: Label("Mirror Horizontally", systemImage: "arrow.left.arrow.right"),
    rotationRadians: 2.0 * Self.quarterTurn,
    rotationAxis: Axis(x: 0, y: -1, z: 0),

    twist: CGAffineTransformMakeScale(-1, 1)
      .concatenating(
        CGAffineTransformMakeTranslation(Double(Game.defaultSize) * RotatingGridView.cellSize, 0)
      ),

    untwist: CGAffineTransformMakeTranslation(-RotatingGridView.cellSize, 0)
      .concatenating(CGAffineTransformMakeScale(-1, 1))
  )
}

struct RotateButton: View {
  @Binding var game: Game

  @Binding var animationAngle: Angle
  @Binding var axis: Axis

  @Binding var twistBoard: CGAffineTransform
  @Binding var untwistLetter: CGAffineTransform

  var twist: Twist

  var cellSize: CGFloat

  var body: some View {
    Button {
      axis = twist.rotationAxis
      withAnimation(.easeInOut(duration: 1.5)) {
        animationAngle = .radians(twist.rotationRadians)
      } completion: {
        animationAngle = Angle.zero
        twistBoard = twistBoard.concatenating(twist.twist)
        untwistLetter = twist.untwist.concatenating(untwistLetter)
      }
    } label: {
      twist.label
        .labelStyle(.iconOnly)
    }.circled()
      .padding([.bottom], 6)
  }
}
