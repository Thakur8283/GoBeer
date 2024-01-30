//
//  BeerListViewControllerTests.swift
//  GoBeerTests
//
//  Created by Deepak Thakur on 30/01/24.
//

import XCTest
@testable import GoBeer

class BeerListViewControllerTests: XCTestCase {
    
    var sut: BeerListViewController!
    
    override func setUpWithError() throws {
        sut = NavigationRouter.provideBeerListViewController()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testViewDidLoad_CollectionViewDelegateAndDataSource_shouldNotBeNil() {
        sut.loadViewIfNeeded()
        XCTAssertNotNil(sut.beerCollectionView.delegate)
        XCTAssertNotNil(sut.beerCollectionView.dataSource)
    }
    
    func testBeerDetailsView_ForBeerData_WithPropertyInjection() {
        var beerDetailsVC:BeerDetailsViewController?
        let beer1 = Test_Beer(name: "beer1")
        let storyBoard = UIStoryboard(name: AppStoryboardsName.main.rawValue, bundle: nil)
        if let beerDetailsViewController = storyBoard.instantiateViewController(withIdentifier: BeerDetailsViewController.className) as? BeerDetailsViewController {
            beerDetailsViewController.beer = beer1
            beerDetailsViewController.loadViewIfNeeded()
            beerDetailsVC = beerDetailsViewController
        }
        
        XCTAssertNotNil(beerDetailsVC)
        XCTAssertNotNil(beerDetailsVC?.beer)
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
