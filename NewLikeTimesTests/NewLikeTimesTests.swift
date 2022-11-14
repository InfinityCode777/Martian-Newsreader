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
    
    func testStringEnum() throws {
        let origEngText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum 2,000 et ar2cu ac sem convallis maximus. Curabitur dictum efficitur tempor 20."
        
        let expMartianText = "Boinga boinga boinga sit boinga, boinga boinga boinga. Boinga 2,000 et boinga ac sem boinga boinga. Boinga boinga boinga boinga 20."
        let martianText = MartianTranslator.shared.getMartian(origEngText)
        
        //        for (idx, char) in str.enumerated() {
        //            print("\(idx), \(char)")
        //        }
        
        //        let aa = Int("2,000") // nope
        
        XCTAssertEqual(martianText, expMartianText, "Translation error")
        //        print("ahaha")
        
    }
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
    self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
