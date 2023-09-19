//
//  Post.swift
//  ListOfPosts
//
//  Created by Andrii Stetsenko on 20.09.2023.
//

import Foundation

// MARK: - Post
struct Post: Codable {
    let posts: [PostElement]
}

// MARK: - PostElement
struct PostElement: Codable {
    let postID: Int
    let timeshamp: Date
    let title, previewText: String
    let likesCount: Int
    
    var expanded: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case timeshamp, title
        case previewText = "preview_text"
        case likesCount = "likes_count"
    }
}
