//
//  ARKitViewController.swift
//  FunStuffs
//
//  Created by Hemrom, Sheetal Swati on 5/3/18.
//  Copyright © 2018 Hemrom, Sheetal Swati. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ARKitExViewController: UIViewController,ARSCNViewDelegate{
    
    @IBOutlet var arscnView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSceneViewProperties(arscnView)
        let scene = SCNScene()
        arscnView.scene = scene
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        arscnView.session.run(ARWorldTrackingConfiguration())
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        arscnView.session.pause()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let position = touch?.location(in: arscnView)
        
        let hitTestResults =  arscnView.hitTest(position!, types: .featurePoint)
        if let hitTestResult = hitTestResults.first{
            let transform = hitTestResult.worldTransform
            let position = SCNVector3(x:transform.columns.3.x,y:transform.columns.3.y,z:transform.columns.3.z )
            let earth = MyCustomShapeNode()
            earth.position = position
            arscnView.scene.rootNode.addChildNode(earth)
        }
    }
    
    //MARK: Delegate Methods
    
    func sessionWasInterrupted(_ session: ARSession) {
        //
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        //
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        //
    }
    
    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
        //
    }
    
    func session(_ session: ARSession, didOutputAudioSampleBuffer audioSampleBuffer: CMSampleBuffer) {
        //
    }
    
    //MARK: Helper Methods
    
    func setSceneViewProperties(_ scnView:ARSCNView){
        scnView.delegate = self
        scnView.showsStatistics = true
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool{
        return true;
    }
    
}
