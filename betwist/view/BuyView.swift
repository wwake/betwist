import model
import StoreKit
import SwiftUI

struct BuyView: View {
  @Environment(\.dismiss)
  private var dismiss

  @Environment(Monetizer.self)
  var monetizer

  var body: some View {
    VStack {
      Text("Betwist - More Games")
        .font(.title)
        .padding(.bottom, 24)

      VStack(alignment: .leading) {
        Text(
"""
You may play 20 free games.

After that, you can purchase this game with a one-time payment, for about the price of a cup of coffee.")

Whether or not you buy, we won't show ads.
"""
        )
      }
      .padding(.bottom, 24)

      if monetizer.allowsPurchase {
        ProductView(id: "com.xp123.betwist_test123", prefersPromotionalIcon: true)
          .productViewStyle(.large)
          .onInAppPurchaseCompletion { _, _ in
            dismiss()
          }
      }

      Spacer()

      Button("Done") {
        dismiss()
      }
      .capsuled()
      .frame(width: 150)
    }
    .padding(24)
  }
}

#Preview {
  BuyView()
}
