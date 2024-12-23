//
//  NetworkManager.swift
//  Appbooster
//
//  Created by Novgorodcev on 26/11/2024.
//

import Foundation

final class NetworkManager {
    private var networkService = NetworkService.shared
    static let shared = NetworkManager()
    
    private init() {}
    
    //MARK: - fetchUser
    func fetchUser(userName: String,
                   pageNumber: Int,
                   perPage: Int,
                   completion: @escaping (Result<[Gist], NetworkError>) -> Void) {
        //url с пагинацией
        guard let url = URL(string: "https://api.github.com/users/\(userName)/gists?page=\(pageNumber)&per_page=\(perPage)") else { return completion(.failure(.errorWithDescription("Такого пользователя нет!"))) }
        
        var request = URLRequest(url: url,
                                 cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60.0)
        request.httpMethod = "GET"
        
        networkService.makeRequestArray(request: request, completion: completion)
    }
    
    //MARK: - fetchGistText
    func fetchGistText(url: URL,
                       completion: @escaping (Result<Data, NetworkError>) -> Void) {
        var request = URLRequest(url: url,
                                 cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60.0)
        request.httpMethod = "GET"
        
        networkService.makeRequest(request: request,
                                   completion: completion)
    }
    
}
