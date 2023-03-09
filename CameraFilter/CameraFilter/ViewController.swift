//
//  ViewController.swift
//  CameraFilter
//
//  Created by Ahmed Salem on 08/03/2023.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    @IBOutlet weak var photoImageView :UIImageView!
    @IBOutlet weak var applyFilterButton :UIButton!
    
    
    @IBAction func applyFilterButtonPressed()
    {
        guard let sourceImage = self.photoImageView.image else{ return }
        FilterService().applyFilter(to: sourceImage){ filteredImage in
            DispatchQueue.main.async {
                self.photoImageView.image  = filteredImage
            }
            
        }
    }
    
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Camera Filter"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navVc = segue.destination as? UINavigationController,
              let photoCVC = navVc.viewControllers.first as? PhotoCollectionViewController
        else{
            fatalError("Segue Destination is not found ")
        }
        
        photoCVC.selectedPhoto.subscribe(onNext: {[weak self] photo in
            //refresh the ui so you have to execute it in the main thread
            DispatchQueue.main.async {
                self?.updateUI(with: photo)
            }
        }).disposed(by: disposeBag)
    }

    private func updateUI(with image: UIImage)
    {
        self.photoImageView.image = image
        self.applyFilterButton.isHidden = false
    }

}

