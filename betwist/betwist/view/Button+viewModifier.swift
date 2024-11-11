import SwiftUI

struct ButtonCapsuleModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .bold()
      .padding([.top, .bottom], 6)
      .padding([.leading, .trailing], 16)
      .foregroundStyle(.buttonForeground)
      .background(.accent)
      .cornerRadius(10)
  }
}

struct ButtonCircleModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .bold()
      .padding(3)
      .font(.title)
      .background(.buttonForeground)
      .clipShape(Circle())
  }
}

extension Button {
  func capsuled() -> some View {
    self.modifier(ButtonCapsuleModifier())
  }

  func circled() -> some View {
    self.modifier(ButtonCircleModifier())
  }
}
