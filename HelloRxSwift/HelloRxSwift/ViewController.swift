//
//  ViewController.swift
//  HelloRxSwift
//
//  Created by Ahmed Salem on 22/02/2023.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        _ = Observable.from([1,2,3,4])
    }


}

