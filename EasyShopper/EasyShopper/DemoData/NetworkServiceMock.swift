//
//  NetworkServiceMock.swift
//  EasyShopper
//
//  Created by Morten Bek Ditlevsen on 11/06/2020.
//  Copyright © 2020 Ka-ching. All rights reserved.
//

import Foundation
import UIKit

// You may use this URL to load data similar to that which is present in DemoData.swift
let demoDataURL = URL(string: "https://run.mocky.io/v3/4e23865c-b464-4259-83a3-061aaee400ba")!

#warning("Build an actual working service that can fetch the model entities. You may start out with the mock data provided here.")
// Until you have built out your network service, you can use the mock
// response provided here:
class NetworkServiceMock {
    func fetchData(completion: @escaping (Result<Data, Error>) -> Void) {
        let data = Data(demoData.utf8)
        completion(.success(data))
    }
    
    //Get daha from server by url and then return data or error.
    func fetchProducts(url: String, completion: @escaping (Result<[String: Product], Error>) -> Void) {
        URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
         if let data = data {
            let decoder = JSONDecoder()
            do {
                let dict = try decoder.decode([String: Product].self, from: data)
                completion(.success(dict))
            } catch {
                completion(.failure(error))
            }
         } else {
            completion(.failure(error!))
            }
        }.resume()
        
        /* fetchData { result in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let dict = try decoder.decode([String: Product].self, from: data)
                    completion(.success(dict))
                } catch {
                    completion(.failure(error))
                }
            }
        }*/
    }
}

extension NetworkServiceMock {
   /* public func syncResourceLoading<T: Decodable>(from path: String, completion: (T) -> ()) {
        guard let url = URL(fileURLWithPath: path), let data = try? Data(contentsOf: url) else { return }
        
        let json = try? JSONDecoder().decode([T].self, from: data)
        
        guard let result = json else { return }
        completion(result)
    } */
}
