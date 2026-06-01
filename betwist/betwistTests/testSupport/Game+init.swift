@testable import betwist

extension Game {
  init(_ size: Int, _ source: any Sequence<String>) {
    self.init(size, source, NullVocabulary())
  }
}
