import Algorithms
import Foundation

enum Directions {
  case up, down, left, right
}

struct Grid {
  let size: Int
  let grid: [[String]]
  var corner: Location

  init(_ size: Int, _ source: any Sequence<String>) {
    self.size = size

    self.grid = Array(source).chunks(ofCount: size).map(Array.init)
    self.corner = Location(0, 0)
  }

  subscript(_ row: Int, _ column: Int) -> String {
    grid[row %% size][column %% size]
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

  mutating func twist(_ direction: Directions) {
    switch direction {
    case .left:
      corner = Location(corner.row, (corner.column + 1) %% size)

    case .right:
      corner = Location(corner.row, (corner.column - 1) %% size)

    case .up:
      corner = Location((corner.row + 1) %% size, corner.column)

    case .down:
      corner = Location((corner.row - 1) %% size, corner.column)
    }
  }

  var rowIndexes: [Int] {
    (0..<size).map { (corner.row + $0) %% size }
  }

  var columnIndexes: [Int] {
    (0..<size).map { (corner.column + $0) %% size }
  }
}
