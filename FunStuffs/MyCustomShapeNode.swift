//
//  MyCustomShapeNode.swift
//  FunStuffs
//
//  Created by Hemrom, Sheetal Swati on 5/3/18.
//  Copyright © 2018 Hemrom, Sheetal Swati. All rights reserved.
//

import SceneKit

class MyCustomShapeNode: SCNNode {

    override init() {
        super.init()
        self.geometry = SCNSphere(radius: 1)
        self.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "Diffuse")
        self.geometry?.firstMaterial?.specular.contents = UIImage(named: "Specular")
        self.geometry?.firstMaterial?.normal.contents = UIImage(named: "Normal")
        self.geometry?.firstMaterial?.emission.contents = UIImage(named: "Emission")
        
        let action = SCNAction.rotate(by: 360 * CGFloat(Double.pi / 180), around: SCNVector3(x:0,y:10,z:0), duration: 8)
        let repeatAction = SCNAction.repeatForever(action)
        self.runAction(repeatAction)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
