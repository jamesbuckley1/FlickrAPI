//
//  User.swift
//  FlickrChallenge
//
//  Created by James Buckley on 18/11/2022.
//

import Foundation

struct UserResponse: Decodable {
    let user: User?
    
    enum CodingKeys: String, CodingKey {
        case user = "person"
    }
}

class User: Decodable {
    let id: String
    let iconserver: String
    let iconfarm: Int
    let realname: UserRealName?
    var profileImageURL: URL?
}

struct UserRealName: Decodable {
    let _content: String
}

