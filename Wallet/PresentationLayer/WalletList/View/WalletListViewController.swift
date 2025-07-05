//
//  WalletListViewController.swift
//  Wallet
//
//  Created by Евгений Фомичев on 02.07.2025.
//

import UIKit

final class WalletListViewController: UIViewController {
    
    var presenter: WalletListPresenter?
    private var coins: [WalletListItem] = []
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .gray
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private let loadingLabel: UILabel = {
        let label = UILabel()
        label.text = "Загрузка..."
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .gray
        label.isHidden = true
        return label
    }()
    
    private lazy var loadingStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [loadingIndicator, loadingLabel])
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .center
        stack.isHidden = true
        return stack
    }()
    
    private let headerView: UIView = {
        let backView = UIView()
        backView.backgroundColor = UIColor(
            red: 241 / 255,
            green: 159 / 255,
            blue: 177 / 255,
            alpha: 1.0
        )
        return backView
    }()
    
    private let coinsTable: UITableView = {
        let coinsTable = UITableView()
        coinsTable.backgroundColor = UIColor(
            red: 247 / 255,
            green: 247 / 255,
            blue: 250 / 255,
            alpha: 1.0
        )
        coinsTable.layer.cornerRadius = 16
        coinsTable.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        coinsTable.layer.masksToBounds = true
        return coinsTable
    }()
    
    private let homeLabel: UILabel = {
        let homeLabel = UILabel()
        homeLabel.text = "Home"
        homeLabel.font = .systemFont(ofSize: 24, weight: .bold)
        homeLabel.textColor = .white
        return homeLabel
    }()
    
    private lazy var moreButton: UIBarButtonItem = {
        let menu = UIMenu(children: [
            UIAction(
                title: "Обновить",
                image: UIImage(systemName: "airplane"),
                handler: { [weak self] _ in
                    self?.presenter?.refreshTable()
                }
            ),
            UIAction(
                title: "Выйти",
                image: UIImage(systemName: "door.left.hand.open"),
                handler: { [weak self] _ in
                    self?.presenter?.didLogout()
                }
            )
        ])
        let didLoginButton = UIBarButtonItem(
            image: UIImage(systemName: "ellipsis.circle.fill"),
            menu: menu
        )
        didLoginButton.tintColor = .white
        return didLoginButton
    }()
    
    private let affiliateLabel: UILabel = {
        let programLabel = UILabel()
        programLabel.text = "Affilate program"
        programLabel.textColor = .white
        programLabel.font = .systemFont(ofSize: 22, weight: .light)
        return programLabel
    }()
    
    private let learnMoreButton: UIButton = {
        let moreButton = UIButton()
        moreButton.setTitle("Learn more", for: .normal)
        moreButton.setTitleColor(.black, for: .normal)
        moreButton.backgroundColor = .white
        moreButton.layer.cornerRadius = 16
        return moreButton
    }()
    
    private let boxImage: UIImageView = {
        let boxImage = UIImageView()
        boxImage.image = UIImage(named: "other")
        return boxImage
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        createCoinsTable()
        showLoading()
        presenter?.setupDataSource()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(loadingStackView)
        view.addSubview(headerView)
        headerView.addSubview(homeLabel)
        navigationItem.rightBarButtonItem = moreButton
        headerView.addSubview(affiliateLabel)
        headerView.addSubview(learnMoreButton)
        headerView.addSubview(boxImage)
        view.addSubview(coinsTable)
    }
    
    private func showLoading() {
        coinsTable.isHidden = true
        loadingStackView.isHidden = false
        loadingIndicator.startAnimating()
        loadingLabel.isHidden = false
    }
    
    private func hideLoading() {
        coinsTable.isHidden = false
        loadingStackView.isHidden = true
        loadingIndicator.stopAnimating()
        loadingLabel.isHidden = true
    }
    
    private func setupConstraints() {
        loadingStackView.snp.makeConstraints { make in
            make.center.equalTo(coinsTable)
        }
        
        headerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(260)
        }
        
        homeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.leading.equalToSuperview().offset(20)
        }
        
        affiliateLabel.snp.makeConstraints { make in
            make.top.equalTo(homeLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(20)
        }
        
        learnMoreButton.snp.makeConstraints { make in
            make.top.equalTo(affiliateLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.width.equalTo(120)
        }
        
        boxImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalToSuperview()
            make.height.equalTo(200)
        }
        
        coinsTable.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(-16)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func createCoinsTable() {
        coinsTable.register(CoinsListHeaderView.self, forHeaderFooterViewReuseIdentifier: CoinsListHeaderView.headerIdentifier)
        coinsTable.register(CoinsListCell.self, forCellReuseIdentifier: CoinsListCell.cellidentifier)
        coinsTable.dataSource = self
        coinsTable.delegate = self
        coinsTable.separatorStyle = .none
    }
}

extension WalletListViewController: WalletListView {
    func didCoins(coins: [WalletListItem]) {
        self.coins = coins
        hideLoading()
        coinsTable.reloadData()
    }
}

extension WalletListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CoinsListCell.cellidentifier, for: indexPath) as? CoinsListCell, indexPath.row < coins.count else {
            return UITableViewCell()
        }
        let coin = coins[indexPath.row]
        cell.configure(with: coin)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.showDetailsCoin(coin: coins[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: CoinsListHeaderView.headerIdentifier) as? CoinsListHeaderView else { return nil }
        header.listiner = self
        return header
    }
}

// MARK: - TabBarConfiguration

extension WalletListViewController: TabBarConfiguration {
    
    var tabImage: UIImage? { nil }
}

extension WalletListViewController: SortedHeaderViewListiner {
    func sortedHeader(by sort: CoinsListHeaderView.CoinsSorting) {
        presenter?.sortedHeader(by: sort)
    }
}
