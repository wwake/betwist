import SwiftUI

struct GridView: View {
  var cellSize: Double
  @Binding var game: Game
  var handleSelection: (Location) -> Void

  var yAnimationAngle: Angle
  var zAnimationAngle: Angle
  var twistBoard: CGAffineTransform
  var twistLetter: CGAffineTransform

  var body: some View {
    VStack(spacing: 0) {
      ForEach(0..<game.size, id: \.self) { row in
        HStack(spacing: 0) {
          ForEach(0..<game.size, id: \.self) { column in
            LetterView(
              shape: Rectangle(),
              size: cellSize,
              game: $game,
              location: Location(row, column),
              handleSelection: handleSelection,
              yAnimationAngle: yAnimationAngle,
              zAnimationAngle: zAnimationAngle,
              twistLetter: twistLetter
            )
          }
        }
      }
    }
    .transformEffect(twistBoard)
    .border(.accent, width: 2)
  }
}
