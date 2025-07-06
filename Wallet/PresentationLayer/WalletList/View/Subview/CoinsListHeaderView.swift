//
//  CoinsListHeaderView.swift
//  Wallet
//
//  Created by Евгений Фомичев on 03.07.2025.
//

import UIKit
import SnapKit

protocol SortHeaderViewDelegate: AnyObject {
    func sortedHeader(by sort: WalletListInteractorImpl.CoinsSorting)
}

final class CoinsListHeaderView: UITableViewHeaderFooterView {
    
    // MARK: Constants
    
    private enum Constants {
        static let sixteenPadding: CGFloat = 16
    }
    
    // MARK: Internal Properties

    static let headerIdentifier = "CoinsListHeaderView"
    weak var delegate: SortHeaderViewDelegate?
    
    // MARK: Private Properties
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Trending"
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.textColor = .black
        return titleLabel
    }()
    
    private let sortButton: UIButton = {
        let sortButton = UIButton()
        let image = UIImage(systemName: "arrow.up.arrow.down")
        sortButton.setImage(image, for: .normal)
        sortButton.tintColor = .black
        sortButton.showsMenuAsPrimaryAction = true
        return sortButton
    }()
    
    // MARK: Lifecycle
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Actions
    
    func configure(with menu: UIMenu) {
        sortButton.menu = menu
    }
}

// MARK: - Private Extension

private extension CoinsListHeaderView {
    
    func setupUI() {
        backgroundColor = Colors.coinDetailViewBackground
        contentView.addSubview(titleLabel)
        contentView.addSubview(sortButton)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Constants.sixteenPadding)
            make.centerY.equalToSuperview()
        }
        
        sortButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-Constants.sixteenPadding)
            make.centerY.equalToSuperview()
        }
    }
}
