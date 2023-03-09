//
//  FilterService.swift
//  CameraFilter
//
//  Created by Ahmed Salem on 09/03/2023.
//

import Foundation
import UIKit
import CoreImage

class FilterService
{
    private var context: CIContext
    
    init() {
        self.context = CIContext()
    }
    
    func applyFilter(to inputImage: UIImage, completion: @escaping ((UIImage)-> ()))
    {
        let filter = CIFilter(name: "CICMYKHalftone")!
        filter.setValue(5.0, forKey: kCIInputWidthKey)
        
        if let sourceImage = CIImage(image: inputImage)
        {
            filter.setValue(sourceImage, forKey: kCIInputImageKey)
            
            if let cgImage = self.context.createCGImage(filter.outputImage!, from: filter.outputImage!.extent)
            {
                let processedImage = UIImage(cgImage: cgImage, scale: inputImage.scale,orientation: inputImage.imageOrientation)
                completion(processedImage)
            }
        }
    }
}