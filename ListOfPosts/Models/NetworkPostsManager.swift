//
//  NetworkPostsManager.swift
//  ListOfPosts
//
//  Created by Andrii Stetsenko on 20.09.2023.
//

import Foundation

struct NetworkPostsManager {
    
    var onCompletionPostsData: ((Post) -> Void)?
    var onCompletionPostDetailsData: ((PostDetails) -> Void)?
    
    func getPost() {
        let urlString = "https://raw.githubusercontent.com/anton-natife/jsons/master/api/main.json"
        getURL(string: urlString)
    }
    
    func getPost(from id: Int) {
        let urlString = "https://raw.githubusercontent.com/anton-natife/jsons/master/api/posts/\(id).json"
        getPostIdURL(string: urlString)
    }
    
    func getURL(string: String) {
        guard let url = URL(string: string) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                if let currentData = self.parsePostJSON(withData: data) {
                    self.onCompletionPostsData?(currentData)
                }
            }
        }
        task.resume()
    }
    
    func getPostIdURL(string: String) {
        guard let url = URL(string: string) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            if let data = data {
                if let currentData = self.parsePostDetailsJSON(withData: data) {
                    self.onCompletionPostDetailsData?(currentData)
                }
            }
        }
        task.resume()
    }
    
    func parsePostJSON(withData data: Data) -> Post? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        
        do {
            let decodedPostData = try decoder.decode(Post.self, from: data)
            return decodedPostData
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
    
    func parsePostDetailsJSON(withData data: Data) -> PostDetails? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        
        do {
            let decodedPostData = try decoder.decode(PostDetails.self, from: data)
            return decodedPostData
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
    
}
