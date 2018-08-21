/// 737. Sentence Similarity II
/// Given two sentences words1, words2 (each represented as an array of strings), and a list of
/// similar word pairs pairs, determine if two sentences are similar.
///
/// For example, words1 = ["great", "acting", "skills"] and words2 = ["fine", "drama", "talent"] are
/// similar, if the similar word pairs are pairs = [["great", "good"], ["fine", "good"],
/// ["acting","drama"], ["skills","talent"]].
/// Note that the similarity relation is transitive. For example, if "great" and "good" are similar,
/// and "fine" and "good" are similar, then "great" and "fine" are similar. Similarity is also
/// symmetric. For example, "great" and "fine" being similar is the same as "fine" and "great" being
/// similar.
/// Also, a word is always similar with itself. For example, the sentences words1 = ["great"],
/// words2 = ["great"], pairs = [] are similar, even though there are no specified similar word
/// pairs.
/// Finally, sentences can only be similar if they have the same number of words. So a sentence like
/// words1 = ["great"] can never be similar to words2 = ["doubleplus","good"].

import XCTest

struct UnionFind<T: Hashable> {
    private var index: [T: Int] = [:]
    private var parent: [Int] = []
    private var size: [Int] = []
    
    mutating func addSetWith(_ element: T) {
        index[element] = parent.count
        parent.append(parent.count)
        size.append(1)
    }
    
    /// Path Compression.
    private mutating func setByIndex(_ index: Int) -> Int {
        if index != parent[index] {
            parent[index] = setByIndex(parent[index])
        }
        return parent[index]
    }
    
    mutating func setOf(_ element: T) -> Int? {
        if let indexOfElement = index[element] {
            return setByIndex(indexOfElement)
        } else {
            return nil
        }
    }
    
    mutating func unionSetsContaining(_ firstElement: T, and secondElement: T) {
        if let firstSet = setOf(firstElement), let secondSet = setOf(secondElement) {
            if firstSet != secondSet {
                if size[firstSet] < size[secondSet] {
                    parent[firstSet] = secondSet
                    size[secondSet] += size[firstSet]
                } else {
                    parent[secondSet] = firstSet
                    size[firstSet] += size[secondSet]
                }
            }
        }
    }
    
    mutating func inSameSet(_ firstElement: T, and secondElement: T) -> Bool {
        if let firstSet = setOf(firstElement), let secondSet = setOf(secondElement) {
            return firstSet == secondSet
        } else {
            return false
        }
    }
}

/// Approach: Union Find
func areSentencesSimilarTwo(_ words1: [String], _ words2: [String], _ pairs: [[String]]) -> Bool {
    guard words1.count == words2.count else { return false }
    var dset = UnionFind<String>()
    for p in pairs {
        let word1 = p[0]
        let word2 = p[1]
        if dset.setOf(word1) == nil {
            dset.addSetWith(word1)
        }
        if dset.setOf(word2) == nil {
            dset.addSetWith(word2)
        }
        dset.unionSetsContaining(word1, and: word2)
    }
    for i in 0..<words1.count {
        if !dset.inSameSet(words1[i], and: words2[i]) {
            return false
        }
    }
    return true
}

class Tests: XCTestCase {
    func testExample() {
        let words1 = ["great", "acting", "skills"]
        let words2 = ["fine", "drama", "talent"]
        let pairs = [
            ["great", "good"],
            ["fine", "good"],
            ["drama", "acting"],
            ["skills", "talent"],
        ]
        XCTAssertTrue(areSentencesSimilarTwo(words1, words2, pairs))
    }
}

Tests.defaultTestSuite.run()
