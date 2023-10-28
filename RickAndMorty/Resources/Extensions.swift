//
//  Extensions.swift
//  RickAndMorty
//
//  Created by Victor Domingues on 28/10/23.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach({
            self.addSubview($0)
        })
    }
}
