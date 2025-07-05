//
//  CoinDetailsViewController.swift
//  Wallet
//
//  Created by Евгений Фомичев on 02.07.2025.
//

import SnapKit
import UIKit

final class CoinDetailsViewController: UIViewController {
    
    enum TimePeriod: String, CaseIterable {
        case day = "Day"
        case week = "Week"
        case year = "Year"
        case all = "All"
    }
    
    var presenter: CoinDetailsPresenter?
    private var cellTypes: [CoinDetailsItem] = []
    
    private let priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.text = "$ 65.34242"
        priceLabel.textColor = .black
        priceLabel.font = .systemFont(ofSize: 24, weight: .bold)
        return priceLabel
    }()
    
    private let changePrice: UILabel = {
        let changePrice = UILabel()
        changePrice.text = "2.5 %"
        changePrice.font = .systemFont(ofSize: 16, weight: .light)
        changePrice.textColor = .lightGray
        return changePrice
    }()
    
    private lazy var timePeriodControl: UISegmentedControl = {
        let items = TimePeriod.allCases.map { $0.rawValue }
        let changeTime = UISegmentedControl(items: items)
        changeTime.selectedSegmentTintColor = .lightGray
        changeTime.selectedSegmentIndex = 0
        changeTime.addTarget(self, action: #selector(timePeriodChanged), for: .valueChanged)
        return changeTime
    }()
    
    private let containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 22
        return containerView
    }()
    
    private let marketLabel: UILabel = {
        let marketLabel = UILabel()
        marketLabel.text = "Market Statistic"
        marketLabel.textColor = .black
        marketLabel.numberOfLines = 1
        marketLabel.font = .systemFont(ofSize: 22, weight: .bold)
        return marketLabel
    }()
    
    private let capitatallizationLabel: UILabel = {
        let capitatallizationLabel = UILabel()
        capitatallizationLabel.font = .systemFont(ofSize: 18, weight: .light)
        capitatallizationLabel.textColor = .lightGray
        capitatallizationLabel.text = "Market capitalization"
        return capitatallizationLabel
    }()
    
    private let suply: UILabel = {
        let suply = UILabel()
        suply.text = "Circulating Suply"
        suply.font = .systemFont(ofSize: 18, weight: .light)
        suply.textColor = .lightGray
        return suply
    }()
    
    private let capitalPriceLabel: UILabel = {
        let capitalPriceLabel = UILabel()
        capitalPriceLabel.text = "123.231"
        capitalPriceLabel.textColor = .black
        capitalPriceLabel.font = .systemFont(ofSize: 22, weight: .bold)
        capitalPriceLabel.textAlignment = .right
        return capitalPriceLabel
    }()
    
    private let suplyLabel: UILabel = {
        let suplyLabel = UILabel()
        suplyLabel.font = .systemFont(ofSize: 22, weight: .bold)
        suplyLabel.textColor = .black
        suplyLabel.text = "111.22BTC"
        suplyLabel.textAlignment = .right
        return suplyLabel
    }()
    
    private let statsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        return stack
    }()
    
    private let capitalizationRow: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        return stack
    }()
    
    private let supplyRow: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        configure(coinDetails: cellTypes)
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(
            red: 243 / 255,
            green: 245 / 255,
            blue: 246 / 255,
            alpha: 1.0
        )
        view.addSubview(priceLabel)
        view.addSubview(changePrice)
        view.addSubview(timePeriodControl)
        view.addSubview(containerView)
        
        containerView.addSubview(statsStackView)
        statsStackView.addArrangedSubview(marketLabel)
        
        capitalizationRow.addArrangedSubview(capitatallizationLabel)
        capitalizationRow.addArrangedSubview(capitalPriceLabel)
        statsStackView.addArrangedSubview(capitalizationRow)
        
        supplyRow.addArrangedSubview(suply)
        supplyRow.addArrangedSubview(suplyLabel)
        statsStackView.addArrangedSubview(supplyRow)
        
        setupNavigationBar()
        navigationItem.title = "Bitcoin"
    }
    
    private func setupConstraints() {
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.centerX.equalToSuperview()
        }
        
        changePrice.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        timePeriodControl.snp.makeConstraints { make in
            make.top.equalTo(changePrice.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(32)
        }
        
        containerView.snp.makeConstraints { make in
          //  make.top.equalTo(timePeriodControl.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        statsStackView.snp.makeConstraints { make in
            make.top.equalTo(containerView).offset(16)
            make.leading.equalTo(containerView).offset(16)
            make.trailing.equalTo(containerView).offset(-16)
            make.bottom.equalTo(containerView).offset(-16)
        }
        capitatallizationLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        capitalPriceLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        suply.setContentHuggingPriority(.defaultLow, for: .horizontal)
        suplyLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    private func setupNavigationBar() {
        let backButton = UIButton(type: .system)
        let image = UIImage(systemName: "arrow.backward.circle")
        backButton.setImage(image, for: .normal)
        backButton.tintColor = .black
        backButton.addTarget(
            self,
            action: #selector(backButtonTapped),
            for: .touchUpInside
        )
        let backBarItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem = backBarItem
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func timePeriodChanged() {
        let selectedPeriod = TimePeriod.allCases[timePeriodControl.selectedSegmentIndex]
        //presenter?.timePeriodChanged(to: selectedPeriod)
    }
    
    func configure(coinDetails: [CoinDetailsItem]) {
        
    }
}

extension CoinDetailsViewController: CoinDetailsView {
    
}
