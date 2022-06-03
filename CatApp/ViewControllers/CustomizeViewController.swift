//
//  CustomizeViewController.swift
//  CatApp
//
//  Created by Jeann Luiz Chuab on 03/06/22.
//

import UIKit

class CustomizeViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textFieldSearch: UITextField!
        
    var image: UIImage?
    var cat: CatModal?
    var viewModel: ViewModelCat?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
    }
    
    func setupLayout() {
        imageView.image = self.image ?? Global.defaultCatImage
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = imageView.frame.size.width / 32
        
        textFieldSearch.delegate = self
        
        if let cat = cat {
            downloadImage(url: cat.getImageUrl())
        }
    }
    
    func downloadImage(url: String) {
        ImageDownloader.shared.downloadImage(with: url, completionHandler: { (image, cached) in
            DispatchQueue.main.async {
                self.imageView.image = image
                self.imageView.setNeedsDisplay()
            }
        }, placeholderImage: Global.defaultCatImage)
    }
    
    func getCustomCat() {
        guard let text = textFieldSearch.text,
                !text.isEmpty,
                let cat = cat
        else {
            return
        }
        
        let fullUrl = "\(cat.getImageUrl())\("/says/")\(text.replacingOccurrences(of: " ", with: "%20"))"
        downloadImage(url: fullUrl)
    }
}

extension CustomizeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        getCustomCat()
        textFieldSearch.endEditing(true)
        return true
    }
}
