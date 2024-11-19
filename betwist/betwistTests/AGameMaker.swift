@testable import betwist
import Testing

struct AGameMaker {
  @Test
  func returns_enough_letters() {
    #expect(GameMaker(3).make().count == 9)
  }

  @Test
  func returns_lots_of_e_compared_to_k() {
    let sample = GameMaker(15).make()

    let eCount = sample.filter { $0 == "E" }.count
    let kCount = sample.filter { $0 == "K" }.count

    #expect(eCount > kCount)
  }
}
