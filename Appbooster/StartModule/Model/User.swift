//
//  User.swift
//  Appbooster
//
//  Created by Novgorodcev on 26/11/2024.
//

import Foundation

//MARK: - User
struct User: Codable {
    let files: FilesDict
    let createdAt, updatedAt: Date
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case files, description
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

//MARK: - FileInfo
struct FileInfo: Codable {
    let fileName: String
    let rawURL: URL
    
    enum CodingKeys: String, CodingKey {
        case fileName = "filename"
        case rawURL = "raw_url"
    }
}

typealias FilesDict = [String: FileInfo]

//MARK: - UserInfo
struct UserInfo {
    let files: File
    let createdAt, updatedAt: String
    let description: String
    
    struct File {
        let fileName: String
        let rawURL: URL
        let gist: String
    }
}
