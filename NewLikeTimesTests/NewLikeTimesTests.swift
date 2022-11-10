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

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.newsManager = NewsManager.shared
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testJSONDecode() throws {
        // Read the file
//        let testNewsData = newsManager.loadAll(filename: "test_news_data")
        
        var testNewsData: [NewsDomainModel]!
        
        let expectation = XCTestExpectation(description: "Get all news articles")
        //        guard
        let testBundle = Bundle(for: type(of: self))
        newsManager.loadAll(filename: "test_news_data",
                            bundle: testBundle) { result in
            //        newsManager.loadAll(filename: "news_data") { result in
            switch result {
                //                .success(let newsData):
                //                testNewsData = testNewsData
            case .success(let domainData):
                testNewsData = domainData
            case .failure(let domainError):
                XCTFail("Error fetching data:\(domainError.localizedDescription)")
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 15)
        
//        else {
//            XCTFail("Failed to parse json file")
//            return
//        }
        
        XCTAssertEqual(testNewsData.count, 3, "There only 3 entries in the test data")
        
//        XCTAssertTrue(testNewsData?.count == 3, "There only 3 entries in the test data")
        
        XCTAssertEqual(testNewsData[0].title, "Lorem", "titles do not match")
        XCTAssertEqual(testNewsData[0].images[0].topImage, true, "titles do not match")
        XCTAssertEqual(testNewsData[0].images[0].width, 100, "Widths do not match")
        XCTAssertEqual(testNewsData[0].images[0].height, 50, "Heights do not match")
        XCTAssertEqual(testNewsData[0].body, "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum et arcu ac sem convallis maximus. Curabitur dictum efficitur tempor.", "titles do not match")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
