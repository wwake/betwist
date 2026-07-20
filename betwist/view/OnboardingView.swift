import SwiftUI

struct OnboardingView: View {
  var body: some View {
    TabView {
      Text("A")
        .padding()
        .background(.yellow)
        .frame(maxWidth: .infinity)
      Text("B")
        .backgroundStyle(.yellow)
      Text("C")
        .backgroundStyle(.yellow)
    }
    .backgroundStyle(.yellow)
    .indexViewStyle(.page(backgroundDisplayMode: .always))
    .tabViewStyle(.page)
  }
}

#Preview {
  OnboardingView()
}
