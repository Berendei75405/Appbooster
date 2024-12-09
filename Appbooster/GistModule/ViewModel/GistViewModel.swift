//
//  GistViewModel.swift
//  Appbooster
//
//  Created by Novgorodcev on 05/12/2024.
//

import Foundation
import Combine

protocol GistViewModelProtocol: AnyObject {
    var coordinator: CoordinatorProtocol! {get set}
    var updateTableState: PassthroughSubject<TableState, Never> {get set}
    var userInfo: [UserInfo] {get set}
}

final class GistViewModel: GistViewModelProtocol {
    var coordinator: CoordinatorProtocol!
    private let networkManager = NetworkManager.shared
    var updateTableState = PassthroughSubject<TableState, Never>()
    var userInfo: [UserInfo] = []
    
    private var cancellabele = Set<AnyCancellable>()
    
    
}
