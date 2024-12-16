//
//  UserInfo.swift
//  Appbooster
//
//  Created by Novgorodcev on 10/12/2024.
//

import Foundation

//MARK: - GistInfo
struct GistInfo {
    let files: File
    let createdAt, updatedAt: String
    let description: String
    
    struct File {
        let fileName: String
        let rawURL: URL
    }
}
