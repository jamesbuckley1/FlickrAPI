//
//  UserFetcher.swift
//  FlickrChallenge
//
//  Created by James Buckley on 18/11/2022.
//

import Foundation

struct UserFetcher {
    let service = APIService()

    func fetchUser(withID userID: String, completion: @escaping (User) -> Void) {
        let queryItems = [URLQueryItem(name: "method", value: APIConstants.fetchUserInfo),
                          URLQueryItem(name: "api_key", value: APIConstants.key),
                          URLQueryItem(name: "user_id", value: userID),
                          URLQueryItem(name: "format", value: "json"),
                          URLQueryItem(name: "nojsoncallback", value: "1")
            ]
        
        service.fetch(UserResponse.self, urlParameters: queryItems) { result in
            DispatchQueue.main.async {
                switch result {
                case.failure(let error):
                    print("Error fetching user \(error)")
                case .success(let response):
                    guard let user = response.user else { return }
                    print("Success - got user")
                    user.profileImageURL = self.buildPhotoURL(forUser: user)
                    completion(user)
                }
            }
        }
    }
    
    func buildPhotoURL(forUser user: User) -> URL? {
        let imgURL = "https://farm\(user.iconfarm).staticflickr.com/\(user.iconserver)/buddyicons/\(user.id).jpg"
        
        guard let url = URL(string: imgURL) else { return nil }
        return url
    }
}
