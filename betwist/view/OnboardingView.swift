import SwiftUI

struct OnboardingView: View {
  @Environment(\.dismiss)
  var dismiss

  @State private var selection = 0
  private static let lastPage = 7

  var body: some View {
    HStack {
      Button("Previous", systemImage: "arrowtriangle.left.fill") {
        selection -= 1
      }
      .labelStyle(.iconOnly)
      .font(.title)
      .disabled(selection == 0)
      .foregroundStyle(selection == 0 ? .gray : .black)

      TabView(selection: $selection) {
        Image(.onboardTitle)
          .onboard()
          .tag(0)
          .accessibilityLabel("Betwist - Finding words with a twist. The letters are in a repeating grid")

        Image(.onboardFormWord)
          .onboard()
          .tag(1)
          .accessibilityLabel("Tap neighbors to build a word")

        Image(.onboardUndo)
          .onboard()
          .tag(2)
          .accessibilityLabel("Tap an earlier letter to undo")

        Image(.onboardScore)
          .onboard()
          .tag(3)
          .accessibilityLabel("Tap the last letter twice to score. You get credit for shorter words too!")

        Image(.onboardTwist)
          .onboard()
          .tag(4)
          .accessibilityLabel("Tap a twist button if you get stuck")

        Image(.onboardReveal)
          .onboard()
          .tag(5)
          .accessibilityLabel("'Reveal' shows words you and the system found")

        Image(.onboardDefinition)
          .onboard()
          .tag(6)
          .accessibilityLabel("Tap the magnifying glass to see a definition (if we have it)")

        VStack {
          Text("Have fun!")
            .font(.title2)
            .padding(.bottom, 16)

          Button("Play") { dismiss() }
            .capsuled()
        }
        .tag(7)
      }
      .indexViewStyle(.page(backgroundDisplayMode: .always))
      .tabViewStyle(.page)

      Button("Next", systemImage: "arrowtriangle.right.fill") {
        selection += 1
      }
      .labelStyle(.iconOnly)
      .font(.title)
      .disabled(selection == Self.lastPage)
      .foregroundStyle(selection == Self.lastPage ? .gray : .black)
    }
    .foregroundStyle(.black)
    .padding([.leading, .trailing], 8)
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
