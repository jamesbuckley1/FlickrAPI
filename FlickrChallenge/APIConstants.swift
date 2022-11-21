//
//  Constants.swift
//  FlickrChallenge
//
//  Created by James Buckley on 17/11/2022.
//

import Foundation

class APIConstants {
    static let key = "3540320d40d5116d976a4bce9cd6f16b"
    static let secret = "ef58592db66b91cf"
    static let endpoint = "https://www.flickr.com/services/rest/"
    static let photoEndpoint = "https://live.staticflickr.com"
    
    static let fetchRecentPhotos = "flickr.photos.getRecent"
    static let fetchUserInfo = "flickr.people.getInfo"
    static let fetchPhotoInfo = "flickr.photos.getInfo"
    static let fetchUserPhotos = "flickr.people.getPhotos"
}
