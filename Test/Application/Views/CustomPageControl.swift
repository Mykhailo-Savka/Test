//
//  CustomPageControl.swift
//  Test
//
//  Created by Savka Mykhailo on 25.05.2023.
//

import Foundation
import UIKit

// MARK: - CustomPageControl
final class CustomPageControl: UIPageControl {
    
    // MARK: - Private properties
    private let dotSize: CGSize = CGSize(width: 14, height: 4)
    private let dotSpacing: CGFloat = 8
    private let currentDotSize = CGSize(width: 25, height: 4)
    
    override var numberOfPages: Int {
        didSet {
            updateDots()
        }
    }
    
    override var currentPage: Int {
        didSet {
            updateDots()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateDots()
    }
    
    // MARK: - Private methods
    private func updateDots() {
        subviews.forEach({ $0.removeFromSuperview() })
        for index in 0 ..< numberOfPages {
            let dot = createDotView()
            let width = index == currentPage ? currentDotSize.width : dotSize.width
            let xPos: CGFloat
            
            if index > 0 {
                xPos = subviews[index - 1].frame.maxX + dotSpacing
            } else {
                xPos = (width + dotSpacing) * CGFloat(index)
            }
            
            let yPos = (bounds.height - dotSize.height) / 2
            dot.frame = CGRect(x: xPos, y: yPos, width: width, height: dotSize.height)
            
            if index == currentPage {
                dot.backgroundColor = Constants.Colors.dotHighlightedColor
            } else {
                dot.backgroundColor = Constants.Colors.dotColor
            }
            
            addSubview(dot)
        }
    }
    
    private func createDotView() -> UIView {
        let dotView = UIView()
        dotView.layer.cornerRadius = dotSize.height / 2
        dotView.layer.masksToBounds = true
        return dotView
    }
}
