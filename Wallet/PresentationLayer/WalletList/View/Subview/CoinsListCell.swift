//
//  CoinsListCell.swift
//  Wallet
//
//  Created by Евгений Фомичев on 02.07.2025.
//

import SnapKit
import UIKit

final class CoinsListCell: UITableViewCell {
    
    // MARK: Constants
    
    private enum Constants {
        static let twelvePadding: CGFloat = 12
        static let eightPadding: CGFloat = 8
    }
    
    // MARK: Internal Properties
    
    static let cellIdentifier = "CoinsListCell"
    
    // MARK: Private Properties
    
    private let imageCoins: UIImageView = {
        let imageCoins = UIImageView()
        imageCoins.image = UIImage(systemName: "photo")
        imageCoins.tintColor = UIColor(
            red: 251 / 255,
            green: 229 / 255,
            blue: 199 / 255,
            alpha: 1
        )
            
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
    
    // MARK: Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Func
    
    private func setupUI() {
        contentView.backgroundColor = Colors.coinCellBackground
        contentView.addSubview(imageCoins)
        contentView.addSubview(nameLabel)
        contentView.addSubview(shortNameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(changeLabel)
    }
    
    private func setupConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.twelvePadding)
            make.leading.equalTo(imageCoins.snp.trailing).offset(Constants.twelvePadding)
        }
        
        shortNameLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(Constants.eightPadding)
            make.leading.equalTo(imageCoins.snp.trailing).offset(Constants.twelvePadding)
            make.bottom.equalToSuperview().offset(-Constants.eightPadding)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.twelvePadding)
            make.trailing.equalTo(-Constants.twelvePadding)
        }
        
        changeLabel.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(Constants.twelvePadding)
            make.trailing.equalTo(-12)
            make.bottom.equalToSuperview().offset(-Constants.eightPadding)
        }
        
        imageCoins.snp.makeConstraints { make in
            make.leading.equalTo(Constants.twelvePadding)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(40)
        }
    }
    
    private func formatPrice(_ price: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        formatter.decimalSeparator = "."
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        return formatter.string(from: NSNumber(value: price)) ?? "\(price)"
    }
    
    func configure(with coin: WalletListItem) {
        nameLabel.text = coin.name
        priceLabel.text = formatPrice(coin.price)
        imageCoins.image = coin.image
        shortNameLabel.text = coin.symbol
        let changeText = formatPrice(coin.changePrice)
        let attachment = NSTextAttachment()
        
        if coin.changePrice > 0 {
            attachment.image = UIImage(systemName: "chevron.compact.up")?.withTintColor(.green)
        } else {
            attachment.image = UIImage(systemName: "chevron.compact.down")?.withTintColor(.red)
        }
        
        let attributedString = NSMutableAttributedString(attachment: attachment)
        attributedString.append(NSAttributedString(string: "  \(changeText)"))
        changeLabel.attributedText = attributedString
    }
}
