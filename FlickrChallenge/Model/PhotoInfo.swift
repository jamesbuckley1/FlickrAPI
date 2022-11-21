//
//  PhotoInfo.swift
//  FlickrChallenge
//
//  Created by James Buckley on 19/11/2022.
//

import Foundation

struct PhotoInfoResponse: Decodable {
    let photoInfo: PhotoInfo
   
    enum CodingKeys: String, CodingKey {
        case photoInfo = "photo"
    }
}

struct PhotoInfo: Decodable {
    let id: String
    let dateuploaded: String
    let tags: PhotoTags
    let dates: PhotoDates
    let description: PhotoDesc
}

struct PhotoTags: Decodable {
    let tagContent: [TagContent]
    
    enum CodingKeys: String, CodingKey {
        case tagContent = "tag"
    }
}
struct TagContent: Decodable, Hashable {
    let id: String
    let _content: String
}

struct PhotoDates: Decodable {
    let taken: String
}

struct PhotoDesc: Decodable {
    let _content: String?
}
