//
//  ViewController.swift
//  CatApp
//
//  Created by Jeann Luiz Chuab on 01/06/22.
//

import UIKit

class ViewController: UIViewController {
    
//    let viewModel: ViewModelCat?
    @IBOutlet weak var textFieldSearch: UITextField!
    @IBOutlet weak var buttonSearch: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var isLoading = false
    var loadingView: LoadingReusableViewCell?
    var arrayData: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        loadData()
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "LoadingReusableViewCell", bundle: nil), forCellWithReuseIdentifier: "LoadingReusableViewCell")
        collectionView.register(UINib(nibName: "CollectionViewItemCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewItemCell")
    }
    
    @IBAction func actionSearch(_ sender: Any) {
        
    }
    
    func loadData() {
        for _ in 1...100 {
            arrayData.append(Int.random(in: 1..<100))
        }
    }
    
    func loadMoreData() {
        if !self.isLoading {
            self.isLoading = true
            DispatchQueue.global().async {
                sleep(2)
                DispatchQueue.main.async {
                    self.arrayData.append(Int.random(in: 1..<100))
                    self.collectionView.reloadData()
                    self.isLoading = false
                }
            }
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewItemCell", for: indexPath) as? CollectionViewItemCell {

            print("Log: ", arrayData[indexPath.row])            
            cell.labelTitle.text = String(arrayData[indexPath.row])

            return cell
        } else {
            return UICollectionViewCell()
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if self.isLoading {
            return CGSize.zero
        } else {
            return CGSize(width: collectionView.bounds.size.width, height: 55)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let aFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "LoadingReusableViewCell", for: indexPath) as! LoadingReusableViewCell
            loadingView = aFooterView
            loadingView?.backgroundColor = UIColor.clear
            return aFooterView
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            self.loadingView?.activityIndicator.startAnimating()
        }
    }

    func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            self.loadingView?.activityIndicator.stopAnimating()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == arrayData.count - 10 && !self.isLoading {
            loadMoreData()
        }
    }
}

