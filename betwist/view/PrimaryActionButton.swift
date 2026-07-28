import model
import SwiftUI

struct PrimaryActionButton: View {
  @Environment(Monetizer.self)
  var monetizer

  @Binding var game: Game

  @Binding var showAnswers: Bool

  @State var showBuySheet = false

  var body: some View {
    Group {
      Group {
        switch game.mode {
        case .play:
          Button("End Game...") {
            withAnimation {
              showAnswers = true
            }
            game.over()
          }
          .capsuled(.red)

        case .review:
          if monetizer.requiresPurchase {
            Button("More Games...") {
              showBuySheet = true
            }
            .capsuled(.red)
          } else {
            Button("New Game") {
              withAnimation {
                showAnswers = false
              }
              game = Game(
                game.size,
                GameGenerator(game.size).make(),
                game.vocabulary
              )
              game.start()
            }
            .capsuled()
          }

        @unknown default:
          fatalError("PrimaryActionButton - unexpected case \(game.mode)")
        }
      }
    }
    .sheet(isPresented: $showBuySheet) {
      BuyView()
    }
  }
}
