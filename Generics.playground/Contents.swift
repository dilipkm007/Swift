import UIKit

func sortArray<T: Comparable>(_ array: [T]) -> [T] {
    return array.sorted()
}

struct Pair<T: Equatable, U: Equatable> {
    let first: T
    let second: U
    
    func isEqualTo(other: Pair<T,U>) -> Bool {
        return self.first == other.first && self.second == other.second
    }
}
