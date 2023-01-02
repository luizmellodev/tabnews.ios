//
//  ListViewModel.swift
//  tabnewsios
//
//  Created by Luiz Eduardo Mello dos Reis on 31/12/22.
//

import Foundation
import SwiftUI

class ListViewModel: ObservableObject {
    let defaults = UserDefaults.standard
    @Published var connectivityManager = WatchConnectivityManager.shared
    @Published var recentContentList: [ContentModel] = []
    @Published var relevantContentList: [ContentModel] = []
    @Published var likedList: [ContentModel] = []
    @Published var bodyText: String = ""
    
    init() {
        readFile()
        getContentDetailJSON()
        //        getRecentContent()
        //        getRelevantContent()
    }
    
    func saveInAppSettings(viewInApp: Bool) {
        defaults.bool(forKey: "viewInApp")
    }
    
    
    func likeContentList(content: ContentModel) {
        self.likedList.append(content)
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(likedList) {
            defaults.set(encoded, forKey: "LikedContent")
        }
    }
    
    func removeContentList(content: ContentModel) {
        self.likedList.removeAll(where: { $0.title == content.title })
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(likedList) {
            defaults.set(encoded, forKey: "LikedContent")
        }
    }
    
    func getLikedContent() {
        if let likedContent = defaults.object(forKey: "LikedContent") as? Data {
            let decoder = JSONDecoder()
            if let loadedContent = try? decoder.decode([ContentModel].self, from: likedContent) {
                self.likedList = loadedContent
                if let contentTitle = connectivityManager.notificationMessage?.title {
                    likeConnectivityContent(title: contentTitle)
                }
            }
        }
    }
    
    func getContentDetailJSON() {
        if let url = Bundle.main.url(forResource: "markdown", withExtension: "json"),
           let data = try? Data(contentsOf: url) {
            let decoder = JSONDecoder()
            if let jsonData = try? decoder.decode(ContentModelDetails.self, from: data) {
                self.bodyText = jsonData.content
            }
        }
    }
    func likeConnectivityContent(title: String) {
        for oneContent in self.relevantContentList {
            if oneContent.title == title {
                self.likedList.append(oneContent)
            }
        }
    }
    func readFile() {
        if let url = Bundle.main.url(forResource: "contents", withExtension: "json"),
           let data = try? Data(contentsOf: url) {
            let decoder = JSONDecoder()
            if let jsonData = try? decoder.decode([ContentModel].self, from: data) {
                self.recentContentList = jsonData
                self.relevantContentList = jsonData
            }
        }
    }
    
    func getRecentContent() {
        Task {
            do {
                let requestApi = try await ApiRequest.fetchContentRecent()
                DispatchQueue.main.async {
                    self.recentContentList = requestApi
                }
            } catch {
                print(error)
            }
        }
    }
    
    func getRelevantContent() {
        Task {
            do {
                let requestApi = try await ApiRequest.fetchContentRelevant()
                DispatchQueue.main.async {
                    self.relevantContentList = requestApi
                }
            } catch {
                print(error)
            }
        }
    }
    
    func getContentDetail(username: String, slug: String) {
        Task {
            do {
                let requestDetail = try await ApiRequest.getContentDetails(username: username, slug: slug)
                DispatchQueue.main.async {
                    self.bodyText = requestDetail.content
                }
            } catch {
                print(error)
            }
        }
    }
}
