import SwiftUI

struct ButtonCapsuleModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .bold()
      .padding([.top, .bottom], 6)
      .padding([.leading, .trailing], 16)
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
