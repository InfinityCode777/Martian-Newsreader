//
//  NewLikeTimesTests.swift
//  NewLikeTimesTests
//
//  Created by Jing Wang on 11/7/22.
//

import XCTest
@testable import NewLikeTimes

class NewLikeTimesTests: XCTestCase {
    var newsManager: NewsManager!
    var testNewsData: [NewsDomainModel]!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        newsManager = NewsManager.shared
        loadJSONData()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

//    func testJSONDecode() throws {
    func loadJSONData() {
        let expectation = XCTestExpectation(description: "Get all news articles")
        //        guard
        let testBundle = Bundle(for: type(of: self))
        newsManager.loadAll(filename: "test_news_data",
                            bundle: testBundle) {[weak self] result in
            switch result {
            case .success(let domainData):
                self?.testNewsData = domainData
            case .failure(let domainError):
                XCTFail("Error fetching data:\(domainError.localizedDescription)")
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 15)
        
        XCTAssertEqual(testNewsData.count, 3, "There only 3 entries in the test data")
    }
    
    func testDataMatch1() throws {
        XCTAssertEqual(testNewsData[0].title, "Lorem", "titles do not match")
        XCTAssertEqual(testNewsData[0].images[0].topImage, true, "topImage do not match")
        XCTAssertEqual(testNewsData[0].images[0].width, 100, "Widths do not match")
        XCTAssertEqual(testNewsData[0].images[0].height, 50, "Heights do not match")
        XCTAssertEqual(testNewsData[0].body, "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum et arcu ac sem convallis maximus. Curabitur dictum efficitur tempor.", "titles do not match")
    }
    
    func testDataMatch2() throws {
        XCTAssertEqual(testNewsData[2].title, "Lorem", "titles do not match")
        XCTAssertEqual(testNewsData[2].images[1].topImage, false, "topImage do not match")
        XCTAssertEqual(testNewsData[2].images[1].width, 180, "Widths do not match")
        XCTAssertEqual(testNewsData[2].images[1].height, 80, "Heights do not match")
        XCTAssertEqual(testNewsData[2].body, "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum et arcu ac sem convallis maximus. Curabitur dictum efficitur tempor.")
    }
    
    func testStringEnum() {
        var origEngText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum 2,000 et ar2cu ac sem convallis maximus. Curabitur dictum efficitur tempor."
        
        var expMartianText = "Boinga boinga boinga sit boinga, boinga boinga boinga. Boinga 2,000 et boinga ac sem boinga boinga. Boinga boinga boinga boinga."
        var martianText = ""
        
        //        for (idx, char) in str.enumerated() {
        //            print("\(idx), \(char)")
        //        }
        
        var res = [String]()
        var engWord = ""
        var martianWord = ""
        
        //        for ch in engText {
        for idx in 0..<origEngText.count {
            //        for idx = 0; idx < engText.count; idx++ {
            //        for (idx, ch) in engText.enumerated() {
            let ch: Character = origEngText[idx]
            //            print("\(ch)")
            // 2,000. -> num
            // 2.     -> '/0'
            // 2,000, eng ->
            //            if !(ch.isLetter || (ch.isNumber && !engText[idx + 2].isNumber)) {
            if ch.isLetter || ch.isNumber {
                engWord.append(String(ch))
                //            } else if ch == "," {
            } else if ch == "," {
                // 2,000. -> num
                // 2.     -> '/0'
                // 2,000, eng ->
                // num is abc
                // current engWord is a number
                if let _ = Int(engWord)  {
                    //                    if idx == engText.count - 1 || !engWord[idx + 1].isNumber {
                    if !origEngText[idx + 1].isNumber {
//                        res.append(engWord)
//                        res.append(String(ch))
                        martianText += engWord + String(ch)
                        engWord = ""
                    }
                } else {
                    martianWord = engWord.count > 3 ? covertToMartianWord(engWord) : engWord
//                    res.append(martianWord)
//                    res.append(String(ch))
                    martianText += martianWord + String(ch)
                    engWord = ""
                }
                
            } else {
                if let _ = Int(engWord)  {
                    //                    if idx == engText.count - 1 || !engWord[idx + 1].isNumber {
                    //                    if !engWord[idx + 1].isNumber {
//                    res.append(engWord)
//                    res.append(String(ch))
                    martianText += engWord + String(ch)
                    engWord = ""
                    //                    }
                } else {
                    martianWord = engWord.count > 3 ? covertToMartianWord(engWord) : engWord
//                    res.append(martianWord)
//                    res.append(String(ch))
                    martianText += martianWord + String(ch)
                    engWord = ""
                }
                
            }
        }
        
        
        XCTAssertEqual(martianText, expMartianText, "Translation error")
//        print("ahaha")

    }
    
    private func covertToMartianWord(_ word:String) -> String {
        let encryption1 = "Boinga"
        let encryption2 = "boinga"

        // e.g. 2,500
        var martianWord = ""
        if let _ = Int(word) {
            return word
        }
        
        if word.count <= 3 {
            martianWord = word
        } else {
            return word.first?.isUppercase == true ? encryption1 : encryption2
        }
        return martianWord
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
    self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
