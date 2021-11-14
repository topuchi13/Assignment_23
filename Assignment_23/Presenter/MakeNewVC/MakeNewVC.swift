//
//  MakeNewVC.swift
//  Assignment_23
//
//  Created by Nika Topuria on 13.11.21.
//

import UIKit

class MakeNewVC: UIViewController {
    
    @IBOutlet private var layoutSelector: UISegmentedControl!
    @IBOutlet private var collectionView: UICollectionView!
    var activeTag = 0
    var selectedImages = [Int : UIImage]()
    let fileManager = LocalFileManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "LayoutOneCell", bundle: nil), forCellWithReuseIdentifier: "LayoutOneCell")
        collectionView.register(UINib(nibName: "LayoutTwoCell", bundle: nil), forCellWithReuseIdentifier: "LayoutTwoCell")
        collectionView.register(UINib(nibName: "LayoutThreeCell", bundle: nil), forCellWithReuseIdentifier: "LayoutThreeCell")
        
    }
    
    
    @IBAction func layoutChanged(_ sender: UISegmentedControl) {
        collectionView.reloadData()
    }
    
    @IBAction func clearPressed(_ sender: UIButton) {
        selectedImages.removeAll()
        print (selectedImages)
        collectionView.reloadData()
    }
    
    @IBAction func sharePressed(_ sender: UIButton) {
        let image = makeScreenshot(of: collectionView)
        let filename = UUID.init()
        fileManager.save(image: image, withFileName: "\(filename)")
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
        present(vc, animated: true)
    }
    
    func makeScreenshot(of view: UIView) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: view.bounds.size)
        let image = renderer.image { ctx in
            view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        }
        return image
    }
    

}



extension MakeNewVC: UICollectionViewDelegate {
    
}

extension MakeNewVC: LayoutCellDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate  {
        
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImages[activeTag] = pickedImage
            collectionView.reloadData()
                
        }
        dismiss(animated: true, completion: nil)
    }
    
    func grabImage(for tag: Int, into cell: UICollectionViewCell) {
        activeTag = tag
        let picker = UIImagePickerController()
        picker.allowsEditing = false
        picker.delegate = self
        picker.mediaTypes = ["public.image"]
        self.present(picker, animated: true)
    }
}


extension MakeNewVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}



extension MakeNewVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let selectedLayoutTag = layoutSelector.selectedSegmentIndex + 1
        switch selectedLayoutTag {
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LayoutOneCell", for: indexPath) as! LayoutOneCell
            cell.delegate = self
            cell.clearAll()
            cell.makeNewCell(with: selectedImages)
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LayoutTwoCell", for: indexPath) as! LayoutTwoCell
            cell.delegate = self
            cell.clearAll()
            cell.makeNewCell(with: selectedImages)
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LayoutThreeCell", for: indexPath) as! LayoutThreeCell
            cell.delegate = self
            cell.clearAll()
            cell.makeNewCell(with: selectedImages)
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LayoutOneCell", for: indexPath) as! LayoutOneCell
            cell.delegate = self
            cell.clearAll()
            cell.makeNewCell(with: selectedImages)
            return cell
        }
    }
}


