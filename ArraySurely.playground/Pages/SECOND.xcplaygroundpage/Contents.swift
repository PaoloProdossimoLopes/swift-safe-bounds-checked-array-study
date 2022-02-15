/**
 Safe array get, set, insert and delete.
 All action that would cause an error are ignored.
 */
extension Array {

    /**
     Removes element at index.
     Action that would cause an error are ignored.
     */
    mutating func remove(safeAt index: Index) {
        guard index >= 0 && index < count else {
            print("Index out of bounds while deleting item at index \(index) in \(self). This action is ignored.")
            return
        }

        remove(at: index)
    }

    /**
     Inserts element at index.
     Action that would cause an error are ignored.
     */
    mutating func insert(_ element: Element, safeAt index: Index) {
        guard index >= 0 && index <= count else {
            print("Index out of bounds while inserting item at index \(index) in \(self). This action is ignored")
            return
        }

        insert(element, at: index)
    }

    /**
     Safe get set subscript.
     Action that would cause an error are ignored.
     */
    subscript (safe index: Index) -> Element? {
        get {
            return indices.contains(index) ? self[index] : nil
        }
        set {
            remove(safeAt: index)

            if let element = newValue {
                insert(element, safeAt: index)
            }
        }
    }
}










import XCTest

class SafeArrayTest: XCTestCase {
    func testRemove_Successful() {
        var array = [1, 2, 3]

        array.remove(safeAt: 1)

        XCTAssert(array == [1, 3])
    }

    func testRemove_Failure() {
        var array = [1, 2, 3]

        array.remove(safeAt: 3)

        XCTAssert(array == [1, 2, 3])
    }

    func testInsert_Successful() {
        var array = [1, 2, 3]

        array.insert(4, safeAt: 1)

        XCTAssert(array == [1, 4, 2, 3])
    }

    func testInsert_Successful_AtEnd() {
        var array = [1, 2, 3]

        array.insert(4, safeAt: 3)

        XCTAssert(array == [1, 2, 3, 4])
    }

    func testInsert_Failure() {
        var array = [1, 2, 3]

        array.insert(4, safeAt: 5)

        XCTAssert(array == [1, 2, 3])
    }

    func testGet_Successful() {
        var array = [1, 2, 3]

        let element = array[safe: 1]

        XCTAssert(element == 2)
    }

    func testGet_Failure() {
        var array = [1, 2, 3]

        let element = array[safe: 4]

        XCTAssert(element == nil)
    }

    func testSet_Successful() {
        var array = [1, 2, 3]

        array[safe: 1] = 4

        XCTAssert(array == [1, 4, 3])
    }

    func testSet_Successful_AtEnd() {
        var array = [1, 2, 3]

        array[safe: 3] = 4

        XCTAssert(array == [1, 2, 3, 4])
    }

    func testSet_Failure() {
        var array = [1, 2, 3]

        array[safe: 4] = 4

        XCTAssert(array == [1, 2, 3])
    }
}
