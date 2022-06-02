//  CollectionViewCell.swift
//  CatApp
//
//  Created by Jeann Luiz Chuab on 01/06/22.
//

import UIKit

class CollectionViewItemCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
