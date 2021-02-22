//
//  Network.swift
//  SicrediNovo
//
//  Created by Bruno Dorneles on 22/02/21.
//

import UIKit

protocol Network {
    func requestGetList(url: URL, completionHandler: @escaping (Data?, NetworkError?)->())
}

enum NetworkError: Error {
    case noData
    case networkError
}

struct NetworkImpl: Network {
    func requestGetList(url: URL, completionHandler: @escaping (Data?, NetworkError?) -> ()) {
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let task = session.dataTask(with: request) { data,response, error in
            guard error == nil else {
                completionHandler(nil,NetworkError.networkError)
                return
            }

            guard let data = data else {
                completionHandler(nil,NetworkError.noData)
                return
            }

            completionHandler(data,nil)
            return
        }
        task.resume()
    }
}
