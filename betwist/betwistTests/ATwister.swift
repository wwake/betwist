@testable import betwist
import Testing

struct ATwister {
  @Test
  func twist_left_knows_new_column_indexes() {
    var sut = Twister(4)
    sut.twist(.left)

    #expect(sut.rowIndexes == [0, 1, 2, 3])
    #expect(sut.columnIndexes == [1, 2, 3, 0])
  }

  @Test
  func twist_left_many_times_wraps() {
    var sut = Twister(4)
    sut.twist(.left)
    sut.twist(.left)
    sut.twist(.left)
    sut.twist(.left)

    #expect(sut.rowIndexes == [0, 1, 2, 3])
    #expect(sut.columnIndexes == [0, 1, 2, 3])
  }

  @Test
  func twist_right_knows_new_column_indexes() {
    var sut = Twister(4)
    sut.twist(.right)

    #expect(sut.rowIndexes == [0, 1, 2, 3])
    #expect(sut.columnIndexes == [3, 0, 1, 2])
  }

  @Test
  func twist_up_knows_new_row_indexes() {
    var sut = Twister(4)
    sut.twist(.up)

    #expect(sut.rowIndexes == [1, 2, 3, 0])
    #expect(sut.columnIndexes == [0, 1, 2, 3])
  }

  @Test
  func twist_down_knows_new_row_indexes() {
    var sut = Twister(4)
    sut.twist(.down)

    #expect(sut.rowIndexes == [3, 0, 1, 2])
    #expect(sut.columnIndexes == [0, 1, 2, 3])
  }
}
