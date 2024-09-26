import SwiftUI

@main
struct betwistApp: App {
  @State private var selection = Selection(
    Board(4, "ABCDEFGHIJKLMNOP".map { String($0) })
  )

  var body: some Scene {
    WindowGroup {
      ContentView(selection: $selection)
    }
  }
}
