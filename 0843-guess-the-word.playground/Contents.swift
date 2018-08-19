/// 843. Guess the Word
/// We are given a word list of unique words, each word is 6 letters long, and one word in this
/// list is chosen as secret. You may call master.guess(word) to guess a word. The guessed word
/// should have type string and must be from the original list with 6 lowercase letters. This
/// function returns an integer type, representing the number of exact matches (value and position)
/// of your guess to the secret word.  Also, if your guess is not in the given wordlist, it will
/// return -1 instead.
/// For each test case, you have 10 guesses to guess the word. At the end of any number of calls,
/// if you have made 10 or less calls to master.guess and at least one of these guesses was the
/// secret, you pass the testcase.
/// Besides the example test case below, there will be 5 additional test cases, each with 100 words
/// in the word list. The letters of each word in those testcases were chosen independently at
/// random from 'a' to 'z', such that every word in the given word lists is unique.
///
/// Example 1:
/// Input: secret = "acckzz", wordlist = ["acckzz","ccbazz","eiowzz","abcczz"]
///
/// Explanation:
///
/// master.guess("aaaaaa") returns -1, because "aaaaaa" is not in wordlist.
/// master.guess("acckzz") returns 6, because "acckzz" is secret and has all 6 matches.
/// master.guess("ccbazz") returns 3, because "ccbazz" has 3 matches.
/// master.guess("eiowzz") returns 2, because "eiowzz" has 2 matches.
/// master.guess("abcczz") returns 4, because "abcczz" has 4 matches.
///
/// We made 5 calls to master.guess and one of them was the secret, so we pass the test case.

import XCTest

final class Master {
    private(set) var guessCount = 0
    private(set) var secretFound = false
    
    private var wordlist: Set<String>
    private var secret: [Character]
    
    init(wordlist: [String], secret: String) {
        self.wordlist = Set(wordlist)
        self.secret = Array(secret)
    }
    
    func guess(word: String) -> Int {
        guessCount += 1
        guard wordlist.contains(word) else { return -1 }
        let word = Array(word)
        var match = 0
        for i in 0..<6 {
            if secret[i] == word[i] {
                match += 1
            }
        }
        if match == 6 {
            secretFound = true
        }
        return match
    }
}

/// Approach: Minimax
func findSecretWord(_ wordlist: [String], _ master: Master) {
    let n = wordlist.count
    var h = Array(repeating: Array(repeating: -1, count: n), count: n)
    for i in 0..<n {
        for j in 0..<n {
            guard h[i][j] == -1 else { continue }
            var wordI = Array(wordlist[i])
            var wordJ = Array(wordlist[j])
            var match = 0
            for k in 0..<6 {
                if wordI[k] == wordJ[k] {
                    match += 1
                }
            }
            h[i][j] = match
            h[j][i] = match
        }
    }
    
    func nextGuess(possible: [Int]) -> Int {
        guard possible.count > 2 else { return possible[0] }
        var minSize = possible.count
        var minGuess = 0
        for guess in possible {
            var groups = Array(repeating: 0, count: 7)
            for p in possible {
                if p != guess {
                    groups[h[guess][p]] += 1
                }
            }
            if let size = groups.max(),
               size < minSize {
                minSize = size
                minGuess = guess
            }
        }
        return minGuess
    }
    
    var possible = Array(0..<n)
    while !possible.isEmpty {
        let guess = nextGuess(possible: possible)
        let match = master.guess(word: wordlist[guess])
        guard match < 6 else { return }
        var temp: [Int] = []
        for p in possible {
            if h[guess][p] == match {
                temp.append(p)
            }
        }
        possible = temp
    }
}

class Tests: XCTestCase {
    func testExample() {
        let wordlist = ["acckzz", "ccbazz", "eiowzz", "abcczz"]
        let secret = "acckzz"
        let master = Master(wordlist: wordlist, secret: secret)
        findSecretWord(wordlist, master)
        XCTAssertTrue(master.secretFound)
        XCTAssertTrue(master.guessCount <= 10)
    }
}

Tests.defaultTestSuite.run()
