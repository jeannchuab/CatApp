//
//  CatListViewController.swift
//  CatApp
//
//  Created by Jeann Luiz Chuab on 01/06/22.
//

import UIKit

class CatListViewController: UIViewController {    
    @IBOutlet weak var textFieldSearch: UITextField!
    @IBOutlet weak var labelDisclaimer: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var viewModel: CatListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFieldSearch.delegate = self
        
        viewModel = CatListViewModel(delegate: self)
        
        setupCollectionView()
        
        viewModel?.loadData(tag: textFieldSearch.text)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsSelection = true
        collectionView.register(UINib(nibName: "CollectionViewItemCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewItemCell")
    }
}

extension CatListViewController: CatListViewModelDelegate {
    func imageDownloaded() {
        self.collectionView.reloadData()
    }
    
    func showLoading(_ show: Bool) {
        DispatchQueue.main.async {
            if show {
                self.activityIndicator.startAnimating()
            } else {
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    func showDisclaimer(show: Bool, message: String = "") {
        DispatchQueue.main.async {
            self.collectionView.isHidden = show
            self.labelDisclaimer.text = message
            self.labelDisclaimer.isHidden = !show
        }
    }
}

extension CatListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.catList.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewItemCell", for: indexPath) as? CollectionViewItemCell {
            cell.setup(urlString: viewModel?.catList[indexPath.row].getImageUrl() ?? "")
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewItemCell else { return }
        
        if !cell.isLoading {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            if let controller = storyBoard.instantiateViewController(withIdentifier: "CustomizeViewController") as? CustomizeCatViewController {
                controller.cat = viewModel?.catList[indexPath.row]
                self.navigationController?.present(controller, animated: true)
            }
        }                        
    }
    
    //This is important to keep the scale of the cell compatible with the layout of different screens
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width * 0.42, height: view.frame.size.width * 0.42)
    }
}

extension CatListViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        viewModel?.loadData(tag: textFieldSearch.text)
        textFieldSearch.endEditing(true)
        return true
    }
}
