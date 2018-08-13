/// 30. Substring with Concatenation of All Words
/// You are given a string, s, and a list of words, words, that are all of the same length. Find all
/// starting indices of substring(s) in s that is a concatenation of each word in words exactly once
/// and without any intervening characters.
///
/// Example:
/// Input:
/// s = "barfoothefoobarman",
/// words = ["foo","bar"]
/// Output: [0,9]
/// Explanation: Substrings starting at index 0 and 9 are "barfoor" and "foobar" respectively.
///     The output order does not matter, returning [9,0] is fine too.

import XCTest

// Approach: Two Pointers
func findSubstring(_ s: String, _ words: [String]) -> [Int] {
    guard !words.isEmpty else { return [] }
    let wordSize = words[0].count
    let windowSize = wordSize * words.count
    guard s.count >= windowSize else { return [] }
    
    // Build a counted set for words
    var wordCounts: [String: Int] = [:]
    words.forEach { wordCounts[$0, default: 0] += 1}
    
    let chars = Array(s) // substring is extremly slow, so use character array here
    var result: [Int] = []
    for i in 0..<wordSize {
        var left = i
        var right = i
        var counts: [String: Int] = wordCounts
        var found = 0
        while right <= chars.count - wordSize {
            let word = String(chars[right..<right + wordSize])
            right += wordSize
            if let count = counts[word] {
                counts[word] = count - 1
                if count == 1 {
                    found += 1
                }
            }
            
            if found == counts.count {
                result.append(left)
            }
            
            guard right - left == windowSize else { continue }
            let head = String(chars[left..<left + wordSize])
            if let count = counts[head] {
                counts[head] = count + 1
                if count == 0 {
                    found -= 1
                }
            }
            left += wordSize
        }
    }
    return result
}

class Tests: XCTestCase {
    func testExample1() {
        let s = "barfoothefoobarman"
        let words = ["foo","bar"]
        XCTAssertEqual(findSubstring(s, words), [0, 9])
    }
    
    func testExample2() {
        let s = "wordgoodgoodgoodbestword"
        let words = ["word", "good", "best", "good"]
        XCTAssertEqual(findSubstring(s, words), [8])
    }
}

Tests.defaultTestSuite.run()
