import StoreKit
import SwiftUI

struct BuyView: View {
  @Environment(\.dismiss)
  private var dismiss

  //  @Environment(Store.self) private var store: Store

  var body: some View {
  //  @Bindable var store = store

    Text("Get More Games")
      .font(.title)

    Text("You've played 20 free games - with no ads!")
    Text("You can purchase this game with a one-time payment: $4.99.")
    Text("You won't have ads then either.")

    Spacer()

//    VStack {
//      // ProductID.all is an array of your product ID strings.
//      StoreView(ids: ProductID.all)
//        .storeButton(.hidden, for: .cancellation)
//        .storeButton(.visible, for: .restorePurchases)
//    }
//    .padding()

    Spacer()

    Button("Done") {
      dismiss()
    }
    .capsuled()
    .frame(width: 150)
  }
}

#Preview {
  BuyView()
}
