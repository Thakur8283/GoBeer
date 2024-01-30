//
//  Test_Beer.swift
//  GoBeerTests
//
//  Created by Deepak Thakur on 30/01/24.
//

import Foundation
@testable import GoBeer

// MARK: - BeerAPIResponse
struct Test_Beer: BeerResponseProtocol {
    var id: Int?
    var name, tagline, description: String?
    var imageURL: String?
    var abv: Double?
    var ibu: Double?
    var volume: Volume?
    var foodPairing: [String]?
    var brewersTips: String?
    
    init(name: String) {
        self.id = 1
        self.name = name
        self.tagline = "dummy tagline"
        self.description = "Beer description"
        self.imageURL = "https://images.punkapi.com/v2/192.png"
        self.abv = 6.0
        self.ibu = 6.0
        self.volume = Volume(value: 10, unit: "liters")
        self.foodPairing = ["Chips", "Salad"]
        self.brewersTips = "dummy tips"
    }
}


