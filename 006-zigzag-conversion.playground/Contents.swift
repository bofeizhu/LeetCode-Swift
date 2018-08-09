/// 6. ZigZag Conversion
/// The string "PAYPALISHIRING" is written in a zigzag pattern on a given number of rows like this:
/// (you may want to display this pattern in a fixed font for better legibility)
///
/// P   A   H   N
/// A P L S I I G
/// Y   I   R
/// And then read line by line: "PAHNAPLSIIGYIR"
///
/// Write the code that will take a string and make this conversion given a number of rows
import XCTest

func convert(_ s: String, _ numRows: Int) -> String {
    guard numRows > 1 else { return s }
    
    var result = Array(repeating: "", count: numRows)
    var index = 0
    var reverse = false
    for c in s {
        result[index] =  result[index] + String(c)
        index = reverse ? index - 1 : index + 1
        
        if index == 0 || index == numRows - 1 {
            reverse = !reverse
        }
        
    }
    return result.joined()
}

class Tests: XCTestCase {
    func testExample() {
        let s = "PAYPALISHIRING"
        XCTAssertEqual(convert(s, 3), "PAHNAPLSIIGYIR")
    }
}

Tests.defaultTestSuite.run()
