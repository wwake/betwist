import SwiftUI

struct NewGameButton: View {
  @Binding var game: Game

  var body: some View {
    Button("New Game") {
      game = Game(game.size, GameMaker(game.size), game.vocabulary)
    }
    .capsuled()
  }
}
