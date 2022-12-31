//
//  ApiRequest.swift
//  tabnewsios
//
//  Created by Luiz Eduardo Mello dos Reis on 31/12/22.
//

import Foundation

class ApiRequest {
    
    
    static func fetchContentRecent() async throws -> [ContentModel] {
        guard let url = URL(string: "https://www.tabnews.com.br/api/v1/contents?page=1&per_page=15&strategy=new") else { return [] }
        let request = URLRequest(url: url)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let response = try JSONDecoder().decode([ContentModel].self, from: data)
        return response
    }
    
    static func fetchContentRelevant() async throws -> [ContentModel] {
        guard let url = URL(string: "https://www.tabnews.com.br/api/v1/contents?page=1&per_page=15&strategy=relevant") else { return [] }
        let request = URLRequest(url: url)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let response = try JSONDecoder().decode([ContentModel].self, from: data)
        return response
    }
    
    static func getContentDetails(username: String, slug: String) async throws -> ContentModelDetails {
        guard let url = URL(string: "https://www.tabnews.com.br/api/v1/contents/\(username)/\(slug)") else { return ContentModelDetails(content: "erro") }
        let request = URLRequest(url: url)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let response = try JSONDecoder().decode(ContentModelDetails.self, from: data)
        return response
    }
}
