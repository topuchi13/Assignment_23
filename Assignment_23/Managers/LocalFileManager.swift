//
//  FileManager.swift
//  Assignment_23
//
//  Created by Nika Topuria on 14.11.21.
//

import UIKit


class LocalFileManager {
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func read() -> [UIImage] {
        let items = try! FileManager.default.contentsOfDirectory(atPath: getDocumentsDirectory().path)
        var images = [UIImage]()
        for item in items {
                images.append(UIImage(contentsOfFile: getDocumentsDirectory().appendingPathComponent(item).path)!)
        }
        return images
    }
    
    func save(image: UIImage, withFileName fileName: String) {
       
        if let data = image.pngData() {
                let filename = getDocumentsDirectory().appendingPathComponent("\(fileName).png")
                try? data.write(to: filename)
            }
    }
    
}
