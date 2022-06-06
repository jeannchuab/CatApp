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
    @IBOutlet weak var buttonShare: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var textFieldDisclaimer: UILabel!
    
    var image: UIImage?
    var cat: CatModal?
    var viewModel: ViewModelCat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
        
    @IBAction func actionShare(_ sender: Any) {
        guard let image = imageView.image else { return }
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view //This avoid a crash on iPad
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func setupLayout() {
        imageView.image = self.image ?? Global.defaultCatImage
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = imageView.frame.size.width / 32
        
        buttonShare.layer.cornerRadius = buttonShare.frame.size.height / 16
        buttonShare.layer.borderWidth = 1
        buttonShare.layer.borderColor = UIColor.lightGray.cgColor
        
        textFieldSearch.delegate = self
        
        if let cat = cat {
            downloadImage(url: cat.getImageUrl())
        }
    }
    
    func downloadImage(url: String) {
        showDisclaimer(false)
        activityIndicator.startAnimating()
        ImageDownloader.shared.downloadImage(with: url, completionHandler: { (image, cached) in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                if image != Global.defaultCatImage {
                    self.imageView.image = image
                    self.imageView.setNeedsDisplay()
                } else {
                    self.showDisclaimer(true)
                }
            }
        }, placeholderImage: Global.defaultCatImage)
    }
    
    func showDisclaimer(_ show: Bool) {
        self.textFieldDisclaimer.isHidden = !show
        self.imageView.isHidden = show
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
