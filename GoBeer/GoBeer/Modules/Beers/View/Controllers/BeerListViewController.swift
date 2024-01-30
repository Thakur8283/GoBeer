//
//  BeerListViewController.swift
//  GoBeer
//
//  Created by Deepak Thakur on 30/01/24.
//

import UIKit
import Combine

class BeerListViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var beerCollectionView: UICollectionView!
    
    // MARK: - Properties
    // Variables
    var viewModel: BeersViewModel?
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCustomCell()
        bindData()
        loadAllBeers()
    }
    
    // MARK: - Setup methods
    func registerCustomCell() {
        beerCollectionView.register(UINib(nibName: BeerCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: BeerCollectionViewCell.identifier)
    }
    
    // MARK: - Helper methods
    func bindData() {
        viewModel?.$beers
            .receive(on: DispatchQueue.main)
            .sink { beers in
                self.beerCollectionView.reloadData()
            }.store(in: &cancellables)
        
        viewModel?.$loading
            .receive(on: DispatchQueue.main)
            .sink { loading in
                if loading {
                    self.activityIndicatorView.startAnimating()
                } else {
                    self.activityIndicatorView.stopAnimating()
                }
            }.store(in: &cancellables)
        
        viewModel?.$error
            .receive(on: DispatchQueue.main)
            .sink { error in
                if let err = error {
                    self.handleError(err)
                }
            }.store(in: &cancellables)
    }
    
    // MARK: - Data Source methods
    func loadAllBeers() {
        Task {
            try await viewModel?.loadAllBeers()
        }
    }
    
}


// MARK: - CollectionView Delegates & DataSource methods
extension BeerListViewController: UICollectionViewDataSource , UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let beerCount = self.viewModel?.getBeersCount() else {
            return 0
        }
        return beerCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BeerCollectionViewCell.identifier,
                                                            for: indexPath) as? BeerCollectionViewCell,
              let beer = viewModel?.getBeer(for: indexPath) else {
            return UICollectionViewCell()
        }
        cell.configureCell(beer)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (collectionView.frame.size.width - space) / CGFloat(CollectionViewDimensions.noOfColumnsRequired.rawValue)
        return CGSize(width: size, height: CGFloat(CollectionViewDimensions.cellheight.rawValue))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let beer = viewModel?.getBeer(for: indexPath) else {return}
        // Navigate to Beer Details
        NavigationRouter.navigateToBeerDetails(for: beer, with: self.navigationController)
    }
}

