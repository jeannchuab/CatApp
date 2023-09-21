//
//  CatModel.swift
//  CatApp
//
//  Created by Jeann Luiz on 21/09/23.
//

import UIKit

struct CatModel: Codable {
    let id: String
    let createdAt: String
    let tags: [String]

    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case createdAt = "created_at"
        case tags
    }
    
    func getImageUrl() -> String {
        return "\(Global.defaultAPIUrl)\(Global.getCatEndpoint)\(id)"
    }
}

