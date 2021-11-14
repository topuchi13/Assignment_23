//
//  OldCollagesCell.swift
//  Assignment_23
//
//  Created by Nika Topuria on 14.11.21.
//

import UIKit

class OldCollagesCell: UICollectionViewCell {

    @IBOutlet private var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func makeNew(with image: UIImage){
        imageView.image = image
    }

}
