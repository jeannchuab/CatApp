//
//  ViewModelCat.swift
//  CatApp
//
//  Created by Jeann Luiz Chuab on 01/06/22.
//

import Foundation
import Alamofire

class ViewModelCat {
    let url = "https://cataas.com/"
    
    //https://cataas.com/api/cats?limit=50
    
    init() {
        print("Init of viewModel")
    }
    
    func loadData(number: String, completion: @escaping (String) -> ()) {
        
        let completeUrl = "\(url)\(number)"
        
        AF.request(completeUrl).responseString { response in
            if let data = response.value {
                completion(data)
            }
        }
        
    }
}
