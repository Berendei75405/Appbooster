//
//  GistViewModel.swift
//  Appbooster
//
//  Created by Novgorodcev on 05/12/2024.
//

import Foundation
import Combine

protocol GistViewModelProtocol: AnyObject {
    var gistInfo: [GistInfo] {get set}
    var pageNumber: Int {get set}
    var userName: String {get set}
    var updateTableState: PassthroughSubject<TableState, Never> {get set}
    func fetchGist()
    func popToRoot()
}

final class GistViewModel: GistViewModelProtocol {
    var coordinator: CoordinatorProtocol!
    private let networkManager = NetworkManager.shared
    private var cancellabele = Set<AnyCancellable>()
    var pageNumber = 2
    var updateTableState = PassthroughSubject<TableState, Never>()
    var gist: [Gist] = []
    var gistInfo: [GistInfo] = []
    var userName: String = ""
    
    //MARK: - fetchGist
    func fetchGist() {
        networkManager.fetchUser(userName: userName,
                                 pageNumber: pageNumber,
                                 perPage: 5) { [weak self] result in
            switch result {
            case .success(let gist):
                if !gist.isEmpty {
                    self?.gist = gist
                    self?.pageNumber += 1
                    self?.getUserInfo()
                }
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
    
    //MARK: - popToRoot
    func popToRoot() {
        coordinator.popToBack()
    }
    
}
