@testable import betwist
import Testing

struct ATwister {
  @Test
  func maps_locations_when_unchanged() {
    let twister = Twister(2)
    #expect(twister[Location(0, 1)] == Location(0, 1))
  }

  @Test
  func maps_locations_when_twisted_once() {
    // AB     BD
    // CD  => AC

    var twister = Twister(2)
    twister.rotateLeft()
    #expect(twister[Location(0, 0)] == Location(0, 1))
    #expect(twister[Location(0, 1)] == Location(1, 1))
  }
}
