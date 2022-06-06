//
//  ViewModelCustomizeCat.swift
//  CatApp
//
//  Created by Jeann Luiz Chuab on 06/06/22.
//

import Foundation
import UIKit

protocol CustomizeCatViewModelDelegate: AnyObject {
    func imageDownloaded(image: UIImage)
    func showDisclaimer(_ show: Bool)
    func showLoading(_ show: Bool)
}

class CutomizeCatViewModel {
    
    weak var delegate: CustomizeCatViewModelDelegate?
    
    init(delegate: CustomizeCatViewModelDelegate?) {
        self.delegate = delegate
    }
    
    func downloadImage(cat: CatModal?, customizedText: String? = "") {
                        
        guard let cat = cat, let customizedText = customizedText else {
            delegate?.showDisclaimer(true)
            return
        }
        
        delegate?.showLoading(true)
        delegate?.showDisclaimer(false)
        
        let fullUrl = customizedText.isEmpty ? cat.getImageUrl() : "\(cat.getImageUrl())\(Global.getCatCustomizedText)\(customizedText.replacingOccurrences(of: " ", with: "%20"))"
                                
        ImageDownloader.shared.downloadImage(with: fullUrl, completionHandler: { (image, cached) in
            DispatchQueue.main.async {
                self.delegate?.showLoading(false)
                
                guard let image = image else {
                    self.delegate?.showDisclaimer(true)
                    return
                }
                                                
                if image != Global.defaultCatImage {
                    self.delegate?.imageDownloaded(image: image)
                } else {
                    self.delegate?.showLoading(false)
                    self.delegate?.showDisclaimer(true)
                }
            }
        }, placeholderImage: Global.defaultCatImage)        
    }
}
