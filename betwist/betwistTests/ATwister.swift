@testable import betwist
import Testing

struct ATwister {
  @Test
  func maps_locations_when_unchanged() {
    let twister = Twister(2)
    #expect(twister[Location(0, 1)] == Location(0, 1))
  }

  @Test
  func maps_locations_when_twisted_left() {
    // AB     BD
    // CD  => AC

    var twister = Twister(2)
    twister.rotateLeft()
    #expect(twister[Location(0, 0)] == Location(0, 1))
    #expect(twister[Location(0, 1)] == Location(1, 1))
  }

  @Test
  func maps_locations_when_twisted_right() {
    // AB     CA
    // CD  => DB

    var twister = Twister(2)
    twister.rotateRight()
    #expect(twister[Location(0, 0)] == Location(1, 0))
    #expect(twister[Location(0, 1)] == Location(0, 0))
  }
}
