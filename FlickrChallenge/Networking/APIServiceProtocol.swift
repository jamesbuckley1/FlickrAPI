//
//  APIServiceProtocol.swift
//  FlickrChallenge
//
//  Created by James Buckley on 17/11/2022.
//

import Foundation

protocol APIServiceProtocol {
    func fetchPhotos(urlParameters: [URLQueryItem], completion: @escaping(Result<[Photo], APIError>) -> Void)
    func fetch<T: Decodable>(_ type: T.Type, urlParameters: [URLQueryItem], completion: @escaping(Result<T, APIError>) -> Void)
}


