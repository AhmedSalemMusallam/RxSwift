//
//  PhotoCollectionViewController.swift
//  CameraFilter
//
//  Created by Ahmed Salem on 08/03/2023.
//

import UIKit
import Photos


class PhotoCollectionViewController: UICollectionViewController {

    private var images = [PHAsset]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        populatePhotos()
       

        
    }
    
    
    private func populatePhotos()
    {
        PHPhotoLibrary.requestAuthorization{ [weak self] status in
            if status == .authorized
            {
                // access the photos from library
                let assets = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)
                assets.enumerateObjects{ (object, count, stop) in
                    self?.images.append(object)
                }
                
                self?.images.reverse()
                print(self?.images)
//                self?.collectionView.reloadData()
            }
            
        }
    }



}
