//
//  APIService.swift
//  FlickrChallenge
//
//  Created by James Buckley on 17/11/2022.
//

import Foundation

struct APIService: APIServiceProtocol {

    func fetch<T: Decodable>(_ type: T.Type, urlParameters: [URLQueryItem], completion: @escaping(Result<T, APIError>) -> Void) {
        var urlComponents = URLComponents(string: APIConstants.endpoint)!
        urlComponents.queryItems = urlParameters
        
        guard let url = urlComponents.url else {
            let error = APIError.badURL
            completion(Result.failure(error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error as? URLError {
                completion(Result.failure(APIError.url(error)))
            } else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion(Result.failure(APIError.badResponse(statusCode: response.statusCode)))
            } else if let data = data {
                print(data)
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(type, from: data)
                    completion(Result.success(result))
                } catch {
                    completion(Result.failure(APIError.parsing(error as? DecodingError)))
                }
            }
        }
        task.resume()
    }
    
    func fetchPhotos(urlParameters: [URLQueryItem], completion: @escaping(Result<[Photo], APIError>) -> Void) {
        var urlComponents = URLComponents(string: APIConstants.endpoint)!
        urlComponents.queryItems = urlParameters
        
        guard let url = urlComponents.url else {
            let error = APIError.badURL
            completion(Result.failure(error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error as? URLError {
                completion(Result.failure(APIError.url(error)))
            } else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion(Result.failure(APIError.badResponse(statusCode: response.statusCode)))
            } else if let data = data {
                print(data)
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode([Photo].self, from: data)
                    completion(Result.success(result))
                } catch {
                    completion(Result.failure(APIError.parsing(error as? DecodingError)))
                }
            }
        }
        task.resume()
    }
}
