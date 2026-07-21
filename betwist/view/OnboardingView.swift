import SwiftUI

struct OnboardingView: View {
  @Environment(\.dismiss)
  var dismiss

  var body: some View {
    TabView {
      Text("A")
        .padding()
        .background(.yellow)
        .frame(maxWidth: .infinity)
      Text("B")
        .backgroundStyle(.yellow)
      Color(.green)
    }
    .backgroundStyle(.yellow)
    .indexViewStyle(.page(backgroundDisplayMode: .always))
    .tabViewStyle(.page)
    .overlay(
      Button("Close", systemImage: "xmark") { dismiss() }
        .labelStyle(.iconOnly)
        .offset(x: -50, y: 50),
      alignment: .topTrailing
    )
  }
}

#Preview {
  OnboardingView()
}
