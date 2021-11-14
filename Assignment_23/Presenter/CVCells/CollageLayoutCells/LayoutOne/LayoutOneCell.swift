//
//  LayoutOneCell.swift
//  Assignment_23
//
//  Created by Nika Topuria on 13.11.21.
//

import UIKit

class LayoutOneCell: UICollectionViewCell {
    
    @IBOutlet private var plusCollection: [UIButton]!
    @IBOutlet private var imageCollection: [UIImageView]!
    var selectedTag: Int = 1
    var delegate: LayoutCellDelegate?
    let collageCellManager = CollageCellManager()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func addButtonPresed(_ sender: UIButton) {
        selectedTag = sender.tag
        if let myDelegate = delegate {
            myDelegate.grabImage(for: selectedTag, into: self)
        }
        
    }
    
    func clearAll() {
        plusCollection.forEach({$0.isHidden = false})
        imageCollection.forEach({$0.image = nil})
    }

}


extension LayoutOneCell: LayoutCell {
    func makeNewCell(with imageArray: [Int : UIImage]) {
        imageArray.forEach { (key: Int, value: UIImage) in
            imageCollection.filter({$0.tag == key}).first!.image = value
            plusCollection.filter({$0.tag == key}).first!.isHidden = true
        }
    }
    
}
