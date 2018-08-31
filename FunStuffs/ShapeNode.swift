//
//  ShapeNode.swift
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
        self.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
  
}
