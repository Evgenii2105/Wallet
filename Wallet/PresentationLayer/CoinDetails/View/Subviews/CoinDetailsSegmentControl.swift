//
//  CoinDetailsSegmentControl.swift
//  Wallet
//
//  Created by Евгений Фомичев on 09.07.2025.
//

import UIKit

final class CoinDetailsSegmentControl: UISegmentedControl {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
        guard let selectedSegment = subviews[numberOfSegments] as? UIImageView else { return }
        selectedSegment.image = nil
        selectedSegment.backgroundColor = selectedSegmentTintColor
        selectedSegment.layer.removeAnimation(forKey: "SelectionBounds")
        let verticalSelectedSegmentPadding: CGFloat = 3
        let horizontalSelectedPadding: CGFloat = 6
        selectedSegment.bounds = CGRect(
            origin: CGPoint(
                x: horizontalSelectedPadding,
                y: verticalSelectedSegmentPadding
            ),
            size: CGSize(
                width: selectedSegment.bounds.width - horizontalSelectedPadding * 2,
                height: bounds.height - verticalSelectedSegmentPadding * 2
            )
        )
        selectedSegment.layer.cornerRadius = selectedSegment.bounds.height / 2 - layer.borderWidth
        selectedSegment.layer.shadowColor = Colors.segmentedControlSelectedShadow.cgColor
        selectedSegment.layer.shadowRadius = verticalSelectedSegmentPadding
        selectedSegment.layer.shadowOffset = CGSize(width: 0, height: 20)
    }
}
