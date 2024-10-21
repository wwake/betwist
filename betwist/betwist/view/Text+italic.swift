import SwiftUI

extension Text {
  func italic(enabled: Bool) -> Text {
    if enabled {
      return self.italic()
    }
    return self
  }
}
