@testable import betwist
import Testing

struct ALocation {
  @Test
  func isClose_in_same_column() {
    #expect(Location(0, 0).isClose(Location(0, 1), wrap: 4))
  }

  @Test
  func isClose_in_same_row() {
    #expect(Location(1, 0).isClose(Location(0, 0), wrap: 4))
  }

  @Test
  func isClose_touching_diagonally() {
    #expect(Location(1, 1).isClose(Location(0, 0), wrap: 4))
  }

  @Test
  func not_isClose_when_too_far_away() {
    #expect(!Location(0, 0).isClose(Location(2, 0), wrap: 4 ))
  }

  @Test
  func isClose_is_symmetric() {
    #expect(Location(0, 0).isClose(Location(0, 1), wrap: 4))
    #expect(Location(0, 1).isClose(Location(0, 0), wrap: 4))

    #expect(!Location(0, 0).isClose(Location(0, 2), wrap: 4))
    #expect(!Location(0, 2).isClose(Location(0, 0), wrap: 4))
  }

  @Test
  func isClose_in_wrapped_row() {
    #expect(Location(0, 1).isClose(Location(3, 1), wrap: 4))
  }

  @Test
  func isClose_in_wrapped_column() {
    #expect(Location(2, 0).isClose(Location(2, 3), wrap: 4))
  }

  @Test
  func isClose_touching_diagonally_when_wrapped() {
    #expect(Location(0, 0).isClose(Location(3, 3), wrap: 4))
  }

  @Test
  func moves_by_a_delta() {
    #expect(Location(3, 5).movedBy(DeltaLocation(1, -3), size: 6) == Location(4, 2))
    #expect(Location(1, 2).movedBy(DeltaLocation(5, -3), size: 4) == Location(2, 3))
  }
}
