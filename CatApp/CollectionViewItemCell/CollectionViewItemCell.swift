//  CollectionViewCell.swift
//  CatApp
//
//  Created by Jeann Luiz Chuab on 01/06/22.
//

import UIKit

class CollectionViewItemCell: UICollectionViewCell {    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // A previous URL temporarily stored to keep track of previous URL vs. current URL since cells are being reused
    var previousUrlString: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = imageView.frame.size.width / 8
    }
        
    func setup(urlString: String) {
        imageView.contentMode = .center
        imageView.image = Global.defaultCatImage
                
        ImageDownloader.shared.downloadImage(with: urlString, completionHandler: { (image, cached) in
            // We will use two conditions here. Their description is as follows,
            // Either image is cached, in which case it is returned synchronously. If image is not cached, it will be returned asynchronously, in which case we want to store the previous image URL and compare it against the most recent value represented by fullImageUrlString property associated with Movie object. If they do not match, do not apply the image since it now belongs to previous cell which has since been reused.
            
            if cached || (urlString == self.previousUrlString) {
                self.imageView.contentMode = .scaleAspectFill
                self.imageView.image = image
            }
        }, placeholderImage: Global.defaultCatImage)
        
        previousUrlString = urlString
    }
}
