//
//  ViewController.swift
//  Appbooster
//
//  Created by Novgorodcev on 21/11/2024.
//

import UIKit
import Combine

final class StartViewController: UIViewController {
   
    var viewModel: StartViewModelProtocol?
    
    private var centerYConstraint: NSLayoutConstraint!
    private var cancellabele = Set<AnyCancellable>()
    
    //MARK: - stateRequset
    private var stateRequset: TableState = .initial {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                switch stateRequset {
                case .initial:
                    print("Initial")
                case .success:
                    activityView.isHidden = true
                    UIView.animate(withDuration: 0.8,
                                   delay: 0,
                                   options: .curveEaseInOut,
                                   animations: {
                        self.centerYConstraint.constant = self.view.frame.height * 2
                        self.view.layoutIfNeeded()
                    })
                    self.viewModel?.coordinator.showGistVC(
                        user: viewModel?.gistInfo ?? [], userName: viewModel?.userName ?? "Пользователь")
                case .failure(let error):
                    if viewModel?.error == nil {
                        viewModel?.error = error
                        activityView.isHidden = true
                        UIView.animate(withDuration: 0.8,
                                       delay: 0,
                                       options: .curveEaseInOut,
                                       animations: {
                            self.centerYConstraint.constant = 0
                            self.view.layoutIfNeeded()
                        })
                    } else {
                        viewModel?.error = nil
                        activityView.isHidden = true
                        UIView.animate(withDuration: 0.8,
                                       delay: 0,
                                       options: .curveEaseInOut,
                                       animations: {
                            self.centerYConstraint.constant = self.view.frame.height * 2
                            self.view.layoutIfNeeded()
                        })
                    }
                    switch error {
                    case .errorWithDescription(let string):
                        errorView.configurate(textError: string)
                    case .error(let error):
                        errorView.configurate(textError: error.localizedDescription)
                    }
                }
            }
        }
    }
    
    //MARK: - activityView
    private var activityView: UIActivityIndicatorView = {
        var progres = UIActivityIndicatorView(style: .large)
        progres.translatesAutoresizingMaskIntoConstraints = false
        progres.startAnimating()
        progres.color = .black
        progres.isHidden = true
        
        return progres
    }()

    
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
        stack.insetsLayoutMarginsFromSafeArea = false
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = .init(top: .zero, left: 8, bottom: .zero, right: 8)
        stack.addGestureRecognizer(tapGesture)
        
        return stack
    }()
    
    //MARK: - ErrorView
    private lazy var errorView: ErrorView = {
        let error = ErrorView(frame: .init(x: .zero, y: .zero,
                                           width: view.frame.width - 64,
                                           height: view.frame.height / 2))
        error.translatesAutoresizingMaskIntoConstraints = false
        error.delegate = self
        
        return error
    }()
    
    //MARK: - tapGesture
    private lazy var tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))

    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        updateState()
        setupUI()
    }
    
    //MARK: - setupUI
    private func setupUI() {
        //nameTextField constraints
        view.addSubview(nameTextField)
        NSLayoutConstraint.activate([
//            nameTextField.centerXAnchor.constraint(
//                equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            nameTextField.centerYAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -64),
            nameTextField.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                constant: 32),
            nameTextField.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -32)
        ])
        
        //stackView constraints
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(
                equalTo: nameTextField.centerYAnchor,
                constant: 62),
            stackView.heightAnchor.constraint(
                equalToConstant: 32),
            stackView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 128),
            stackView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -128)
        ])
        
        //errorView
        view.addSubview(errorView)
        centerYConstraint = errorView.centerYAnchor.constraint(
            equalTo: view.centerYAnchor, constant: view.frame.height * 2)
        NSLayoutConstraint.activate([
            centerYConstraint,
            errorView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 32),
            errorView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -32),
            errorView.heightAnchor.constraint(
                equalToConstant: view.frame.height / 2)
        ])
        
        //activityView
        view.addSubview(activityView)
        NSLayoutConstraint.activate([
            activityView.centerXAnchor.constraint(
                equalTo: view.centerXAnchor),
            activityView.centerYAnchor.constraint(
                equalTo: view.centerYAnchor),
            activityView.heightAnchor.constraint(
                equalToConstant: 100),
            activityView.widthAnchor.constraint(
                equalToConstant: 100)
        ])
    }
    
    //MARK: - updateState
    private func updateState() {
        viewModel?.updateTableState.sink(receiveValue: { [unowned self] state in
            self.stateRequset = state
        }).store(in: &cancellabele)
    }
    
    //MARK: - handleTap
    @objc private func handleTap() {
        activityView.isHidden = false
        viewModel?.userName = nameTextField.text ?? ""
        viewModel?.fetchGist()
    }
}

extension StartViewController: ErrorViewDelegate {
    //обновление экрана при закрытии errorView
    func update() {
        activityView.isHidden = false
        stateRequset = .failure(viewModel?.error ?? NetworkError.errorWithDescription(""))
    }
}

