//
//  BeerDetailsViewController.swift
//  GoBeer
//
//  Created by Deepak Thakur on 30/01/24.
//

import UIKit

final class BeerDetailsViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var beerDescriptionLabel: UILabel!
    @IBOutlet private weak var beerVolumeLabel: UILabel!
    @IBOutlet private weak var beerTitleLabel: UILabel!
    @IBOutlet private weak var beerImageView: UIImageView!
    
    // MARK: - Properties
    // Variables
    var beer: BeerResponseProtocol?
    
    // MARK: - View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    // MARK: - Setup methods
    private func setUpUI() {
        guard let beerDetails = beer else {return}
        beerDescriptionLabel.text = beerDetails.description
        if let beerVolume = beerDetails.volume,let beerVolumeValue = beerVolume.value,let beerVolumeUnit = beerVolume.unit, let abv = beerDetails.abv {
            let beerVolumeString = "\(String(format: "%.f", beerVolumeValue))\(beerVolumeUnit) | \(abv)%"
            beerVolumeLabel.text = beerVolumeString
        }
        beerTitleLabel.text = beerDetails.name
        
        guard let imageURL = URL(string: beerDetails.imageURL ?? "") else { return }
        Task {
            do {
                self.beerImageView.image = try await ImageCacheManager.shared.loadImage(for: imageURL)
            } catch {
                self.beerImageView.image = nil
            }
        }
    }
    
    // MARK: - Action Outlets
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
