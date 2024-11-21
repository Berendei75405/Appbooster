//
//  StartViewModel.swift
//  Appbooster
//
//  Created by Novgorodcev on 21/11/2024.
//

import Combine

protocol StartViewModelProtocol: AnyObject {
    var updateTableState: PassthroughSubject<TableState, Never> {get set}
}

final class StartViewModel: StartViewModelProtocol {
    
    var updateTableState = PassthroughSubject<TableState, Never>()
    
    
    
}
