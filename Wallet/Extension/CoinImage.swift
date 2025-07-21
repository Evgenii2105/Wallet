//
//  CoinImage.swift
//  Wallet
//
//  Created by Евгений Фомичев on 09.07.2025.
//

import UIKit

enum CoinImage: String {
    case btc = "BTC"
    case eth = "ETH"
    case usdt = "USDT"
    case xrp = "XRP"
    case bnb = "BNB"
    case sol = "SOL"
    case usdc = "USDC"
    case trx = "TRX"
    case doge = "DOGE"
    case steth = "stETH"
    case ada = "ADA"
    case wbtc = "WBTC"
    case hype = "HYPE"
    case sui = "SUI"
    case bch = "BCH"
    case wsteth = "WSTETH"
    case link = "LINK"
    case weth = "WETH"
    case xlm = "XLM"
    case leo = "LEO"
    case wagmi = "wagmi"
    case hedera = "HBAR"
    
    var image: UIImage {
        switch self {
        case .btc:
            return UIImage(systemName: "bitcoinsign.circle")!.withTintColor(color, renderingMode: .alwaysOriginal)
        case .eth:
            return UIImage(systemName: "cedisign.circle")!.withTintColor(color, renderingMode: .alwaysOriginal)
        case .usdt:
            return UIImage(systemName: "chineseyuanrenminbisign.circle")!.withTintColor(color, renderingMode: .alwaysOriginal)
        case .xrp:
            return UIImage(systemName: "coloncurrencysign.circle")!.withTintColor(color, renderingMode: .alwaysOriginal)
        case .bnb:
            return UIImage(systemName: "australsign.circle")!.withTintColor(color, renderingMode: .alwaysOriginal)
        case .sol:
            return UIImage(systemName: "australiandollarsign.circle")!.withTintColor(color, renderingMode: .alwaysOriginal)
        case .usdc:
            return UIImage(systemName: "brazilianrealsign.circle")!.withTintColor(color, renderingMode: .alwaysOriginal)
        case .trx:
            return UIImage(systemName: "cruzeirosign.circle")!.withTintColor(color, renderingMode: .alwaysOriginal)
        case .doge:
            return UIImage(systemName: "danishkronesign.circle")!.withTintColor(color, renderingMode: .alwaysOriginal)
        case .steth:
            return UIImage(systemName: "dongsign.circle")!.withTintColor(color, renderingMode: .alwaysOriginal)
        case .ada:
            return UIImage(systemName: "dollarsign.circle")!.withTintColor(color, renderingMode: .alwaysOriginal)
        case .wbtc:
            return UIImage(systemName: "eurosign.circle")!.withTintColor(color, renderingMode: .alwaysOriginal)
        case .hype:
            return UIImage(systemName: "eurozonesign.circle")!.withTintColor(color, renderingMode: .alwaysOriginal)
        case .sui:
            return UIImage(systemName: "florinsign.circle")!.withTintColor(color, renderingMode: .alwaysOriginal)
        case .bch:
            return UIImage(systemName: "francsign.circle")!.withTintColor(color, renderingMode: .alwaysOriginal)
        case .wsteth:
            return UIImage(systemName: "guaranisign.circle")!.withTintColor(color, renderingMode: .alwaysOriginal)
        case .link:
            return UIImage(systemName: "hryvniasign.circle")!.withTintColor(color, renderingMode: .alwaysOriginal)
        case .weth:
            return UIImage(systemName: "indianrupeesign.circle")!.withTintColor(color, renderingMode: .alwaysOriginal)
        case .xlm:
            return UIImage(systemName: "kipsign.circle")!.withTintColor(color, renderingMode: .alwaysOriginal)
        case .leo:
            return UIImage(systemName: "larisign.circle")!.withTintColor(color, renderingMode: .alwaysOriginal)
        case .wagmi:
            return UIImage(systemName: "francsign.circle")!.withTintColor(color, renderingMode: .alwaysOriginal)
        case .hedera:
            return UIImage(systemName: "dollarsign.circle")!.withTintColor(color, renderingMode: .alwaysOriginal)
        }
    }
    
    private var color: UIColor {
        switch self {
        case .btc:
            return .gray
        case .eth:
            return .red
        case .usdt:
            return .darkGray
        case .xrp:
            return .orange
        case .bnb:
            return .link
        case .sol:
            return .purple
        case .usdc:
            return .blue
        case .trx:
            return .black
        case .doge:
            return .red
        case .steth:
            return .red
        case .ada:
            return .yellow
        case .wbtc:
            return .green
        case .hype:
            return .gray
        case .sui:
            return .darkGray
        case .bch:
            return .magenta
        case .wsteth:
            return .systemBrown
        case .link:
            return .systemMint
        case .weth:
            return .systemCyan
        case .xlm:
            return .systemTeal
        case .leo:
            return .systemIndigo
        case .wagmi:
            return .lightGray
        case .hedera:
            return .orange
        }
    }
}
