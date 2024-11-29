//
//  ViewController.swift
//  Appbooster
//
//  Created by Novgorodcev on 21/11/2024.
//

import UIKit

final class StartViewController: UIViewController {
    
    var viewModel: StartViewModelProtocol?
    
    //MARK: - nameTextField
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Введите пользователя"
        
        return textField
    }()
    
    //MARK: - searchLabel
    private let searchLabel: UILabel = {
        let lab = UILabel()
        lab.translatesAutoresizingMaskIntoConstraints = false
        lab.text = "Поиск"
        lab.font = .systemFont(ofSize: 20)
        
        return lab
    }()
    
    //MARK: - searchImageView
    private let searchImageView: UIImageView = {
        let img = UIImage(systemName: "magnifyingglass")
        let imgView = UIImageView(image: img)
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.tintColor = .black
        
        return imgView
    }()
    
    //MARK: - stackView
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [searchLabel, searchImageView])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.backgroundColor = .white
        stack.layer.cornerRadius = 10
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = .init(top: .zero, left: 8, bottom: .zero, right: 8)
        stack.addGestureRecognizer(tapGesture)
        
        return stack
    }()
    
    //MARK: - tapGesture
    private lazy var tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))

    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        setupUI()
    }
    
    //MARK: - setupUI
    private func setupUI() {
        //nameTextField constraints
        view.addSubview(nameTextField)
        NSLayoutConstraint.activate([
            nameTextField.centerXAnchor.constraint(
                equalTo: view.centerXAnchor),
            nameTextField.centerYAnchor.constraint(
                equalTo: view.centerYAnchor, constant: -64),
            nameTextField.widthAnchor.constraint(
                equalToConstant: view.frame.width - 64)
        ])
        
        //stackView constraints
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(
                equalTo: nameTextField.centerYAnchor,
                constant: 62),
            stackView.centerXAnchor.constraint(
                equalTo: view.centerXAnchor),
            stackView.widthAnchor.constraint(
                equalToConstant: 100),
            stackView.heightAnchor.constraint(
                equalToConstant: 32)
        ])
    }
    
    //MARK: - handleTap
    @objc private func handleTap() {
        print("Tap!")
    }
}

