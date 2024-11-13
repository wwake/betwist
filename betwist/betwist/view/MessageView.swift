import SwiftUI

struct MessageView: View {
  var message: String

  var body: some View {
    Text(message)
      .bold()
      .foregroundStyle(.red)
      .opacity(message.isEmpty ? 0.0 : 1.0)
  }
}
