//
//  PostDetails.swift
//  ListOfPosts
//
//  Created by Andrii Stetsenko on 20.09.2023.
//

import Foundation

// MARK: - PostDetails
struct PostDetails: Codable {
    let post: CurrentPost
}

// MARK: - Post
struct CurrentPost: Codable {
    let postID: Int
    let timeshamp: Date
    let title, text: String
    let postImage: String
    let likesCount: Int

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case timeshamp, title, text
        case postImage = "postImage"
        case likesCount = "likes_count"
    }
}
