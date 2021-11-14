//
//  BrowseOldVC.swift
//  Assignment_23
//
//  Created by Nika Topuria on 13.11.21.
//

import UIKit

class BrowseOldVC: UIViewController {

    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet private var imageView: UIImageView!
    var imagesToLoad = [UIImage]()
    let fileManager = LocalFileManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.borderWidth = 2
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "OldCollagesCell", bundle: nil), forCellWithReuseIdentifier: "OldCollagesCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        imagesToLoad = fileManager.read()
        collectionView.reloadData()
    }
}



extension BrowseOldVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width / 3, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        CGFloat(4.0)
    }
    
}


extension BrowseOldVC:UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        imageView.image = imagesToLoad[indexPath.row]
    }
    
}


extension BrowseOldVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        imagesToLoad.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OldCollagesCell", for: indexPath) as! OldCollagesCell
        cell.makeNew(with: imagesToLoad[indexPath.row])
        return cell
    }
    
    
}
