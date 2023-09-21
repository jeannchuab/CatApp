//
//  ViewModelCat.swift
//  CatApp
//
//  Created by Jeann Luiz Chuab on 01/06/22.
//

import Foundation
import Alamofire

protocol CatListViewModelDelegate: AnyObject {
    func imageDownloaded()
    func showDisclaimer(show: Bool, message: String)
    func showLoading(_ show: Bool)
}

class CatListViewModel {
    let url = "\(Global.defaultAPIUrl)\(Global.getCatListEndpoint)"
    var catList: [CatModel] = []
    weak var delegate: CatListViewModelDelegate?
            
    init(delegate: CatListViewModelDelegate) {
        self.delegate = delegate
    }
    
    func loadData(tag: String?) async throws {
        
    }
    
    func loadData(tag: String?) {        
        guard let tag = tag else { return }
        let param = tag.isEmpty ? "cute" : tag
        let filter = ["tags" : param]
        
        catList = []
        
        delegate?.showLoading(true)
                                        
        AF.request(url, parameters: filter).responseString { response in
            print(response)

            switch response.result {
            case .success(let value):
                let data = Data(value.utf8)
                do {
                    if let jsonList = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                        print("Log:", jsonList)

                        for item in jsonList {
                            guard let id = item["id"] as? String,
                                  let createdAt = item["created_at"] as? String,
                                  let tags = item["tags"] as? [String]
                            else {
                                self.delegate?.showLoading(false)
                                self.delegate?.showDisclaimer(show: true, message: Global.textConnectionProblems)
                                return
                            }

                            self.catList.append(CatModel(id: id, createdAt: createdAt, tags: tags))
                        }

                        self.delegate?.showLoading(false)

                        if self.catList.isEmpty {
                            self.delegate?.showDisclaimer(show: true, message: Global.textEmptyList)
                        } else {
                            self.delegate?.showDisclaimer(show: false, message: "")
                            self.delegate?.imageDownloaded()
                        }
                    }
                } catch {
                    self.delegate?.showLoading(false)
                    self.delegate?.showDisclaimer(show: true, message: Global.textConnectionProblems)
                }
            case .failure(_):
                self.delegate?.showLoading(false)
                self.delegate?.showDisclaimer(show: true, message: Global.textConnectionProblems)
            }
        }
    }
}
