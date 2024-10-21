import SwiftUI

struct ButtonCapsuleModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .bold()
      .padding(6)
      .foregroundStyle(.white)
      .background(.accent)
      .cornerRadius(10)
  }
}

extension Button {
  func capsuled() -> some View {
    self.modifier(ButtonCapsuleModifier())
  }
}
