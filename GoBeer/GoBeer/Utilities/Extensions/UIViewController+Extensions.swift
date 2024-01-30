//
//  UIViewController+Extensions.swift
//  GoBeer
//
//  Created by Deepak Thakur on 30/01/24.
//

import Foundation
import UIKit

extension UIViewController {
    
    static var className: String {
        return String(describing: self)
    }
    
    public func handleError(_ error: Error) {
        let alertVC = UIAlertController(title: AlertVariables.alertErrorTitle.rawValue, message: error.localizedDescription, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: AlertVariables.cancel.rawValue, style: .cancel, handler: nil)
        alertVC.addAction(okayAction)
        present(alertVC, animated: true, completion: nil)
    }
}

