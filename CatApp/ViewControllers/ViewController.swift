//
//  ViewController.swift
//  CatApp
//
//  Created by Jeann Luiz Chuab on 01/06/22.
//

import UIKit

class ViewController: UIViewController {    
    @IBOutlet weak var textFieldSearch: UITextField!
    @IBOutlet weak var labelDisclaimer: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var isLoading = false
    var arrayData: [Int] = []
    var viewModel = ViewModelCat()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        // TODO: Work on the customize your phrase on the cat image
        // TODO: Maybe share the cutomized phrase on other apps?
        
        textFieldSearch.delegate = self
        
        setupCollectionView()
        loadDataFromAPI()
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
        
    func loadDataFromAPI() {
        guard let text = textFieldSearch.text else { return }
        viewModel.loadData(tag: text, completion: { result in
            switch result {
            case .success(let catList):
                DispatchQueue.main.async {
                    self.collectionView.isHidden = catList.isEmpty
                    self.labelDisclaimer.text = Global.textConnectionProblems
                    self.labelDisclaimer.isHidden = !catList.isEmpty
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self.collectionView.isHidden = true
                    self.labelDisclaimer.text = Global.textEmptyList
                    self.labelDisclaimer.isHidden = false
                }
            }
            self.collectionView.reloadData()
        })
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.catList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewItemCell", for: indexPath) as? CollectionViewItemCell {
            cell.setup(urlString: viewModel.catList[indexPath.row].getImageUrl())
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewItemCell else { return }
        
        if !cell.isLoading {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            if let controller = storyBoard.instantiateViewController(withIdentifier: "CustomizeViewController") as? CustomizeViewController {
                controller.cat = viewModel.catList[indexPath.row]
                controller.viewModel = viewModel
                self.navigationController?.present(controller, animated: true)
            }
        }                        
    }
    
    //This is important to keep the scale of the cell compatible with the layout of different screens
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width * 0.42, height: view.frame.size.width * 0.42)
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        loadDataFromAPI()
        textFieldSearch.endEditing(true)
        return true
    }
}
