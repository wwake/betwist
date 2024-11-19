@testable import betwist
import Testing

struct AGameMaker {
  @Test
  func returns_enough_letters() {
    #expect(GameMaker(3).make().count == 9)
    #expect(GameMaker(4).make().count == 16)
    #expect(GameMaker(5).make().count == 25)
  }

  @Test
  func returns_lots_of_e_compared_to_k() {
    let sample = GameMaker(15).make()

    let eCount = sample.filter { $0 == "E" }.count
    let kCount = sample.filter { $0 == "K" }.count

    #expect(eCount > kCount)
  }

  @Test
  func converts_q_to_qu() {
    let sample = GameMaker(1, ["QQQQQQ"]).make()
    #expect(sample.first! == "QU")
  }
}
