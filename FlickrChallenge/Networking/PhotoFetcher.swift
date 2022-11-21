//
//  PhotoFetcher.swift
//  FlickrChallenge
//
//  Created by James Buckley on 17/11/2022.
//

import Foundation

class PhotoFetcher: ObservableObject {
    
    @Published var photos = [Photo]()
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    let service: APIServiceProtocol
    
    init(service: APIServiceProtocol = APIService(), fetchType: PhotoListType, user: User? = nil) {
        self.service = service
        fetchPhotos(fetchType: fetchType, user: user)
    }
    
    func fetchPhotos(fetchType: PhotoListType, user: User? = nil) {
        isLoading = true
        errorMessage = nil
        
        self.photos = [Photo]()
        
        var queryItems = [URLQueryItem]()
        
        switch fetchType {
        case .recentPhotos:
            queryItems = [URLQueryItem(name: "method", value: APIConstants.fetchRecentPhotos),
                              URLQueryItem(name: "api_key", value: APIConstants.key),
                              URLQueryItem(name: "format", value: "json"),
                              URLQueryItem(name: "nojsoncallback", value: "1")
                ]
        case .userPhotos:
            guard let user = user else { return }
            queryItems = [URLQueryItem(name: "method", value: APIConstants.fetchUserPhotos),
                              URLQueryItem(name: "api_key", value: APIConstants.key),
                              URLQueryItem(name: "user_id", value: user.id),
                              URLQueryItem(name: "format", value: "json"),
                              URLQueryItem(name: "nojsoncallback", value: "1")
                ]
            
        }

        service.fetch(PhotoListResponse.self, urlParameters: queryItems) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    self?.errorMessage = error.localisedDescription
                    print(error)
                case .success(let response):
                    guard let photos = response.photoListResponse.photos else { return }
                    print("Success with \(photos.count) photos")
        
                    var newPhotos = [Photo]()
                    
                    let userDispatch = DispatchGroup()
                    
                    for photo in photos {
                        userDispatch.enter()
                        photo.imageURL = self?.buildPhotoURL(forPhoto: photo)

                        self?.fetchPhotoInfo(forPhoto: photo) { photoInfo in
                            DispatchQueue.main.async {
                                photo.info = photoInfo

                                let userFetch = UserFetcher()
                                userFetch.fetchUser(withID: photo.owner, completion: { user in
                                    photo.user = user

                                    newPhotos.append(photo)
                                    userDispatch.leave()
                                })
                            }
                        }
                    }
                    userDispatch.notify(queue: .main) {
                        self?.photos = newPhotos
                        self?.isLoading = false
                    }
                }
            }
        }
    }
    
    func buildPhotoURL(forPhoto photo: Photo) -> URL? {
        let endpoint = "https://live.staticflickr.com"
        let sizeSuffix = "n"
        
        let imgURL = "\(endpoint)/\(photo.server)/\(photo.id)_\(photo.secret)_\(sizeSuffix).jpg"
        
        guard let url = URL(string: imgURL) else { return nil }
        return url
    }
    
    func fetchPhotoInfo(forPhoto photo: Photo, completion: @escaping (PhotoInfo) -> Void) {
        let queryItems = [URLQueryItem(name: "method", value: APIConstants.fetchPhotoInfo),
                          URLQueryItem(name: "api_key", value: APIConstants.key),
                          URLQueryItem(name: "photo_id", value: photo.id),
                          URLQueryItem(name: "format", value: "json"),
                          URLQueryItem(name: "nojsoncallback", value: "1")
            ]
        
        service.fetch(PhotoInfoResponse.self, urlParameters: queryItems) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let response):
                print(response)
                
                completion(response.photoInfo)
            }
        }
    }
}
