//
//  StartViewModel.swift
//  Appbooster
//
//  Created by Novgorodcev on 21/11/2024.
//

import Combine
import Foundation

protocol StartViewModelProtocol: AnyObject {
    var updateTableState: PassthroughSubject<TableState, Never> {get set}
    var user: [User]? {get set}
    var userName: String {get set}
    var gistArray: [String] {get set}
    func fetchGist()
}

final class StartViewModel: StartViewModelProtocol {
    private let networkManager = NetworkManager.shared
    
    var updateTableState = PassthroughSubject<TableState, Never>()
    var user: [User]?
    var gistArray: [String] = []
    var userName: String = ""
    
    //MARK: - fetchGist
    func fetchGist() {
        networkManager.fetchUser(userName: userName) { [weak self] result in
            switch result {
            case .success(let user):
                for index in user {
                    for (_, fileInfo) in index.files {
                        self?.fetchTextGist(url: fileInfo.rawURL)
                    }
                }
                self?.updateTableState.send(.success)
                self?.user = user
            case .failure(let error):
                self?.updateTableState.send(.failure(error))
            }
        }
    }
    
    //MARK: - fetchTextGist
    private func fetchTextGist(url: URL) {
        networkManager.fetchTextGist(url: url) { [weak self] result in
            switch result {
            case .success(let string):
                self?.gistArray.append(string)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
