//
//  BeersViewModelTests.swift
//  GoBeerTests
//
//  Created by Deepak Thakur on 30/01/24.
//

import XCTest
@testable import GoBeer

class BeersViewModelTests: XCTestCase {
    var sut: BeersViewModel?
    
    override func setUpWithError() throws {
        sut = BeersViewModel(service: MockBeerAPIService(beers: []))
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    // MARK: - Success scenario
    // MARK: -
    func testGetCountBeers_3Beers_3() async {
        let beer1 = Test_Beer(name: "beer1")
        let beer2 = Test_Beer(name: "beer2")
        let beer3 = Test_Beer(name: "beer3")
        
        let service = MockBeerAPIService(beers: [beer1, beer2, beer3])
        sut = BeersViewModel(service: service)
        
        do {
            try await sut?.loadAllBeers()
        } catch {
            XCTFail("Failed to load beers")
        }
        
        XCTAssertEqual(sut?.getBeersCount(), 3)
    }
    
    func testGetBeer_3Beer_returnThirdBeer() async {
        let beer1 = Test_Beer(name: "beer1")
        let beer2 = Test_Beer(name: "beer2")
        let beer3 = Test_Beer(name: "beer3")
        
        let service = MockBeerAPIService(beers: [beer1, beer2, beer3])
        sut = BeersViewModel(service: service)
        
        do {
            try await sut?.loadAllBeers()
        } catch {
            XCTFail("Failed to load beers")
        }
        
        XCTAssertEqual(sut?.getBeer(for: IndexPath(row: 2, section: 0))?.name, beer3.name)
    }
    
    // MARK: - Failure scenario
    // MARK: -
    func testGet_Beers_API_FailureRsponse_WithInvalidResponseFormat() async {
        let service = MockBeerAPIService(error: BeerAPIError.invalidResponseFormat)
        sut = BeersViewModel(service: service)
        do {
            try await sut?.loadAllBeers()
        } catch {
            XCTFail("Failed to load beers")
        }
        XCTAssertNotNil(sut?.error, "No Error while parsing json response")
        XCTAssertEqual(sut?.beers.count, 0)
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
