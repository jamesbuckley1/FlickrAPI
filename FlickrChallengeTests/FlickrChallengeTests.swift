//
//  FlickrChallengeTests.swift
//  FlickrChallengeTests
//
//  Created by James Buckley on 17/11/2022.
//

import XCTest
import Combine
@testable import FlickrChallenge

final class FlickrChallengeTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    override func tearDown() {
        subscriptions = []
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    var subscriptions = Set<AnyCancellable>()
    
    func testGettingPhotosSuccess() {
        
        let fetcher = PhotoFetcher(service: APIService(), fetchType: .recentPhotos)
        
        let promise = expectation(description: "Getting photos")
        
        fetcher.$photos.sink { photos in
            if photos.count > 0 {
                promise.fulfill()
            }
        }.store(in: &subscriptions)
        
       
        wait(for: [promise], timeout: 10)
    }

}
