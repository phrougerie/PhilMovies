//
//  MoviesService.swift
//  MoviesFramework
//
//  Created by Philippe ROUGERIE on 12/06/2020.
//  Copyright © 2020 Philippe ROUGERIE. All rights reserved.
//
import Foundation

public class MoviesService {
    
    //public static let shared = MoviesService()
    
    public init() {}
    private let baseURL = URL(string: "https://api.themoviedb.org/3")
    private let apiKey = "89b84e40b43cd4309c5c4b7c8eebe33a"
    private let urlSession = URLSession.shared
    private let jsonDecoder: JSONDecoder = {
       let jsonDecoder = JSONDecoder()
       jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
       return jsonDecoder
    }()
    
   public enum Endpoint: String, CaseIterable {
        case nowPlaying = "now_playing"
        case upcoming = "upcoming"
        case popular = "popular"
        case topRated = "top_rated"
        
    }
    
    private func fetchResources<T: Decodable>(url: URL, language : String, page : Int, completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            completion(.failure(.domainError))
            return
        }
        let queryItems = [URLQueryItem(name: "api_key", value: apiKey),
                          URLQueryItem(name: "language", value: language),
                          URLQueryItem(name: "page", value: page.description)]
        urlComponents.queryItems = queryItems
        guard let url = urlComponents.url else {
            completion(.failure(.domainError))
            return
        }
     
        urlSession.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                if let error = error as NSError?, error.domain == NSURLErrorDomain {
                        completion(.failure(.domainError))
                }
                return
            }
            do {
               let values = try self.jsonDecoder.decode(T.self, from: data)
               completion(.success(values))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    public func fetchMovies(from endpoint: Endpoint, language: String, page : Int, result: @escaping (Result<MoviesResponse, NetworkError>) -> Void) {
        let movieURL = baseURL!
            .appendingPathComponent("movie")
            .appendingPathComponent(endpoint.rawValue)
        fetchResources(url: movieURL, language: language, page : page, completion: result)
    }
}


