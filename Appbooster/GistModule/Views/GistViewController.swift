//
//  GistViewController.swift
//  Appbooster
//
//  Created by Novgorodcev on 05/12/2024.
//

import UIKit

final class GistViewController: UIViewController {
    
    var viewModel: GistViewModelProtocol?
    
//    //MARK: - tableView
//    private var tableView: UITableView = {
//        var table  = UITableView(frame: .zero, style: .plain)
//        
//        table.backgroundColor = UIColor(named: "backgroundColor")
//        table.translatesAutoresizingMaskIntoConstraints = false
//        table.separatorStyle = .none
//        table.showsVerticalScrollIndicator = false
//        
//        //регистрация ячеек
//        table.register(GistTableViewCell.self, forCellReuseIdentifier: GistTableViewCell.identifier)
//        
//        return table
//    }()
    
//    //MARK: - stateRequset
//    private var stateRequset: TableState = .initial {
//        didSet {
//            DispatchQueue.main.async { [weak self] in
//                guard let self = self else { return }
//                switch stateRequset {
//                case .initial:
//                    print("Initial")
//                case .success:
//                    //                    activityView.isHidden = true
//                    //                    UIView.animate(withDuration: 0.8,
//                    //                                   delay: 0,
//                    //                                   options: .curveEaseInOut,
//                    //                                   animations: {
//                    //                        self.centerYConstraint.constant = self.view.frame.height * 2
//                    //                        self.view.layoutIfNeeded()
//                    //                    })
//                    
//                case .failure(let error):
//                    //                    activityView.isHidden = true
//                    //                    UIView.animate(withDuration: 0.8,
//                    //                                   delay: 0,
//                    //                                   options: .curveEaseInOut,
//                    //                                   animations: {
//                    //                        self.centerYConstraint.constant = 0
//                    //                        self.view.layoutIfNeeded()
//                    //                    })
//                    
//                    switch error {
//                    case .errorWithDescription(let string):
//                        // errorView.configurate(textError: string)
//                    case .error(let error):
//                        // errorView.configurate(textError: error.localizedDescription)
//                    }
//                }
//            }
//        }
//    }
    
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        //setupUI()
    }
    
    //MARK: - setupUI
    private func setupUI() {
//        //table constraints
//        view.addSubview(tableView)
//        NSLayoutConstraint.activate([
//            tableView.topAnchor
//                .constraint(equalTo: view.topAnchor),
//            tableView.leadingAnchor
//                .constraint(equalTo: view.leadingAnchor),
//            tableView.trailingAnchor
//                .constraint(equalTo: view.trailingAnchor),
//            tableView.bottomAnchor
//                .constraint(equalTo: view.bottomAnchor)
//        ])
    }
    
}

//extension GistViewController: UITableViewDelegate, UITableViewDataSource {
//    
//}

