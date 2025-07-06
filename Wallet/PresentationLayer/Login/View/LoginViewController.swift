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
    }
}

// MARK: - Private Extension

private extension LoginViewController {
    func setupUI() {
        view.backgroundColor = Colors.loginBackground
        view.addSubview(containerImage)
        view.addSubview(userNameTextField)
        view.addSubview(userPasswordTextField)
        view.addSubview(loginButton)
    }
    
    func setupActions() {
        loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
    }
    
    func setupConstraints() {
        containerImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(-20)
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

//private extension LoginViewController {
//
//    func setupNotifications() {
//        NotificationCenter.default.addObserver(self,
//                                               selector: #selector(keyboardWillShow),
//                                               name: UIResponder.keyboardWillShowNotification,
//                                               object: nil)
//        NotificationCenter.default.addObserver(self,
//                                               selector: #selector(keyboardWillHide),
//                                               name: UIResponder.keyboardWillHideNotification,
//                                               object: nil)
//    }
//
//    @objc
//    func keyboardWillShow(notification: NSNotification) {
//        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
//            return
//        }
//
//        let keyboardHeight = keyboardSize.height
//        var contentInset = scrollView.contentInset
//        contentInset.bottom = keyboardHeight
//        scrollView.contentInset = contentInset
//        scrollView.scrollIndicatorInsets = scrollView.contentInset
//    }
//
//    @objc
//    func keyboardWillHide(notification: NSNotification) {
//        scrollView.contentInset = UIEdgeInsets.zero
//        scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
//    }
//}
