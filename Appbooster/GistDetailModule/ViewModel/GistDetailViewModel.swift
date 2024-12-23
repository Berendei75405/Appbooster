//
//  GistDetailViewModel.swift
//  Appbooster
//
//  Created by Novgorodcev on 22/12/2024.
//

import Foundation
import Combine

protocol GistDetailViewModelProtocol: AnyObject {
    var coordinator: CoordinatorProtocol! {get set}
    var updateTableState: PassthroughSubject<TableState, Never> {get set}
    var gistInfo: GistInfo! {get set}
    var gistText: String {get set}
    func fetchGistText()
    func popToRoot()
}

final class GistDetailViewModel: GistDetailViewModelProtocol {
    var coordinator: CoordinatorProtocol!
    var gistInfo: GistInfo!
    var gistText = ""
    private let networkManager = NetworkManager.shared
    var updateTableState = PassthroughSubject<TableState, Never>()
    
    private var cancellabele = Set<AnyCancellable>()
    
    //MARK: - fetchGistText
    func fetchGistText() {
        networkManager.fetchGistText(url: gistInfo.files.rawURL) { [weak self] result in
            switch result {
            case .success(let dataString):
                guard let str = String(data: dataString, encoding: .utf8) else { return }
                self?.gistText = str
                self?.updateTableState.send(.success)
            case .failure(let error):
                print(error)
                self?.updateTableState.send(.failure(error))
            }
        }
    }
    
    //MARK: - popToRoot
    func popToRoot() {
        coordinator.popToBack()
    }
    
}
