//
//  NavigationRouter.swift
//  GoBeer
//
//  Created by Deepak Thakur on 30/01/24.
//

import Foundation
import UIKit

struct NavigationRouter {
    static func navigateToBeerDetails(for beer: BeerResponseProtocol, with navigationController: UINavigationController?) {
        let storyBoard = UIStoryboard(name: AppStoryboardsName.main.rawValue, bundle: nil)
        if let beerDetailsViewController = storyBoard.instantiateViewController(withIdentifier: BeerDetailsViewController.className) as? BeerDetailsViewController, let navigationController = navigationController {
            beerDetailsViewController.beer = beer
            navigationController.setNavigationBarHidden(true, animated: true)
            navigationController.pushViewController(beerDetailsViewController, animated: true)
        }
    }
    
    static func provideBeerListViewController() -> BeerListViewController {
        let storyBoard = UIStoryboard(name: AppStoryboardsName.main.rawValue, bundle: nil)
        guard let beerListViewController = storyBoard.instantiateViewController(withIdentifier: BeerListViewController.className) as? BeerListViewController else {
            return BeerListViewController()
        }
        beerListViewController.viewModel = BeersViewModel(service: BeerAPIService())
        return beerListViewController
    }
}
