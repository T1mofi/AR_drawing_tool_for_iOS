//
//  ViewController.swift
//  ARDrawingTool
//
//  Created by Tsimafei's Study on 4/14/20.
//  Copyright © 2020 Tsimafei's Study. All rights reserved.
//

import UIKit
import RealityKit
import ARKit

class SceneViewController: UIViewController {
    
    @IBOutlet var arView: ARView!
    
    static func instantiate() -> SceneViewController {
        let viewController = UIStoryboard(name: "SceneViewController", bundle: nil).instantiateViewController(withIdentifier: "SceneViewController") as! SceneViewController
        
        return viewController
    }
    
    // MARK: - LifeCyecle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load the "Box" scene from the "Experience" Reality File
        
//        let boxAnchor = try! Experience.loadBox()
        
        // Add the box anchor to the scene
//        arView.scene.anchors.append(boxAnchor)
        
        arView.session.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        guard let config = arView.session.configuration else { return }
        
//        config.frameSemantics.insert(.personSegmentationWithDepth)
        let arWorldTrackingConfiguration = ARWorldTrackingConfiguration()
        arWorldTrackingConfiguration.planeDetection = .horizontal
        
        arView.session.run(arWorldTrackingConfiguration)
    }
    
    func sphere(radius: Float, color: UIColor) -> ModelEntity {
        let sphere = ModelEntity(mesh: .generateSphere(radius: radius), materials: [SimpleMaterial(color: color, isMetallic: false)])
        // Move sphere up by half its diameter so that it does not intersect with the mesh
        sphere.position.y = radius
        return sphere
    }
}

extension SceneViewController: ARSessionDelegate {
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        for anchor in anchors {
            if let planeAnchor = anchor as? ARPlaneAnchor {
                print(planeAnchor)
                
                let model = sphere(radius: 0.5, color: .green)
                
                // Place model on a horizontal plane.
                let anchor = AnchorEntity(anchor: planeAnchor)
//                arView.scene.anchors.append(anchor)
                
                model.scale = [1, 1, 1] * 1
                anchor.children.append(model)
            }
        }
    }
}
