@testable import betwist
import Testing

struct GameMaker: Sequence, IteratorProtocol {
  let size: Int
  let candidates = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

  init(_ size: Int) {
    self.size = size
  }

  mutating func next() -> String? {
    String(candidates.randomElement()!)
  }
}

struct AGameMaker {
  @Test
  func returns_enough_letters() {
    var sut = GameMaker(3)
    #expect(sut.prefix(9).count { _ in true } == 9)
  }
}
