import SwiftUI

struct OnboardingView: View {
  @Environment(\.dismiss)
  var dismiss

  var images: [(ImageResource, String)]

  @State private var selection = 0

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
        ForEach(images.enumerated(), id: \.0) { n, imagePair in
          Image(imagePair.0)
            .onboard()
            .tag(n)
            .accessibilityLabel(imagePair.1)
        }

        VStack {
          Text("Have fun!")
            .font(.title2)
            .padding(.bottom, 16)

          Button("Play") { dismiss() }
            .capsuled()
        }
        .tag(images.count)
      }
      .indexViewStyle(.page(backgroundDisplayMode: .always))
      .tabViewStyle(.page)

      Button("Next", systemImage: "arrowtriangle.right.fill") {
        selection += 1
      }
      .labelStyle(.iconOnly)
      .font(.title)
      .disabled(selection == images.count)
      .foregroundStyle(selection == images.count ? .gray : .black)
    }
    .foregroundStyle(.black)
    .padding([.leading, .trailing], 12)
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
  OnboardingView(images: [(.onboardTitle, "acc")])
}
