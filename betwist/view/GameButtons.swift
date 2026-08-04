import model
import SwiftUI

public struct GameButtons: View {
  @Binding var game: Game
  @Binding var showAnswers: Bool

  public var body: some View {
    HStack {
      Spacer()

      PrimaryActionButton(game: $game)
        .frame(maxWidth: 150)

      Spacer()

      Button("Show Words...") {
        showAnswers = true
      }
      .capsuled()
      .frame(maxWidth: 150)

      Spacer()
    }
  }
}
