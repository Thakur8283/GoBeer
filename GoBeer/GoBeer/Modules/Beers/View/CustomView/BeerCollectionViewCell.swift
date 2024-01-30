//
//  BeerCollectionViewCell.swift
//  GoBeer
//
//  Created by Deepak Thakur on 30/01/24.
//

import UIKit

class BeerCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var cellBgView: UIView!
    @IBOutlet weak var beerTaglineLabel: UILabel!
    @IBOutlet weak var beerNameLabel: UILabel!
    @IBOutlet weak var beerImageView: UIImageView!
    
    // MARK: - Properties
    //Computed Properties
    private var loadedImage: UIImage? {
        didSet {
            setNeedsUpdateConfiguration()
        }
    }
    //Variables
    private var beer: BeerResponseProtocol!
    
    // MARK: - View Helper Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        cellBgView.layer.cornerRadius = 10
    }
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        self.beerImageView.image = self.loadedImage
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.beerImageView.image = nil
    }
    
    // MARK: - Setup UI
    func configureCell(_ beer: BeerResponseProtocol?) {
        guard let beer = beer else { return }
        self.beer = beer
        updateImage(for: beer)
        updateBeerDetails(for: beer)
    }
    
    private func updateBeerDetails(for beer: BeerResponseProtocol) {
        beerNameLabel.text = beer.name
        beerTaglineLabel.text = beer.tagline
    }
    
    
    private func updateImage(for beer: BeerResponseProtocol) {
        guard let imageURL = URL(string: beer.imageURL ?? "") else { return }
        Task {
            do {
                self.loadedImage = try await ImageCacheManager.shared.loadImage(for: imageURL)
            } catch {
                self.loadedImage = UIImage(named: "beerPlaceholder")
            }
        }
    }
}
