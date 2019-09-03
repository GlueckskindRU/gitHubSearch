//
//  NetworkController.swift
//  gitHubSearch
//
//  Created by Yuri Ivashin on 03/09/2019.
//  Copyright © 2019 The Homber Team. All rights reserved.
//

import Foundation

class NetworkController: NSObject {
    private let scheme = "https"
    private let host = "api.github.com"
    private let searchRepoPath = "/search/repositories"
    private let defaultHeaders = [
        "Content-Type" : "application/json",
        "Accept" : "application/vnd.github.v3+json"
    ]
    
    lazy var defaultSession: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.allowsCellularAccess = false
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        let session = URLSession(configuration: configuration, delegate: self as URLSessionDelegate, delegateQueue: queue)
        return session
    }()
    
    // MARK: - private functions
    private func searchRepositoriesRequest(by name: String, descendedSorting: Bool) -> URLRequest? {
        let sortOrder = descendedSorting ? "desc" : "asc"
        
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = searchRepoPath
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: "\(name)"),
            URLQueryItem(name: "sort", value: "stars"),
            URLQueryItem(name: "order", value: sortOrder)
        ]
        
        guard let url = urlComponents.url else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = defaultHeaders
        return request
    }
    
    // MARK: public functions
    func performSearchRepositories(by name: String, descendedSorting: Bool, completion: @escaping (Result<SearchRepositoriesResults>) -> Void) {
        guard let urlRequest = searchRepositoriesRequest(by: name, descendedSorting: descendedSorting) else {
            return completion(.failure(.requestError))
        }
        
        let requestTask = defaultSession.dataTask(with: urlRequest) {
            (data, response, error) in
            
            if let error = error as? SessionError {
                return completion(.failure(error))
            }
            
            guard let responseData = data else {
                return completion(.failure(.dataError))
            }
            
            do {
                let decoder = JSONDecoder()
                let searchResult = try decoder.decode(SearchRepositoriesResults.self, from: responseData)
                completion(.success(searchResult))
            } catch {
                completion(.failure(.otherError(error)))
            }
        }
        requestTask.resume()
    }
}

extension NetworkController: URLSessionDataDelegate {
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Swift.Void) {
        if let httpResponse = response as? HTTPURLResponse {
            if httpResponse.statusCode == 401 {
                completionHandler(URLSession.ResponseDisposition.cancel)
            } else {
                completionHandler(URLSession.ResponseDisposition.allow)
            }
        }
    }
}
