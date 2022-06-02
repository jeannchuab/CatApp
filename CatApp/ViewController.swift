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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
                
        collectionView.register(UINib(nibName: "LoadingReusableViewCell", bundle: nil), forCellWithReuseIdentifier: "LoadingReusableViewCell")
        
        collectionView.register(UINib(nibName: "CatViewCell", bundle: nil), forCellWithReuseIdentifier: "CatViewCell")
    }
    
    @IBAction func actionSearch(_ sender: Any) {
        
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}

