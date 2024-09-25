import Algorithms
import Foundation

struct Board {
  let size: Int
  let board: [[String]]

  init(_ size: Int, _ source: any Sequence<String>) {
    self.size = size

    self.board = Array(source).chunks(ofCount: size).map(Array.init)
  }

  subscript(_ row: Int, _ column: Int) -> String {
    board[row %% size][column %% size]
  }

  func isClose(_ index1: Int, _ index2: Int, wrap: Int) -> Bool {
    let distance = abs(index1 - index2)
    return distance <= 1 || distance == wrap - 1
  }

  fileprivate func isClose(_ location1: Location, _ location2: Location, wrap: Int) -> Bool {
    isClose(location1.row, location2.row, wrap: wrap) && isClose(location1.column, location2.column, wrap: wrap)
  }

  func hasNeighbors(_ location1: Location, _ location2: Location) -> Bool {
    if location1 == location2 {
      return false
    }

    return location1.isClose(location2, wrap: size)
  }
}
