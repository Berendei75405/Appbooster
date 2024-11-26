//
//  Enums.swift
//  Appbooster
//
//  Created by Novgorodcev on 21/11/2024.
//

import Foundation

//Для состояния таблицы
enum TableState {
    case success, failure(NetworkError), initial
}

//MARK: - NetworkError
enum NetworkError: Error {
    case errorWithDescription(String)
    case error(Error)
}
