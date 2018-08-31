//
//  ViewController.swift
//  FunStuffs
//
//  Created by Hemrom, Sheetal Swati on 5/3/18.
//  Copyright © 2018 Hemrom, Sheetal Swati. All rights reserved.
//

import UIKit
import SceneKit

class SceneViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let scene = SCNScene()
        let sceneView = self.view as! SCNView
        sceneView.scene = scene
        initCameraNode(scene)
        initLightNode(scene)
        initShapeNode(scene)
        initScnp(scene)
        setSceneViewProperties(sceneView)
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setSceneViewProperties(_ scnView:SCNView){
        scnView.allowsCameraControl = true
        scnView.showsStatistics = true
        scnView.backgroundColor = UIColor.black
    }
    
    func initCameraNode(_ scene : SCNScene){
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(0, 0, 5);
        scene.rootNode.addChildNode(cameraNode)
        
    }
    
    func initLightNode(_ scene : SCNScene){
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light?.type = .omni
        lightNode.position = SCNVector3(0, 10, 2);
        scene.rootNode.addChildNode(lightNode)
    }
    
    func initShapeNode(_ scene : SCNScene){
        let myShape = MyCustomShapeNode()
        scene.rootNode.addChildNode(myShape)
        
    }
    
    func initScnp(_ scene : SCNScene){
        let particles = SCNParticleSystem(named: "cloud.scnp", inDirectory: nil)
        scene.rootNode.addParticleSystem(particles!)
        
        let stars = SCNParticleSystem(named: "stars.scnp", inDirectory: nil)
        scene.rootNode.addParticleSystem(stars!)
    }
    
    
}

