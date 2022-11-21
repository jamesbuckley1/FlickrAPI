//
//  Photo.swift
//  FlickrChallenge
//
//  Created by James Buckley on 17/11/2022.
//

import Foundation

struct PhotoListResponse: Decodable, Identifiable {
    let id = UUID()
    
    let photoListResponse: PhotoList
    
    enum CodingKeys: String, CodingKey {
        case photoListResponse = "photos"
    }
}

struct PhotoList: Decodable {
    let page: Int
    let photos: [Photo]?
    
    enum CodingKeys: String, CodingKey {
        case page
        case photos = "photo"
    }
}

class Photo: Decodable, Identifiable {
    let id: String
    let owner: String
    let secret: String
    let title: String
    let server: String
    let farm: Int
    var imageURL: URL?
    var info: PhotoInfo?
    var user: User?
    
    init(id: String, owner: String, secret: String, title: String, server: String, farm: Int, imageURL: URL? = nil, info: PhotoInfo? = nil, user: User? = nil) {
        self.id = id
        self.owner = owner
        self.secret = secret
        self.title = title
        self.server = server
        self.farm = farm
        self.imageURL = imageURL
        self.info = info
        self.user = user
    }
    
    static func photoExample() -> Photo {
        return Photo(id: "id1", owner: "James Buckley", secret: "12345", title: "Test Photo 1", server: "Server 1", farm: 1)
    }
}
