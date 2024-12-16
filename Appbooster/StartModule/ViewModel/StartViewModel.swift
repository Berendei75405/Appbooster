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
    var coordinator: CoordinatorProtocol! {get set}
    var gistInfo: [GistInfo] {get set}
    var userName: String {get set}
    func fetchGist()
}

final class StartViewModel: StartViewModelProtocol {
    private let networkManager = NetworkManager.shared
    
    var coordinator: CoordinatorProtocol!
    
    var updateTableState = PassthroughSubject<TableState, Never>()
    var gist: [Gist] = []
    var gistInfo: [GistInfo] = []
    var userName: String = ""
    
    //MARK: - fetchGist
    func fetchGist() {
        networkManager.fetchUser(userName: userName,
                                 pageNumber: 1,
                                 perPage: 5) { [weak self] result in
            switch result {
            case .success(let gist):
                self?.gist = gist
                self?.getUserInfo()
            case .failure(let error):
                self?.updateTableState.send(.failure(error))
            }
        }
    }
    
    //MARK: - getUserInfo
    private func getUserInfo() {
        for item in gist {
            for (_, userInfo) in item.files {
                let formatter = DateFormatter()
                formatter.dateFormat = "HH:mm:ss dd.MM.yyyy"
                
                let userInfo = GistInfo(files: .init(fileName: userInfo.fileName,
                                                     rawURL: userInfo.rawURL),
                                        createdAt: formatter.string(from: item.createdAt),
                                        updatedAt: formatter.string(from: item.updatedAt),
                                        description: item.description)
                self.gistInfo.append(userInfo)
            }
        }
        self.updateTableState.send(.success)
    }
    
}
