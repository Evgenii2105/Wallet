//
//  CoinsListCell.swift
//  Wallet
//
//  Created by Евгений Фомичев on 02.07.2025.
//

import SnapKit
import UIKit

final class CoinsListCell: UITableViewCell {
    
    static let cellidentifier = "CoinsListCell"
    
    private let imageCoins: UIImageView = {
        let imageCoins = UIImageView()
        imageCoins.image = UIImage(systemName: "photo")
        imageCoins.tintColor = .black
        return imageCoins
    }()
    
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = .systemFont(ofSize: 24, weight: .bold)
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .left
        nameLabel.textColor = .black
        return nameLabel
    }()
    
    private let shortNameLabel: UILabel = {
        let shortName = UILabel()
        shortName.textColor = .lightGray
        shortName.font = .systemFont(ofSize: 18, weight: .light)
        shortName.textAlignment = .left
        shortName.numberOfLines = 0
        return shortName
    }()
    
    private let priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.numberOfLines = 1
        priceLabel.textColor = .black
        priceLabel.textAlignment = .right
        priceLabel.font = .systemFont(ofSize: 24, weight: .bold)
        return priceLabel
    }()
    
    private let changeLabel: UILabel = {
        let changeLabel = UILabel()
        changeLabel.font = .systemFont(ofSize: 18, weight: .light)
        changeLabel.textColor = .lightGray
        changeLabel.numberOfLines = 1
        changeLabel.textAlignment = .right
        return changeLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(imageCoins)
        contentView.addSubview(nameLabel)
        contentView.addSubview(shortNameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(changeLabel)
    }
    
    private func setupConstraints() {
        
    }
    
    func configure(with coin: WalletListItem) {
        nameLabel.text 
    }
}
