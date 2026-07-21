import SwiftUI

struct OnboardingView: View {
  @Environment(\.dismiss)
  var dismiss

  var body: some View {
    TabView {
      Image(.onboardTitle)
        .onboard()
        .accessibilityLabel("Betwist - Finding words with a twist. The letters are in a repeating grid")

      Image(.onboardFormWord)
        .onboard()
        .accessibilityLabel("Tap neighbors to build a word")

      Image(.onboardUndo)
        .onboard()
        .accessibilityLabel("Tap an earlier letter to undo")

      Image(.onboardScore)
        .onboard()
        .accessibilityLabel("Tap the last letter twice to score. You get credit for shorter words too!")

      Image(.onboardTwist)
        .onboard()
        .accessibilityLabel("Tap a twist button if you get stuck")

      Image(.onboardReveal)
        .onboard()
        .accessibilityLabel("'Reveal' shows words you and the system found")

      Image(.onboardDefinition)
        .onboard()
        .accessibilityLabel("Tap the magnifying glass to see a definition (if we have it)")
    }
    .indexViewStyle(.page(backgroundDisplayMode: .always))
    .tabViewStyle(.page)
    .overlay(
      Button("Close", systemImage: "xmark") { dismiss() }
        .labelStyle(.iconOnly)
        .offset(x: -15, y: 15)
        .foregroundStyle(.black),
      alignment: .topTrailing
    )
  }
}

extension Image {
  func onboard() -> some View {
    self
      .resizable()
      .aspectRatio(contentMode: .fit)
      .clipped()
      .padding()
  }
}

#Preview {
  OnboardingView()
}
