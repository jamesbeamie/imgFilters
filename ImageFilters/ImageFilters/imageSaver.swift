//
//  imageSaver.swift
//  ImageFilters
//
//  Created by James on 2/13/20.
//  Copyright © 2020 James. All rights reserved.
//

import UIKit

class ImageSaver: NSObject{
    
    var successHandler: (()-> Void)?
    var errorHandler: ((Error)-> Void)?
    func writeToPhotoAlbum(image: UIImage){
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }
    @objc func saveError(_ image: UIImage, didFinishSavingWithError error:Error?, contextInfo: UnsafeRawPointer ){
        if let error = error{
            errorHandler?(error)
        }else{
            successHandler?()
        }
    }
}
