@testable import betwist
import Testing

struct AGameMaker {
  @Test
  func returns_enough_letters() {
    let sut = GameMaker(3)
    #expect(sut.prefix(9).count { _ in true } == 9)
  }

  @Test
  func stops_after_N_squared_letters() {
    let sut = GameMaker(3)
    #expect(sut.prefix(10).count { _ in true } == 9)
  }

  @Test
  func returns_lots_of_e_compared_to_k() {
    let sut = GameMaker(10)

    let sample = sut.prefix(100)
    let eCount = sample.filter { $0 == "E" }.count
    let kCount = sample.filter { $0 == "K" }.count

    #expect(eCount > 2 * kCount)
  }
}
