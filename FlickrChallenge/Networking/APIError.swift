//
//  APIError.swift
//  FlickrChallenge
//
//  Created by James Buckley on 17/11/2022.
//

import Foundation

enum APIError: Error, CustomStringConvertible {
    case badURL
    case url(URLError?)
    case badResponse(statusCode: Int)
    case parsing(DecodingError?)
    
    var localisedDescription: String {
        switch self {
        case .badURL, .parsing:
            return "Something went wrong"
        case .url(let error):
            return error?.localizedDescription ?? "Something went wrong"
        case .badResponse:
            return "Connection to server failed"
        }
    }
    
    var description: String {
        switch self {
        case .badURL: return "Invalid URL"
        case .url(let error):
            return error?.localizedDescription ?? "URL session error"
        case .badResponse(statusCode: let statusCode):
            return "Bad response with status code \(statusCode)"
        case .parsing(let error):
            return "Error decoding response \(error?.localizedDescription ?? "")"
        }
    }
}
