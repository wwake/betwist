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

struct ButtonCircleModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .padding(3)
      .font(.title)
      .background(.white)
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
