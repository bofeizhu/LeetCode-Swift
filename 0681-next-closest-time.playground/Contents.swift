/// 681. Next Closest Time
/// Given a time represented in the format "HH:MM", form the next closest time by reusing the
/// current digits. There is no limit on how many times a digit can be reused.
/// You may assume the given input string is always valid. For example, "01:34", "12:09" are all
/// valid. "1:34", "12:9" are all invalid.

import XCTest

/// Approach: String
func nextClosestTime(_ time: String) -> String {
    guard time.count == 5 else { fatalError() }
    let timeChars = Array(time)
    let hh = Int(String(timeChars[0..<2]))!
    let mm = Int(String(timeChars[3..<5]))!
    var m = (mm + 1) % 60
    var h = m == 0 ? (hh + 1) % 24 : hh
    let timeSet = Set(timeChars)
    while h != hh || m != mm {
        let hStr = h > 9 ? String(h) : "0" + String(h)
        let mStr = m > 9 ? String(m) : "0" + String(m)
        let nextTime = hStr + ":" + mStr
        if Set(Array(nextTime)).isSubset(of: timeSet) {
            return nextTime
        }
        m = (m + 1) % 60
        h = m == 0 ? (h + 1) % 24 : h
    }
    return time
}

class Tests: XCTestCase {
    func testExample() {
        let time = "19:34"
        XCTAssertEqual(nextClosestTime(time), "19:39")
    }
}

Tests.defaultTestSuite.run()
