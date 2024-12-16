//
//  GistViewController.swift
//  Appbooster
//
//  Created by Novgorodcev on 05/12/2024.
//

import UIKit
import Combine

final class GistViewController: UIViewController {
    
    var viewModel: GistViewModelProtocol?
    
    //MARK: - tableView
    private lazy var tableView: UITableView = {
        var table  = UITableView(frame: .zero, style: .plain)
        
        table.backgroundColor = UIColor(named: "backgroundColor")
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        
        table.delegate = self
        table.dataSource = self
        
        //регистрация ячеек
        table.register(GistTableViewCell.self, forCellReuseIdentifier: GistTableViewCell.identifier)
        
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
    
    //MARK: - updateState
    private func updateState() {
        viewModel?.updateTableState.sink(receiveValue: { [unowned self] state in
            self.tableState = state
        }).store(in: &cancellabele)
    }
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.setLeftBarButton(UIBarButtonItem(title: "Назад",
                                                             style: .plain,
                                                             target: self,
                                                             action: #selector(popToBack)), animated: true)
        self.title = "\(viewModel?.userName ?? "Пользовательские") Gist"
        setupUI()
        updateState()
    }
    
    //MARK: - setupUI
    private func setupUI() {
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

extension GistViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.gistInfo.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: GistTableViewCell.identifier,
            for: indexPath) as? GistTableViewCell else { return UITableViewCell() }
        
        cell.config(title: viewModel?.gistInfo[indexPath.row].files.fileName ?? "",
                    description: viewModel?.gistInfo[indexPath.row].description ?? "")
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let description = calculateTextHeight(text: viewModel?.gistInfo[indexPath.row].description ?? "",
                                             width: view.frame.width - 32,
                                             font: .systemFont(ofSize: 20))
        let title = calculateTextHeight(text: viewModel?.gistInfo[indexPath.row].files.fileName ?? "",
                                        width: view.frame.width - 32,
                                        font: .boldSystemFont(ofSize: 22))
        let padding: CGFloat = 40
        
        return title + description + padding
    }
    
    //проверяем достигли ли мы последней ячейки чтобы отправить запрос на новые
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let array = viewModel?.gistInfo.count else { return }
        if indexPath.row == array - 1 {
            viewModel?.fetchGist()
        }
    }
}

