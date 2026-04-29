import SwiftUI

struct MirrorButton: View {
  var iconName: String
  var label: String
  var transformFn: (Location) -> (Int) -> Location

  @Binding var game: Game

  var body: some View {
    Button {
      withAnimation {
        game.transform(transformFn: transformFn)
      } completion: {
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
    game: .constant(Game(2, ["A", "D", "O", "N"])))
}
