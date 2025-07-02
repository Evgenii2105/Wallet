//
//  WalletListViewController.swift
//  Wallet
//
//  Created by Евгений Фомичев on 02.07.2025.
//

import UIKit

final class WalletListViewController: UIViewController {
    
    enum CoinsSorting {
        case sortedDefault
        case sortedDescending
        case sortedAscending
    }
    
    var presenter: WalletListPresenter?
    private let coins: [WalletListItem] = []
    private var currentSorted: CoinsSorting = .sortedDefault
    
    private let coinsTable: UITableView = {
       let coinsTable = UITableView()
        coinsTable.backgroundColor = .white
        coinsTable.layer.cornerRadius = 16
        return coinsTable
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        
    }
    
    private func setupConstraints() {
        
    }
    
    private func createCoinsTable() {
        coinsTable.register(CoinsListCell.self, forCellReuseIdentifier: CoinsListCell.cellidentifier)
        coinsTable.dataSource = self
        coinsTable.delegate = self
    }
}

extension WalletListViewController: WalletListView {
    
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
    }
}
