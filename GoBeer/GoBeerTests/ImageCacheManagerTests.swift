//
//  ImageCacheManagerTests.swift
//  GoBeerTests
//
//  Created by Deepak Thakur on 30/01/24.
//

import XCTest
import Foundation

@testable import GoBeer

class ImageCacheManagerTests: XCTestCase {

    var sut: ImageCacheManager?
    
    override func setUpWithError() throws {
        sut = ImageCacheManager.shared
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    // MARK: - Success scenario
    // MARK: -
    func testImageDownload_Success() async {
        guard let testImageURL = URL(string: "https://images.punkapi.com/v2/192.png") else {
            return
        }
        do {
            let image = try await sut?.loadImage(for: testImageURL)
            XCTAssertNotNil(image)
            
            if let image = image {
                sut?.cacheImage(image, for: testImageURL)
            }
            let cachedImage = sut?.getCachedImage(for: testImageURL)
            XCTAssertNotNil(cachedImage, "error while fetching image from cache")
        } catch let error {
            XCTAssertNotNil(error, "No error while downloading image")
            XCTFail("Failed to download image")
        }
    }
    
    // MARK: - Failure scenario
    // MARK: -
    // Bad URL for image for testing bad request for image downloading.
    func testImageDownload_Failure() async {
        guard let testImageURL = URL(string: "https://images.punkapi.com/v2/192") else {
            return
        }
        do {
            _ = try await sut?.loadImage(for: testImageURL)
        } catch let error {
            XCTAssertNotNil(error, "No error while downloading image")
            if let error = error as? APIError {
                XCTAssertEqual(error, APIError.badRequest)
            }
        }
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

}
