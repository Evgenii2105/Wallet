//
//  WalletListViewController.swift
//  Wallet
//
//  Created by Евгений Фомичев on 02.07.2025.
//

import UIKit

final class WalletListViewController: UIViewController {
    
    // MARK: Constants
    
    private enum Constants {
        static let cornerRadius: CGFloat = 16
        static let leadingPadding: CGFloat = 20
    }
    
    // MARK: Internal Properties
    
    var presenter: WalletListPresenter?
    
    // MARK: Private Properties
    
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
        backView.backgroundColor = Colors.walletHeaderBackground
        return backView
    }()
    
    private let coinsTable: UITableView = {
        let coinsTable = UITableView()
        coinsTable.backgroundColor = Colors.tableBackground
        coinsTable.layer.cornerRadius = Constants.cornerRadius
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
        moreButton.layer.cornerRadius = Constants.cornerRadius
        return moreButton
    }()
    
    private let boxImage: UIImageView = {
        let boxImage = UIImageView()
        boxImage.image = UIImage(named: "other")
        return boxImage
    }()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        createCoinsTable()
        showLoading()
        presenter?.setupDataSource()
    }
}

// MARK: - WalletListView

extension WalletListViewController: WalletListView {
    func didGet(walletListItems: [WalletListItem]) {
        self.coins = walletListItems
        hideLoading()
        coinsTable.reloadData()
    }
}

// MARK: - Private Extension

private extension WalletListViewController {
    
    func setupUI() {
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
    
    func showLoading() {
        coinsTable.isHidden = true
        loadingStackView.isHidden = false
        loadingIndicator.startAnimating()
        loadingLabel.isHidden = false
    }
    
    func hideLoading() {
        coinsTable.isHidden = false
        loadingStackView.isHidden = true
        loadingIndicator.stopAnimating()
        loadingLabel.isHidden = true
    }
    
    func setupConstraints() {
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
            make.leading.equalToSuperview().offset(Constants.leadingPadding)
        }
        
        affiliateLabel.snp.makeConstraints { make in
            make.top.equalTo(homeLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(Constants.leadingPadding)
        }
        
        learnMoreButton.snp.makeConstraints { make in
            make.top.equalTo(affiliateLabel.snp.bottom).offset(Constants.leadingPadding)
            make.leading.equalToSuperview().offset(Constants.leadingPadding)
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
    
    func createCoinsTable() {
        coinsTable.register(CoinsListHeaderView.self, forHeaderFooterViewReuseIdentifier: CoinsListHeaderView.headerIdentifier)
        coinsTable.register(CoinsListCell.self, forCellReuseIdentifier: CoinsListCell.cellIdentifier)
        coinsTable.dataSource = self
        coinsTable.delegate = self
        coinsTable.separatorStyle = .none
    }
}


// MARK: - UITableViewDelegate && UITableViewDataSource

extension WalletListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CoinsListCell.cellIdentifier, for: indexPath) as? CoinsListCell, indexPath.row < coins.count else {
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
        header.delegate = self
        return header
    }
}

// MARK: - TabBarConfiguration

extension WalletListViewController: TabBarConfiguration {
    
    var tabImage: UIImage? {
        UIImage(systemName: "house")
    }
}

// MARK: - SortHeaderViewDelegate

extension WalletListViewController: SortHeaderViewDelegate {
    func sortedHeader(by sort: CoinsListHeaderView.CoinsSorting) {
        presenter?.sortedHeader(by: sort)
    }
}
