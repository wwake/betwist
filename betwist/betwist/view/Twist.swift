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
