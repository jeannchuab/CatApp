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
    var viewModel = ViewModelCat()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
//        loadData()
        loadDataFromAPI()
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self                
        collectionView.register(UINib(nibName: "CollectionViewItemCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewItemCell")
        
        //Register Loading Reuseable View
        let loadingReusableNib = UINib(nibName: "LoadingReusableViewCell", bundle: nil)
        collectionView.register(loadingReusableNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "LoadingReusableViewCell")
    }
    
    @IBAction func actionSearch(_ sender: Any) {
        
    }
    
//    func loadData() {
//        isLoading = false
//        collectionView.collectionViewLayout.invalidateLayout()
//        for _ in 1...100 {
//            arrayData.append(Int.random(in: 1..<100))
//        }
//        self.collectionView.reloadData()
//    }
    
    func loadDataFromAPI() {
        viewModel.loadData(completion: { catList in
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        })
    }
    
//    func loadMoreData() {
//        if !self.isLoading {
//            self.isLoading = true
//            let start = arrayData.count
//            let end = start + 16
//            DispatchQueue.global().async {
//                // fake background loading task
//                sleep(2)
//                for _ in start...end {
//                    self.arrayData.append(Int.random(in: 1..<100))
//                }
//                DispatchQueue.main.async {
//                    self.collectionView.reloadData()
//                    self.isLoading = false
//                }
//            }
//        }
//    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.catList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewItemCell", for: indexPath) as? CollectionViewItemCell {            
//            cell.imageView.imageFromUrl(urlString: viewModel.catList[indexPath.row].getImageUrl())
            cell.setup(urlString: viewModel.catList[indexPath.row].getImageUrl())
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
//        if self.isLoading {
//            return CGSize.zero
//        } else {
//            return CGSize(width: collectionView.bounds.size.width, height: 100)
//        }
//    }
    
//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        if indexPath.row == arrayData.count - 10 && !self.isLoading {
//            loadMoreData()
//        }
//    }
    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        if kind == UICollectionView.elementKindSectionFooter {
//            let aFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "LoadingReusableViewCell", for: indexPath) as! LoadingReusableViewCell
//            loadingView = aFooterView
//            loadingView?.backgroundColor = UIColor.clear
//            return aFooterView
//        }
//        return UICollectionReusableView()
//    }
//
//    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
//        if elementKind == UICollectionView.elementKindSectionFooter {
//            self.loadingView?.activityIndicator.startAnimating()
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
//        if elementKind == UICollectionView.elementKindSectionFooter {
//            self.loadingView?.activityIndicator.stopAnimating()
//        }
//    }
}
