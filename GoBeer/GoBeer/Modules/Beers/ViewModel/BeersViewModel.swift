//
//  BeersViewModel.swift
//  GoBeer
//
//  Created by Deepak Thakur on 30/01/24.
//

import Foundation
import Combine

class BeersViewModel {
    
    // MARK: - Properties
    //Published
    @Published private(set) var beers: [BeerResponseProtocol] = []
    @Published private(set) var loading: Bool = false
    @Published private(set) var error: Error? = nil
    
    // MARK: - Properties
    // Variables
    private let service: BeerAPIProtocol
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Custom Initializer
    init(service: BeerAPIProtocol = BeerAPIService()) {
        self.service = service
    }
    
    // MARK: - View Model Helper Methods
    func getBeersCount() -> Int {
        return beers.count
    }
    
    func getBeer(for indexPath: IndexPath) -> BeerResponseProtocol? {
        guard indexPath.section == 0, indexPath.row >= 0 else { return nil }
        return beers[indexPath.row]
    }
    
    
    func loadAllBeers() async throws {
        self.loading = true
        do {
            let beers = try await service.getAllBeers()
            self.beers = beers
        } catch let error {
            self.error = error
        }
        self.loading = false
    }
}
