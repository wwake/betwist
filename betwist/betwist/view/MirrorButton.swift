import SwiftUI

struct MirrorButton: View {
  var iconName: String
  var label: String
  var transformFn: (Location) -> (Int) -> Location

  @Binding var game: Game
  @Binding var angle: Angle

  var body: some View {
    Button {
      print(angle)
//      angle = Angle.zero
      var newAngle = angle + Angle(degrees: 180)
      if newAngle >= Angle(degrees: 360) {
        newAngle -= Angle(degrees: 360)
      }
      withAnimation {
        angle = newAngle
      } completion: {
        _ = transaction { _ in
  //        angle = Angle.zero
 //         game.transform(transformFn: transformFn)
        }
      }
    } label: {
      Image(systemName: iconName)
        .accessibilityLabel(Text(label))
    }.circled()
      .padding([.bottom], 6)
  }
}

#Preview {
  MirrorButton(
    iconName: "",
    label: "Mirror Horizontally",
    transformFn: { loc in { _ in loc } },
    game: .constant(Game(2, ["A", "D", "O", "N"])),
    angle: .constant(Angle.zero)
  )
}
