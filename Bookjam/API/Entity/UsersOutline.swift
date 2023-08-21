//
//  UsersOutline.swift
//  Bookjam
//
//  Created by YOUJIM on 2023/08/21.
//

import Foundation

struct UsersOutlineResponseModel: Codable {
    let userOutline: [UserOutline]?
}

struct UserOutline: Codable {
    let user_id: Int?
    let profile_image: String?
    let username: String?
    let review_count: Int?
    let record_count: Int?
}

struct UsersOutlineRequestModel: Codable {
    
}
