//
//  LoginViewController.swift
//  Wallet
//
//  Created by Евгений Фомичев on 02.07.2025.
//

import SnapKit
import UIKit

final class LoginViewController: UIViewController {
    
    // MARK: Subtypes
    
    private enum Constants {
        static let color = UIColor.white
        static let layerRaduis: CGFloat = 16
        static let backgroundColorTextField = UIColor.white
        
        static let textFieldHeight: CGFloat = 50
        static let horizontalPadding: CGFloat = 32
        static let verticalSpacing: CGFloat = 20
    }
    
    var presenter: LoginPresenter?
    
    private let containerImage: UIImageView = {
        let containerImage = UIImageView()
        containerImage.image = UIImage(named: "LoginIcon")
        return containerImage
    }()
    
    private let userNameTextField: UITextField = {
        let userNameTextField = UITextField()
        userNameTextField.attributedPlaceholder = NSAttributedString(
            string: "UserName",
            attributes: [.foregroundColor: UIColor.lightGray]
        )
        userNameTextField.borderStyle = .roundedRect
        userNameTextField.layer.cornerRadius = Constants.layerRaduis
        userNameTextField.backgroundColor = Constants.backgroundColorTextField
        
        let userImage = UIImageView(image: UIImage(named: "user"))
        userImage.contentMode = .scaleAspectFit
        
        let imageContainer = UIView(
            frame: CGRect(
                x: 0, y: 0, width: 40, height: 30)
        )
        imageContainer.addSubview(userImage)
        userNameTextField.leftView = imageContainer
        userNameTextField.leftViewMode = .always
        return userNameTextField
    }()
    
    private let userPasswordTextField: UITextField = {
        let userPasswordTextField = UITextField()
        userPasswordTextField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [.foregroundColor: UIColor.lightGray]
        )
        userPasswordTextField.borderStyle = .roundedRect
        userPasswordTextField.layer.cornerRadius = Constants.layerRaduis
        userPasswordTextField.backgroundColor = Constants.backgroundColorTextField
        
        let passwordImage = UIImageView(image: UIImage(named: "passwordcoin") )
        passwordImage.contentMode = .scaleAspectFit
        
        let imageContainer = UIView(
            frame: CGRect(
                x: 0, y: 0, width: 40, height: 30)
        )
        imageContainer.addSubview(passwordImage)
        userPasswordTextField.leftView = imageContainer
        userPasswordTextField.leftViewMode = .always
        return userPasswordTextField
    }()
    
    private let loginButton: UIButton = {
        let loginButton = UIButton()
        loginButton.setTitle("Login", for: .normal)
        loginButton.tintColor = .white
        loginButton.backgroundColor = .black
        loginButton.layer.cornerRadius = Constants.layerRaduis
        return loginButton
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        textFieldDelegate()
        setupActions()
    }
    
    private func setupUI() {
        view.backgroundColor = .lightGray
        view.addSubview(containerImage)
        view.addSubview(userNameTextField)
        view.addSubview(userPasswordTextField)
        view.addSubview(loginButton)
    }
    
    private func setupActions() {
        print("Кнопка нажата")
        loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        containerImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(60)
            make.width.height.equalTo(120)
        }
        
        userNameTextField.snp.makeConstraints { make in
            make.top.equalTo(containerImage.snp.bottom).offset(60)
            make.leading.trailing.equalToSuperview().inset(Constants.horizontalPadding)
            make.height.equalTo(Constants.textFieldHeight)
        }
        
        userPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(userNameTextField.snp.bottom).offset(Constants.verticalSpacing)
            make.leading.trailing.equalToSuperview().inset(Constants.horizontalPadding)
            make.height.equalTo(Constants.textFieldHeight)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(userPasswordTextField.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(Constants.horizontalPadding)
            make.height.equalTo(Constants.textFieldHeight)
        }
    }
    
    private func textFieldDelegate() {
        userNameTextField.delegate = self
        userPasswordTextField.delegate = self
    }
    
    @objc
    private func handleLogin() {
        print("Кнопка нажата")
        presenter?.handleAuth(login: userNameTextField.text, password: userPasswordTextField.text)
    }
}

extension LoginViewController: LoginView {
    
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameTextField {
            userPasswordTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}
