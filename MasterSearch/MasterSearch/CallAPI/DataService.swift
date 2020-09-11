//
//  DataService.swift
//  ClosureInTableViewCell
//
//  Created by Boss on 9/6/20.
//  Copyright © 2020 LuyệnĐào. All rights reserved.
//

import UIKit

class DataService {
    static let sharing: DataService = DataService()
    
    func getData( completion: @escaping(BaseDataModel) -> Void) {
        let queryItems = [URLQueryItem(name: "i", value: "Gin")]
        var urlComps = URLComponents(string: "https://www.thecocktaildb.com/api/json/v1/1/filter.php")!
        urlComps.queryItems = queryItems
        let result = urlComps.url!
        print(result)
        URLSession.shared.dataTask(with: result, completionHandler: { data, response, error in
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                           print("fullURLRequest: ", result)
                           print("params: ", result.query as Any)
                           print("header: ", result.relativeString)
                           print("Response json:\n", dataString)
                       }
            do {
                let json = try? JSONDecoder().decode(BaseDataModel.self, from: data!)
                DispatchQueue.main.async {
                    if let json = json {
                        completion(json)
                    }
                }
            } catch let error {
                print("decode error: ", error)
            }
        })
        .resume()
    }
}

