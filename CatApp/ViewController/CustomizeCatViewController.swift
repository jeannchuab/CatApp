//
//  CustomizeViewController.swift
//  CatApp
//
//  Created by Jeann Luiz Chuab on 03/06/22.
//

import UIKit

class CustomizeCatViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textFieldSearch: UITextField!
    @IBOutlet weak var buttonShare: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var textFieldDisclaimer: UILabel!
    
    var image: UIImage?
    var cat: CatModal?
    var viewModel: CutomizeCatViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CutomizeCatViewModel(delegate: self)
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
        
        viewModel?.downloadImage(cat: cat)
    }
}

extension CustomizeCatViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        viewModel?.downloadImage(cat: cat, customizedText: textFieldSearch.text)
        textFieldSearch.endEditing(true)
        return true
    }
}

extension CustomizeCatViewController: CustomizeCatViewModelDelegate {
    func showLoading(_ show: Bool) {
        DispatchQueue.main.async {
            if show {
                self.activityIndicator.startAnimating()
            } else {
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    func imageDownloaded(image: UIImage) {
        DispatchQueue.main.async {
            self.imageView.image = image
            self.imageView.setNeedsDisplay()
        }
    }
        
    func showDisclaimer(_ show: Bool) {
        DispatchQueue.main.async {
            self.textFieldDisclaimer.isHidden = !show
            self.imageView.isHidden = show
        }        
    }
}
