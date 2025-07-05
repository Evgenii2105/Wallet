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
        static let layerRaduis: CGFloat = 24
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
            string: "Username",
            attributes: [.foregroundColor: UIColor.lightGray]
        )
        userNameTextField.layer.cornerRadius = 24
        userNameTextField.backgroundColor = Constants.backgroundColorTextField
        
        let userImage = UIImageView(image: UIImage(named: "user"))
        userImage.contentMode = .scaleAspectFit
        
        let imageContainer = UIView(
            frame: CGRect(
                x: 0, y: 0, width: 40 + 8, height: 30)
        )
        userImage.frame = CGRect(x: 8, y: 0, width: 40, height: 30)
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
        userPasswordTextField.layer.cornerRadius = 24
        userPasswordTextField.backgroundColor = Constants.backgroundColorTextField
        
        let passwordImage = UIImageView(image: UIImage(named: "passwordcoin") )
        passwordImage.contentMode = .scaleAspectFit
        
        let imageContainer = UIView(
            frame: CGRect(
                x: 0, y: 0, width: 40 + 8, height: 30)
        )
        passwordImage.frame = CGRect(x: 8, y: 0, width: 40, height: 30)
        imageContainer.addSubview(passwordImage)
        userPasswordTextField.leftView = imageContainer
        userPasswordTextField.leftViewMode = .always
        return userPasswordTextField
    }()
    
    private let loginButton: UIButton = {
        let loginButton = UIButton()
        loginButton.setTitle("Login", for: .normal)
        loginButton.tintColor = .white
        loginButton.backgroundColor = UIColor(
            red: 26 / 255,
            green: 28 / 255,
            blue: 48 / 255,
            alpha: 1.0
        )
        loginButton.layer.cornerRadius = Constants.layerRaduis
        return loginButton
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        textFieldDelegate()
        setupActions()
        tapGesture()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor(
                    red: 243 / 255,
                    green: 245 / 255,
                    blue: 246 / 255,
                    alpha: 1.0
        )
        view.addSubview(containerImage)
        view.addSubview(userNameTextField)
        view.addSubview(userPasswordTextField)
        view.addSubview(loginButton)
    }
    
    private func setupActions() {
        loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
    }
    
    private func setupConstraints() {
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
    
    private func textFieldDelegate() {
        userNameTextField.delegate = self
        userPasswordTextField.delegate = self
    }
    
    @objc
    private func handleLogin() {
        presenter?.handleAuth(login: userNameTextField.text, password: userPasswordTextField.text)
    }
    
    private func tapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension LoginViewController: LoginView {
    func clearTextField() {
        userNameTextField.text = ""
        userPasswordTextField.text = ""
    }
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
