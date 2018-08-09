/// 7. Reverse Integer
/// Given a 32-bit signed integer, reverse digits of an integer.

import XCTest

func reverse(_ x: Int) -> Int {
    var temp = x
    var output = 0
    
    while temp != 0 {
        let pop = temp % 10
        temp = temp / 10
        output = output * 10 + pop
        if (output > Int32.max || output < Int32.min) { return 0 }
    }
    
    return output
}

class Tests: XCTestCase {
    func testExample() {
        XCTAssertEqual(reverse(123), 321)
    }
}

Tests.defaultTestSuite.run()
