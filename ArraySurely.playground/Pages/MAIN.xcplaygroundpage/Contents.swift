import UIKit
import XCTest

//MARK: - NEDED THIS EXTENSIONS
extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension MutableCollection {
    subscript(safe index: Index) -> Element? {
        get { return indices.contains(index) ? self[index] : nil }
        
        set(newValue) {
            if let newValue = newValue, indices.contains(index) {
                self[index] = newValue
            }
        }
    }
}



//MARK: - EXMAPLE:

struct Product {
    let nome: String
}

var model: [Product] = [
    .init(nome: "PRODUTO 1"),
    .init(nome: "PRODUTO 2"),
    .init(nome: "PRODUTO 3"),
]

print("TEST 1:", model[safe: 0]?.nome == "PRODUTO 1")
print("TEST 2:", model[safe: 1]?.nome == "PRODUTO 2")
print("TEST 3:", model[safe: 2]?.nome == "PRODUTO 3")
print("TEST 4:", model[safe: 3]?.nome == nil)

/*RESULTS:
 * TEST 1: true
 * TEST 2: true
 * TEST 3: true
 * TEST 4: true
*/
