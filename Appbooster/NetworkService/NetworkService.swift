//
//  NetworkService.swift
//  Appbooster
//
//  Created by Novgorodcev on 28/11/2024.
//

import Foundation
import Combine

final class NetworkService {
    static let shared = NetworkService()
    
    private init() {}
    
    //MARK: - makeRequest
    func makeRequest<T: Decodable>(request: URLRequest, completion: @escaping (Result<[T], NetworkError>) -> Void) {
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            //обработанная ошибка
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 300..<400:
                    completion(.failure(.errorWithDescription("Запрошенный ресурс перемещен в другое место.")))
                case 400..<500:
                    completion(.failure(.errorWithDescription("Запрос содержит неверный синтаксис или не может быть выполнен.")))
                case 500..<600:
                    completion(.failure(.errorWithDescription("Сервер не смог выполнить запрос.")))
                default:
                    break
                }
            }
            
            //необработанная ошибка
            if let error = error {
                completion(.failure(.errorWithDescription("Возникла непредвиденная ошибка или отсутствует соединение с интернетом")))
                print(error)
            }
            
            //обработка успешного ответа
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let decodedData = try decoder.decode([T].self, from: data)
                    
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(.errorWithDescription("\(error)")))
                }
            }
        }
        
        //отправляем запрос
        task.resume()
        
    }
    
    //MARK: - makeRequestString
    func makeRequestString(request: URLRequest,
                           completion: @escaping (Result<String, NetworkError>) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            //необработанная ошибка
            if let error = error {
                completion(.failure(.error(error)))
            }
            
            //обработанная ошибка
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 300..<400:
                    completion(.failure(.errorWithDescription("Запрошенный ресурс перемещен в другое место.")))
                case 400..<500:
                    completion(.failure(.errorWithDescription("Запрос содержит неверный синтаксис или не может быть выполнен. Проверьте правильность написания пользователя.")))
                case 500..<600:
                    completion(.failure(.errorWithDescription("Сервер не смог выполнить запрос.")))
                default:
                    break
                }
            }
            
            //обработка успешного ответа
            if let data = data {
                guard let dataString = String(data: data, encoding: .utf8) else { return }
                
                completion(.success(dataString))
            }
        }
        
        //отправляем запрос
        task.resume()
    }
    
    //MARK: - makeRequestArrayData
    func makeRequestArrayData<T>(request: [URLRequest], completion: @escaping (Result<[T], Error>) -> Void) {
        let group = DispatchGroup()
        var dataArray = [Data?](repeating: nil, count: request.count)
        // Перебираем массив URL-адресов и выполняем запросы асинхронно
        for (index, urlRequest) in request.enumerated() {
            group.enter() // Вступаем в группу операций перед каждым запросом
            
            DispatchQueue.global(qos: .userInteractive).async {
                URLSession.shared.dataTask(with: urlRequest) { (data,
                                                                response,
                                                                error) in
                    // Обработка полученного ответа
                    dataArray[index] = data
                    
                    if dataArray[dataArray.count - 1] != nil {
                        DispatchQueue.main.async {
                            completion(.success(dataArray as? [T] ?? []))
                        }
                    }
                    group.leave() // Выходим из группы операций после обработки ответа
                }.resume()
            }
            group.wait()
        }
    }
}
