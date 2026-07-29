import model
import StoreKit
import SwiftUI

private func getVersion() -> String {
  guard let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else {
    return "no version info"
  }
  return version
}

struct OnboardingView: View {
  @Environment(\.dismiss)
  var dismiss

  @Environment(Monetizer.self)
  var monetizer

  var images: [(ImageResource, String)]

  @State private var selection = 0

  @State private var showBuyPage = false

  fileprivate func lastOnboardPage() -> some View {
    VStack {
      Text("Have fun!")
        .font(.title2)
        .padding(.bottom, 16)

      if monetizer.allowsPurchase {
        Button("Buy Now") {
          showBuyPage = true
        }
        .capsuled()
        .frame(width: 150)
        .padding(.bottom, 24)
      }

      Button("Play Now") { dismiss() }
        .capsuled()
        .frame(width: 150)

      Text("Version: \(getVersion())")
        .font(.footnote)
        .padding(.top, 48)
    }
    .tag(images.count)
  }

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

        lastOnboardPage()
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
    .sheet(isPresented: $showBuyPage) {
      BuyView()
    }
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
