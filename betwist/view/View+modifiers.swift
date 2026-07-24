import SwiftUI

struct CapsuleModifier: ViewModifier {
  var backgroundColor: Color

  func body(content: Content) -> some View {
    content
      .bold()
      .frame(minWidth: 0, maxWidth: .infinity)
      .padding([.top, .bottom], 6)
      .padding([.leading, .trailing], 16)
      .foregroundStyle(.buttonForeground)
      .background(backgroundColor)
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
  func capsuled(_ background: Color = .accent) -> some View {
    self.modifier(CapsuleModifier(backgroundColor: background))
  }

  func circled() -> some View {
    self.modifier(CircleModifier())
  }
}
