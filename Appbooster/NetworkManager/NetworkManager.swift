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
                   completion: @escaping (Result<[User], NetworkError>) -> Void) {
        guard let url = URL(string: "https://api.github.com/users/Berendei75405/gists") else { return }
        
        var request = URLRequest(url: url,
                                 cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60.0)
        request.httpMethod = "GET"
        
        networkService.makeRequest(request: request, completion: completion)
    }
    
    //MARK: - fetch
    func fetchTextGist(url: URL, completion: @escaping (Result<String, NetworkError>) -> Void) {
        var request = URLRequest(url: url,
                                 cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60.0)
        request.httpMethod = "GET"
        
        networkService.makeRequestString(request: request, completion: completion)
    }
}
