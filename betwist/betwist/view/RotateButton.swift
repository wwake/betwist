import SwiftUI

struct Twist {
  static let quarterTurn = .pi / 2.0

  let label: Label<Text, Image>
  let zRadians: Double
  let twist: CGAffineTransform
  let untwist: CGAffineTransform

  static let rotateLeft = Twist(
    label: Label("Rotate Left", systemImage: "arrow.counterclockwise"),
    zRadians: -Self.quarterTurn,

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
    zRadians: Self.quarterTurn,

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
}

struct RotateButton: View {
  @Binding var game: Game

  @Binding var zAnimationAngle: Angle
  @Binding var twistBoard: CGAffineTransform
  @Binding var untwistLetter: CGAffineTransform

  var twist: Twist

  var cellSize: CGFloat

  var body: some View {
    Button {
      withAnimation(.easeInOut(duration: 1.5)) {
        zAnimationAngle = .radians(twist.zRadians)
      } completion: {
        zAnimationAngle = Angle.zero
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
