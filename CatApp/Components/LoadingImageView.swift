//
//  LoadingImageView.swift
//  CatApp
//
//  Created by Jeann Luiz Chuab on 02/06/22.
//

import Foundation
import UIKit
import Alamofire

// TODO: Remove that

class LoadingImageView: UIImageView {
    var activityView: UIActivityIndicatorView?        
    
//    public func imageFromUrl(urlString: String) {
//        startLoading()
//        guard let url = URL(string: urlString) else { return }
//
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            guard let data = data, error == nil else { return }
//            DispatchQueue.main.async {
//                self.image = UIImage(data: data)
//            }
//        }
//
//        stopLoading()
//        task.resume()
//    }    
    
    func startLoading() {
        activityView = UIActivityIndicatorView(style: .medium)
        activityView?.center = self.center
        self.addSubview(activityView!)
        activityView?.startAnimating()
    }
    
    func stopLoading() {
        if activityView != nil {
            activityView?.stopAnimating()
        }
    }
}
