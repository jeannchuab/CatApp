//
//  ViewModelCat.swift
//  CatApp
//
//  Created by Jeann Luiz Chuab on 01/06/22.
//

import Foundation
import Alamofire

struct CatModel: Codable {
    let id: String
    let createdAt: String
    let tags: [String]

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case createdAt = "created_at"
        case tags = "tags"
    }
    
    init(id: String, createdAt: String, tags: [String]) {
        self.id = id
        self.createdAt = createdAt
        self.tags = tags
    }
    
    func getImageUrl() -> String {
        return "\("https://cataas.com/cat/")\(id)"
    }
}

/*
 
 [{\"id\":\"595f280c557291a9750ebf80\",\"created_at\":\"2015-11-06T18:36:37.342Z\",\"tags\":[\"cute\",\"eyes\"]},{\"id\":\"595f280e557291a9750ebf9f\",\"created_at\":\"2016-10-09T12:51:24.421Z\",\"tags\":[\"cute\",\"sleeping\"]},{\"id\":\"595f280e557291a9750ebfa6\",\"created_at\":\"2016-11-22T15:20:31.913Z\",\"tags\":[\"cute\",\"sleeping\"]}]
 
 */

class ViewModelCat {
    let url = "https://cataas.com/api/cats?tags=cute"
    var catList: [CatModel] = []
            
    init() {
        print("Init of viewModel")
    }
    
    func loadData(tag: String = "cute", completion: @escaping ([CatModel]) -> ()) {
        AF.request(url).responseString { response in
            print(response)
            
            switch response.result {
            case .success(let value):
                let data = Data(value.utf8)
                do {
                    if let jsonList = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                        print("Log:", jsonList)
                                                                                
                        for item in jsonList {
                            guard let id = item["id"] as? String,
                                  let createdAt = item["created_at"] as? String,
                                  let tags = item["tags"] as? [String]
                            else {
                                return
                            }
                            
                            self.catList.append(CatModel(id: id, createdAt: createdAt, tags: tags))
                        }
                    }
                } catch {
                    print("Failed to load: \(error.localizedDescription)")
                }
                completion(self.catList)
            case .failure(let error):
                print(error)
            }
        }
    }
    
//    func loadDataMockData(tag: String = "cute", completion: @escaping (String) -> ()) {
//        let string = "[{\"id\":\"595f280c557291a9750ebf80\",\"created_at\":\"2015-11-06T18:36:37.342Z\",\"tags\":[\"cute\",\"eyes\"]},{\"id\":\"595f280e557291a9750ebf9f\",\"created_at\":\"2016-10-09T12:51:24.421Z\",\"tags\":[\"cute\",\"sleeping\"]},{\"id\":\"595f280e557291a9750ebfa6\",\"created_at\":\"2016-11-22T15:20:31.913Z\",\"tags\":[\"cute\",\"sleeping\"]}]"
//        let data = Data(string.utf8)
//
//        var catList = [CatModel]()
//
//        do {
//            if let jsonList = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
//                print("Log:", jsonList)
//
//
//                for item in jsonList {
//                    guard let id = item["id"] as? String,
//                          let createdAt = item["created_at"] as? String,
//                          let tags = item["tags"] as? [String]
//                    else {
//                        return
//                    }
//
//                    catList.append(CatModel(id: id, createdAt: createdAt, tags: tags))
//                }
//            }
//        } catch {
//            print("Failed to load: \(error.localizedDescription)")
//        }
//
//        print("Log:", catList)
//    }
}
