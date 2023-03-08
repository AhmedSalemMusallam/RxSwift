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
            self?.photoImageView.image = photo
        }).disposed(by: disposeBag)
    }


}

