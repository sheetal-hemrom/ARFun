//
//  MLDrawViewController.swift
//  FunStuffs
//
//  Created by Hemrom, Sheetal Swati on 5/9/18.
//  Copyright © 2018 Hemrom, Sheetal Swati. All rights reserved.
//

import UIKit
import CoreML
import Vision

class MLDrawViewController: UIViewController {
    
    @IBOutlet weak var canvasView: CanvasView!
    @IBOutlet weak var recognitionValue: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clearPaths(_ sender: Any) {
        canvasView.clearPaths()
        recognitionValue.text = ""
    }
    @IBAction func recognizePattern(_ sender: Any) {
        let image = UIImage.init(view: canvasView)
        detectDrawing(image: image.cgImage!)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    
}

extension MLDrawViewController{
    
    func detectDrawing(image : CGImage){
        
        // Load the ML model
        guard let model = try? VNCoreMLModel(for: MNIST().model) else{
            fatalError("Can't load text recognition model")
        }
        
        // Crrate Vision Request with a completion Handler
        let request = VNCoreMLRequest(model: model){ [ weak self] request, error in
            guard let results = request.results as? [VNClassificationObservation],
                let topResult = results.first else{
                    fatalError("Unexpected result from VNCoreMLRequest")
            }
            print("Identifier :"  + topResult.identifier)
            print("Confidence : \(topResult.confidence)" )
            
            DispatchQueue.main.async { [ weak self] in
                self?.recognitionValue.text = "\(Int(topResult.confidence * 100))% it's \(topResult.identifier)"
            }
        }
        
        // Run the request on Global Dispatch Queue
        let handler = VNImageRequestHandler(cgImage : image)
        DispatchQueue.global(qos: .userInteractive).async {
            do{
                try handler.perform([request])
            }catch{
                print(error)
            }
        }
        
    }
}

extension UIImage{
    convenience init(view: UIView) {
        
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: false)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: (image?.cgImage)!)
        
    }
}
