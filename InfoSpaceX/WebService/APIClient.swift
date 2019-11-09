//
//  APIClient.swift
//  InfoSpaceX
//
//  Created by Sagar Thapa on 11/8/19.
//  Copyright © 2019 Tenhaff. All rights reserved.
//

import Foundation

enum APIError: Error {
    case noInternet
    case requestFailed
    case jsonConversionFailure
    case invalidData
     case invalidResponse
    case responseUnsuccessful
    case jsonParsingFailure
    case somethingWentWrong
    
    var localizedDescription: String {
        switch self {
        case .noInternet: return "The Internet connection appears to be offline."
        case .requestFailed: return "Request Failed. Please try again later"
        case .invalidData: return "Invalid Data. Please try again later"
            case .invalidResponse: return "Invalid Response. Please try again later"
        case .responseUnsuccessful: return "Response Unsuccessful. Please try again later"
        case .jsonParsingFailure: return "JSON Parsing Failure. Please try again later"
        case .jsonConversionFailure: return "JSON Conversion Failure. Please try again later"
        case .somethingWentWrong: return "Something went wrong. Please try again later"
        }
    }
}

public enum Result<T, U>  where U: Error{
    case success(T)
    case failure(U)
}

enum DataError: Error {
    case invalidResponse
    case invalidData
    case decodingError
    case serverError
}

class APIClient {
    typealias result<T> = (Result<[T], Error>) -> Void
    typealias rocketResult<T> = (Result<T, Error>) -> Void
    
    
    //MARK: - for array of object
    func getLaunchList<T: Decodable>(of type: T.Type, from url: URL, completion: @escaping result<T>) {
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(DataError.invalidResponse))
                return
            }
            
            if 200 ... 299 ~= response.statusCode {
                if let data = data {
                    do {
                        let decodedData: [T] = try JSONDecoder().decode([T].self, from: data)
                        completion(.success(decodedData))
                    }
                    catch {
                        completion(.failure(DataError.decodingError))
                    }
                } else {
                    completion(.failure(DataError.invalidData))
                }
            } else {
                completion(.failure(DataError.serverError))
            }
            }.resume()
    }
    
    //MARK: - for single object
    func getRocket<T: Decodable>(of type: T.Type, from url: URL, completion: @escaping rocketResult<T>) {
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(DataError.invalidResponse))
                return
            }
            
            if 200 ... 299 ~= response.statusCode {
                if let data = data {
                    do {
                        let decodedData: T = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(decodedData))
                    }
                    catch {
                        completion(.failure(DataError.decodingError))
                    }
                } else {
                    completion(.failure(DataError.invalidData))
                }
            } else {
                completion(.failure(DataError.serverError))
            }
            }.resume()
    }
    
}
