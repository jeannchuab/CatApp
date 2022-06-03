//
//  Global.swift
//  CatApp
//
//  Created by Jeann Luiz Chuab on 03/06/22.
//

import UIKit

struct Global {
    static var defaultCatImage = UIImage(named: "catIcon")
    static var defaultAPIUrl = "https://cataas.com/"
    static var getCatEndpoint = "cat/"
    static var getCatListEndpoint = "api/cats"
    
    static var textConnectionProblems = "Hummm it seems we don't have cats with this tag 😿 Would like to try \"baby\" or \"kitten\"?"
    static var textEmptyList = "We are facing connection problems 😿 Can you check your internet connection and try again in a few moments?"
}
