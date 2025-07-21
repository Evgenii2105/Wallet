//
//  LoginViewController.swift
//  Wallet
//
//  Created by Евгений Фомичев on 02.07.2025.
//

import SnapKit
import UIKit

final class LoginViewController: UIViewController {
    
    // MARK: Constants
    
    private enum Constants {
        static let color = UIColor.white
        static let layerRadius: CGFloat = 24
        static let backgroundColorTextField = UIColor.white
        static let textFieldHeight: CGFloat = 50
        static let leadingPadding: CGFloat = 8
        static let horizontalPadding: CGFloat = 32
        static let verticalSpacing: CGFloat = 20
        static let width: CGFloat = 40
        static let height: CGFloat = 30
    }
    
    // MARK: Internal Properties
    
    var presenter: LoginPresenter?
    
    // MARK: Private Properties
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        return scrollView
    }()
    
    private let containerView: UIView = {
        let containerView = UIView()
        return containerView
    }()
    
    private let containerImage: UIImageView = {
        let containerImage = UIImageView()
        containerImage.image = UIImage(named: "LoginIcon")
        return containerImage
    }()
    
    private let userNameTextField: UITextField = {
        let userNameTextField = UITextField()
        userNameTextField.attributedPlaceholder = NSAttributedString(
            string: "Username",
            attributes: [.foregroundColor: UIColor.lightGray]
        )
        userNameTextField.layer.cornerRadius = Constants.layerRadius
        userNameTextField.backgroundColor = Constants.backgroundColorTextField
        
        let userImage = UIImageView(image: UIImage(named: "user"))
        userImage.contentMode = .scaleAspectFit
        
        let imageContainer = UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: Constants.width + Constants.leadingPadding,
                height: Constants.height
            )
        )
        userImage.frame = CGRect(
            x: Constants.leadingPadding,
            y: 0,
            width: Constants.width,
            height: Constants.height
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
        userPasswordTextField.layer.cornerRadius = Constants.layerRadius
        userPasswordTextField.isSecureTextEntry = true
        userPasswordTextField.backgroundColor = Constants.backgroundColorTextField
        
        let passwordImage = UIImageView(image: UIImage(named: "passwordcoin") )
        passwordImage.contentMode = .scaleAspectFit
        
        let imageContainer = UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: Constants.width + Constants.leadingPadding,
                height: Constants.height
            )
        )
        passwordImage.frame = CGRect(
            x: Constants.leadingPadding,
            y: 0,
            width: Constants.width,
            height: Constants.height
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
        loginButton.titleLabel?.font = Fonts.loginButtonFont
        loginButton.backgroundColor = Colors.loginButtonBackground
        loginButton.layer.cornerRadius = Constants.layerRadius
        return loginButton
    }()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        textFieldDelegate()
        setupActions()
        setupDissmisKeyboardGesture()
        setupNotifications()
    }
}

// MARK: - Private Extension

private extension LoginViewController {
    
    func setupUI() {
        view.backgroundColor = Colors.loginBackground
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(containerImage)
        containerView.addSubview(userNameTextField)
        containerView.addSubview(userPasswordTextField)
        containerView.addSubview(loginButton)
    }
    
    func setupActions() {
        loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
    }
    
    func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView.snp.width)
        }
        
        containerImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(containerView.snp.top).offset(60)
            make.width.height.equalTo(280)
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
            make.bottom.equalTo(containerView.snp.bottom).offset(-40)
        }
    }
    
    func textFieldDelegate() {
        userNameTextField.delegate = self
        userPasswordTextField.delegate = self
    }
    
    @objc
    func handleLogin() {
        presenter?.handleAuth(login: userNameTextField.text, password: userPasswordTextField.text)
    }
    
    func setupDissmisKeyboardGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func setupNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc
    func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        let keyboardHeight = keyboardSize.height
        var contentInset = scrollView.contentInset
        contentInset.bottom = keyboardHeight
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = scrollView.contentInset
    }
    
    @objc
    func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset = UIEdgeInsets.zero
        scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
    }
}

// MARK: - LoginView

extension LoginViewController: LoginView {
    func clearTextField() {
        userNameTextField.text = ""
        userPasswordTextField.text = ""
    }
}

// MARK: - UITextFieldDelegate

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
