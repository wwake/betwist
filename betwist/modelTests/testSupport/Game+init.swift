@testable import model

extension Game {
  public init(_ size: Int, _ source: any Sequence<String>) {
    self.init(size, source, NullVocabulary())
  }
}
