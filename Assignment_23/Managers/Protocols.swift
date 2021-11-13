//
//  Protocols.swift
//  Assignment_23
//
//  Created by Nika Topuria on 13.11.21.
//

import UIKit



protocol LayoutCellDelegate{
    func grabImage(for tag: Int, into cell: UICollectionViewCell)
}

protocol LayoutCell{
    func makeNewCell(with imageArray: [Int : UIImage])
}
