//
//  MockBeerAPIService.swift
//  GoBeerTests
//
//  Created by Deepak Thakur on 30/01/24.
//

import Foundation
@testable import GoBeer

struct MockBeerAPIService: BeerAPIProtocol {
    let beers: [Test_Beer]
    let error: Error?
    
    init(beers: [Test_Beer]) {
        self.beers = beers
        self.error = nil
    }
    
    init(error: Error) {
        self.error = error
        self.beers = []
    }
    
    func getAllBeers() async throws -> [BeerResponseProtocol] {
        if let error = self.error {
            throw error
        }
        return beers
    }
}
