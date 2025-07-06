//
//  CoinDetailsViewController.swift
//  Wallet
//
//  Created by Евгений Фомичев on 02.07.2025.
//

import SnapKit
import UIKit

final class CoinDetailsViewController: UIViewController {
    
    // MARK: Constants
    
    private enum Constants {
        static let sixteenPadding: CGFloat = 16
    }
    
    // MARK: Internal Properties
    
    enum TimePeriod: String, CaseIterable {
        case day = "Day"
        case week = "Week"
        case year = "Year"
        case all = "All"
        case point = "Point"
        
        var segmentIndex: Int {
            switch self {
            case .day:
                0
            case .week:
                1
            case .year:
                2
            case .all:
                3
            case .point:
                4
            }
        }
        
        init?(index: Int) {
            guard index >= 0 && index < TimePeriod.allCases.count else { return nil }
            
            self = TimePeriod.allCases[index]
        }
    }
    
    var presenter: CoinDetailsPresenter?
    
    // MARK: Private Properties
    
    private static let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        formatter.decimalSeparator = "."
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        return formatter
    }()
    
    private let priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.textColor = .black
        priceLabel.font = .systemFont(ofSize: 24, weight: .bold)
        return priceLabel
    }()
    
    private let changePrice: UILabel = {
        let changePrice = UILabel()
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
    
    private let capitalizationLabel: UILabel = {
        let capitalizationLabel = UILabel()
        capitalizationLabel.font = .systemFont(ofSize: 18, weight: .light)
        capitalizationLabel.textColor = .lightGray
        capitalizationLabel.text = "Market capitalization"
        return capitalizationLabel
    }()
    
    private let circulatingSuply: UILabel = {
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
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        presenter?.setupDataSource()
    }
    
    // MARK: Actions
    
    func setSelectedPeriod(_ period: TimePeriod) {
        timePeriodControl.selectedSegmentIndex = period.segmentIndex
    }
}

// MARK: - Private Extension

private extension CoinDetailsViewController {
    
    func setupUI() {
        view.backgroundColor = Colors.coinDetailViewBackground
        view.addSubview(priceLabel)
        view.addSubview(changePrice)
        view.addSubview(timePeriodControl)
        view.addSubview(containerView)
        
        containerView.addSubview(statsStackView)
        statsStackView.addArrangedSubview(marketLabel)
        
        capitalizationRow.addArrangedSubview(capitalizationLabel)
        capitalizationRow.addArrangedSubview(capitalPriceLabel)
        statsStackView.addArrangedSubview(capitalizationRow)
        
        supplyRow.addArrangedSubview(circulatingSuply)
        supplyRow.addArrangedSubview(suplyLabel)
        statsStackView.addArrangedSubview(supplyRow)
        
        setupNavigationBar()
    }
    
    func setupConstraints() {
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(Constants.sixteenPadding)
            make.centerX.equalToSuperview()
        }
        
        changePrice.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(Constants.sixteenPadding)
            make.centerX.equalToSuperview()
        }
        
        timePeriodControl.snp.makeConstraints { make in
            make.top.equalTo(changePrice.snp.bottom).offset(Constants.sixteenPadding)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(32)
        }
        
        containerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        statsStackView.snp.makeConstraints { make in
            make.top.equalTo(containerView).offset(Constants.sixteenPadding)
            make.leading.equalTo(containerView).offset(Constants.sixteenPadding)
            make.trailing.equalTo(containerView).offset(-Constants.sixteenPadding)
            make.bottom.equalTo(containerView).offset(-Constants.sixteenPadding)
        }
        capitalizationLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        capitalPriceLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        circulatingSuply.setContentHuggingPriority(.defaultLow, for: .horizontal)
        circulatingSuply.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }
    
    func setupNavigationBar() {
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
    
    @objc
    func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    func timePeriodChanged() {
        guard let period = TimePeriod(index: timePeriodControl.selectedSegmentIndex) else { return }
        presenter?.timePeriodChanged(to: period)
    }
    
    func formatPrice(_ price: Double) -> NSAttributedString {
        let formattedPrice = Self.formatter.string(from: NSNumber(value: price)) ?? ""
        return NSAttributedString(string: "$ \(formattedPrice)")
    }
    
    func formatChangePrice(_ price: Double) -> NSAttributedString {
        let attachment = NSTextAttachment()
        if price > 0.0 {
            attachment.image = UIImage(systemName: "chevron.compact.up")?.withTintColor(.green)
        } else {
            attachment.image = UIImage(systemName: "chevron.compact.down")?.withTintColor(.red)
        }
        
        let attributedString = NSMutableAttributedString(attachment: attachment)
        let formattedPrice = Self.formatter.string(from: NSNumber(value: price)) ?? ""
        attributedString.append(NSAttributedString(string: "\(formattedPrice) %"))
        
        return attributedString
    }
    
    func configure(coinDetails: CoinData, period: TimePeriod) {
        navigationItem.title = coinDetails.name
        priceLabel.attributedText = formatPrice(coinDetails.metrics.marketData.priceUSD)
        switch period {
        case .day:
            changePrice.attributedText =  formatChangePrice(coinDetails.metrics.marketData.percentChangeUSDLast24Hours)
        case .week:
            changePrice.attributedText = formatChangePrice(coinDetails.metrics.roiData.percentChangeOneWeek)
        case .year:
            changePrice.attributedText = formatChangePrice(coinDetails.metrics.roiData.percentChangeOneMonth)
        case .all:
            changePrice.attributedText = formatChangePrice(coinDetails.metrics.roiData.percentChangeThreeMonth)
        case .point:
            changePrice.attributedText = formatChangePrice(coinDetails.metrics.roiData.percentChangeOneYear ?? 0.0)
        }
        capitalPriceLabel.text = "$ 231.233"
        suplyLabel.text = "114.211 ETH"
    }
}

// MARK: - CoinDetailsView

extension CoinDetailsViewController: CoinDetailsView {
    
    func didGet(coin: CoinData, period: TimePeriod) {
        configure(coinDetails: coin, period: period)
    }
}
