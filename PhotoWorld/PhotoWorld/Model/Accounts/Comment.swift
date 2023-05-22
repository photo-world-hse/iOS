//
//  Comment.swift
//  PhotoWorld
//
//  Created by Stepan Ostapenko on 16.05.2023.
//

import Foundation

struct CommentCretionInfo: Codable {
    var text: String
    var grade: Int
    var is_anonymous: Bool
    var photos: [URL]
    var writer_profile_type: ProfileType
}

struct CommentInfo: Codable {
    var writer_name: String
    var writer_avatar: String?
    var grade: Int
    var date: TimeInterval
    var comment: String
    var photos: [URL]
    
    func getDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        let date = Date(timeIntervalSince1970: date)
        return formatter.string(from: date)
    }
}
