import SwiftUI

struct CapsuleModifier: ViewModifier {
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

struct CircleModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .bold()
      .padding(3)
      .font(.title)
      .background(.buttonForeground)
      .clipShape(Circle())
  }
}

extension View {
  func capsuled() -> some View {
    self.modifier(CapsuleModifier())
  }

  func circled() -> some View {
    self.modifier(CircleModifier())
  }
}
