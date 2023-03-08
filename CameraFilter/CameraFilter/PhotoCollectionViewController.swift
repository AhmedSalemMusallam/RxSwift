//
//  PhotoCollectionViewController.swift
//  CameraFilter
//
//  Created by Ahmed Salem on 08/03/2023.
//

import UIKit
import Photos


class PhotoCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        populatePhotos()
       

        
    }
    
    
    private func populatePhotos()
    {
        PHPhotoLibrary.requestAuthorization{ status in
            if status == .authorized
            {
                // access the photos from library 
            }
            
        }
    }



}
