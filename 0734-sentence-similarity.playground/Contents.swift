/// 734. Sentence Similarity
/// Given two sentences words1, words2 (each represented as an array of strings), and a list of
/// similar word pairs pairs, determine if two sentences are similar.
/// For example, "great acting skills" and "fine drama talent" are similar, if the similar word
/// pairs are pairs = [["great", "fine"], ["acting","drama"], ["skills","talent"]]. Note that the
/// similarity relation is not transitive. For example, if "great" and "fine" are imilar, and "fine"
/// and "good" are similar, "great" and "good" are not necessarily similar. However, similarity is
/// symmetric. For example, "great" and "fine" being similar is the same as "fine" and "great" being
/// similar. Also, a word is always similar with itself. For example, the sentences
/// words1 = ["great"], words2 = ["great"], pairs = [] are similar, even though there are no
/// specified similar word pairs.
/// Finally, sentences can only be similar if they have the same number of words. So a sentence like
/// words1 = ["great"] can never be similar to words2 = ["doubleplus","good"].

import XCTest

/// Approach: Dictionary
func areSentencesSimilar(_ words1: [String], _ words2: [String], _ pairs: [[String]]) -> Bool {
    guard words1.count == words2.count else { return false }
    var dict: [String: String] = [:]
    dict.reserveCapacity(pairs.count * 2)
    for pair in pairs {
        dict[pair[0]] = pair[1]
        dict[pair[1]] = pair[0]
    }
    for i in 0..<words1.count {
        if dict[words1[i]] != words2[i] && dict[words2[i]] != words1[i] {
            return false
        }
    }
    return true
}

class Tests: XCTestCase {
    func testExample() {
        let words1 = ["great", "acting", "skills"]
        let words2 = ["fine", "drama", "talent"]
        let pairs = [["great", "fine"], ["drama", "acting"], ["skills", "talent"]]
        XCTAssertTrue(areSentencesSimilar(words1, words2, pairs))
    }
}

Tests.defaultTestSuite.run()
