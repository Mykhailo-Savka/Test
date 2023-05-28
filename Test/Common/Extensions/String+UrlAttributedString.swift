//
//  String+UrlAttributedString.swift
//  Test
//
//  Created by Savka Mykhailo on 25.05.2023.
//

import UIKit

extension String {
    func urlAttributedString(with font: UIFont, url: String) -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font,
                                                         NSAttributedString.Key.foregroundColor: Constants.Colors.termsColor!,
                                                         NSAttributedString.Key.link: url]
        
        let attributedString = NSMutableAttributedString(string: self, attributes: attributes)
        
        return attributedString
    }
}
