//
//  UIImageView+Extensions.swift
//  CatApp
//
//  Created by Jeann Luiz Chuab on 02/06/22.
//

import UIKit

// TODO: Remove that

extension UIImageView {        
    func setCustomImage(_ imgURLString: String?) {
        guard let imageURLString = imgURLString else {
            self.image = UIImage(named: "default.png")
            return
        }
        DispatchQueue.main.async { [weak self] in
            let data = try? Data(contentsOf: URL(string: imageURLString)!)
            DispatchQueue.main.async {
                self?.image = data != nil ? UIImage(data: data!) : UIImage(named: "default.png")
            }
        }
    }
}
