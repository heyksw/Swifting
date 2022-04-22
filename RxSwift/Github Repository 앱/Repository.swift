//
//  Repository.swift
//  GitHubRepository
//
//  Created by 김상우 on 2022/04/21.
//

import Foundation

struct Repository: Decodable {
    let id: Int
    let name: String
    let description: String
    let stargazerCount: Int
    let language: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, description, language
        case stargazerCount = "stargazers_count"
    }
}
