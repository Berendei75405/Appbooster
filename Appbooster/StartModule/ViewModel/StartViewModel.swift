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
    var userInfo: [UserInfo] {get set}
    var userName: String {get set}
    func fetchGist()
}

final class StartViewModel: StartViewModelProtocol {
    private let networkManager = NetworkManager.shared
    
    var coordinator: CoordinatorProtocol!
    
    var updateTableState = PassthroughSubject<TableState, Never>()
    var userInfo: [UserInfo] = []
    var user: [User] = []
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
                if self?.gistArray.count == self?.user.count {
                    self?.createUserInfo()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    //MARK: - createUserInfo
    ///Эта функция предназначена для того чтобы из модели user, получить более удобную модель данных для нашего использования
    ///
    private func createUserInfo()  {
        for index in 0..<user.count {
            let user = user[index]
            for (_, fileInfo) in user.files {
                let formatter = DateFormatter()
                formatter.dateFormat = "HH:mm:ss dd.MM.yyyy"

                let userInfo = UserInfo(files: .init(fileName: fileInfo.fileName,
                                                     rawURL: fileInfo.rawURL,
                                                     gist: gistArray[index]),
                                        createdAt: formatter.string(from: user.createdAt),
                                        updatedAt: formatter.string(from: user.updatedAt),
                                        description: user.description)
                self.userInfo.append(userInfo)
            }
        }
        self.updateTableState.send(.success)
    }
    
}
