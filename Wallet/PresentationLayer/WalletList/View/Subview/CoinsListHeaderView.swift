//
//  CoinsListHeaderView.swift
//  Wallet
//
//  Created by Евгений Фомичев on 03.07.2025.
//

import UIKit
import SnapKit

protocol SortedHeaderViewListiner: AnyObject {
    func sortedHeader(by sort: CoinsListHeaderView.CoinsSorting)
}

final class CoinsListHeaderView: UITableViewHeaderFooterView {
    
    enum CoinsSorting {
        case sortedDefault
        case sortedDescending
        case sortedAscending
    }
    
    static let headerIdentifier = "CoinsListHeaderView"
    weak var listiner: SortedHeaderViewListiner?
    private var currentSorted: CoinsSorting = .sortedDefault

    
    private let titleLabel: UILabel = {
       let titleLabel = UILabel()
        titleLabel.text = "Trending"
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.textColor = .black
        return titleLabel
    }()
    
    private let sortedButton: UIButton = {
       let sortedButton = UIButton()
        let image = UIImage(systemName: "arrow.up.arrow.down")
        sortedButton.setImage(image, for: .normal)
        sortedButton.tintColor = .black
        return sortedButton
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = UIColor(
            red: 243 / 255,
            green: 245 / 255,
            blue: 246 / 255,
            alpha: 1.0
        )
        contentView.addSubview(titleLabel)
        contentView.addSubview(sortedButton)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        
        sortedButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
    }
    
    private func setupActions() {
        sortedButton.addTarget(self, action: #selector(tappedSortButton), for: .touchUpInside)
    }
    
    @objc
    private func tappedSortButton() {
        sortedButton.showsMenuAsPrimaryAction = true
        
        let sortedDefault = UIAction(
            title: "Сорировка по умолчанию",
            state: currentSorted == .sortedDefault ? .on : .off) { [weak self] _ in
                self?.currentSorted = .sortedDefault
                self?.tappedSortButton()
                self?.listiner?.sortedHeader(by: .sortedDefault)
            }
        
        let sortDescending = UIAction(
            title: "Сортировка по убыванию стоимости",
            state: currentSorted == .sortedDescending ? .on : .off) { [weak self] _ in
                self?.currentSorted = .sortedDescending
                self?.tappedSortButton()
                self?.listiner?.sortedHeader(by: .sortedDescending)
            }
        
        let sortAscending = UIAction(
            title: "Сортировка по возрастанию стоимости",
            state: currentSorted == .sortedAscending ? .on : .off) { [weak self] _ in
                self?.currentSorted = .sortedAscending
                self?.tappedSortButton()
                self?.listiner?.sortedHeader(by: .sortedAscending)
            }
        sortedButton.menu = UIMenu(title: "", children: [sortedDefault, sortDescending, sortAscending])
    }
}
