//
//  UICollectionViewCell+Identifier.swift
//  GoBeer
//
//  Created by Deepak Thakur on 30/01/24.
//

import Foundation
import UIKit

extension UICollectionViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

