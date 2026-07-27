import SwiftUI

struct BuyView: View {
  @Environment(\.dismiss)
  private var dismiss

  var body: some View {
    Text("Get More Games")
      .font(.title)

    Text("You've played 20 free games - with no ads!")
    Text("You can purchase this game with a one-time payment: $4.99.")
    Text("You won't have ads then either.")

    Spacer()

    Button("Done") {
      dismiss()
    }
    .capsuled()
  }
}

#Preview {
  BuyView()
}
