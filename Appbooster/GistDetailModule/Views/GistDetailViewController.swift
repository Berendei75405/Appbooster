//
//  GistDetailViewController.swift
//  Appbooster
//
//  Created by Novgorodcev on 22/12/2024.
//

import UIKit
import Combine

final class GistDetailViewController: UIViewController {
    
    var viewModel: GistDetailViewModelProtocol?
    
    //MARK: - tableView
    private lazy var tableView: UITableView = {
        var table  = UITableView(frame: .zero, style: .plain)
        
        table.backgroundColor = UIColor(named: "backgroundColor")
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        table.backgroundColor = .white
        
        table.delegate = self
        table.dataSource = self
        
        //регистрация ячеек
        table.register(GistDetailTableCell.self,
                       forCellReuseIdentifier: GistDetailTableCell.identifier)
        
        return table
    }()
    
    //MARK: - tableState
    private var tableState: TableState = .initial {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                switch tableState {
                case .initial:
                    print("Initial")
                case .success:
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    private var cancellabele = Set<AnyCancellable>()
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        updateState()
        viewModel?.fetchGistText()
    }
    
    //MARK: - setupUI
    private func setupUI() {
        self.navigationItem.setLeftBarButton(UIBarButtonItem(title: "Назад",
                                                             style: .plain,
                                                             target: self,
                                                             action: #selector(popToBack)), animated: true)
        self.navigationItem.leftBarButtonItem?.tintColor = .black
        self.title = "\(viewModel?.gistInfo.files.fileName ?? "")"
        //table constraints
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor
                .constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor
                .constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor
                .constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor
                .constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    //MARK: - updateState
    private func updateState() {
        viewModel?.updateTableState.sink(receiveValue: { [unowned self] state in
            self.tableState = state
        }).store(in: &cancellabele)
    }
    
    //MARK: - returnHeightContent
    private func calculateTextHeight(text: String,
                                     width: CGFloat,
                                     font: UIFont) -> CGFloat {
        let label = UILabel(frame: CGRect(x: 0,
                                          y: 0,
                                          width: width,
                                          height: .greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = font
        label.text = text
        
        label.sizeToFit()
        
        return label.frame.height
    }
    
    //MARK: - popToBack
    @objc private func popToBack() {
        viewModel?.popToRoot()
    }
}

extension GistDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GistDetailTableCell.identifier, for: indexPath) as? GistDetailTableCell else { return UITableViewCell() }
        
        cell.config(title: viewModel?.gistInfo.files.fileName ?? "",
                    description: viewModel?.gistInfo.description ?? "",
                    gistText: viewModel?.gistText ?? "",
                    createdAt: viewModel?.gistInfo.createdAt ?? "",
                    updatedAt: viewModel?.gistInfo.updatedAt ?? "")
        cell.isSelected = false
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let title = calculateTextHeight(text: viewModel?.gistInfo.files.fileName ?? "",
                                        width: view.frame.width - 32,
                                        font: .boldSystemFont(ofSize: 22))
        let descriptionTitle = calculateTextHeight(text: "Описание файла:",
                                                   width: view.frame.width - 32,
                                                   font: .boldSystemFont(ofSize: 22))
        let description = calculateTextHeight(text: viewModel?.gistInfo.description ?? "",
                                              width: view.frame.width - 32,
                                              font: .systemFont(ofSize: 20))
        let gistTextTitle = calculateTextHeight(text: "Содержание файла:",
                                                width: view.frame.width - 32,
                                                font: .boldSystemFont(ofSize: 22))
        
        let gistText = calculateTextHeight(text: viewModel?.gistText ?? "",
                                           width: view.frame.width - 32,
                                           font: .systemFont(ofSize: 20))
        
        let createdAtTitle = calculateTextHeight(text: "Создан:",
                                               width: view.frame.width - 32,
                                               font: .boldSystemFont(ofSize: 22))
        
        let createdAt = calculateTextHeight(text: viewModel?.gistInfo.createdAt ?? "",
                                            width: view.frame.width - 32,
                                            font: .systemFont(ofSize: 20))
        
        let updatedAtTitle = calculateTextHeight(text: "Обновлен:",
                                               width: view.frame.width - 32,
                                               font: .boldSystemFont(ofSize: 22))
        
        let updatedAt = calculateTextHeight(text: viewModel?.gistInfo.updatedAt ?? "",
                                            width: view.frame.width - 32,
                                            font: .systemFont(ofSize: 20))
        
        return title + 8 + descriptionTitle + 16
        + description + 8 + gistTextTitle + 16
        + gistText + 8 + 8 + createdAtTitle + 16 + createdAt + 8 + updatedAtTitle + 16 + updatedAt + 8
    }
}

