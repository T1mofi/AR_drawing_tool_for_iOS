import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    
    enum ObjectPlacementMode {
        case freeform, plane, image
    }
    
    var objectMode: ObjectPlacementMode = .freeform
    
    var selectedNode: SCNNode?
    var placedNodes: [SCNNode] = []
    var planeNodes: [SCNNode] = []
    
    var isPlaneVisualizationEnabled = false {
        didSet {
            for node in planeNodes {
                node.isHidden = !isPlaneVisualizationEnabled
                sceneView.debugOptions = isPlaneVisualizationEnabled ? [.showFeaturePoints] : []
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sceneView.delegate = self
        sceneView.autoenablesDefaultLighting = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadConfiguration()
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showOptions" {
            let optionsViewController = segue.destination as! OptionsContainerViewController
            optionsViewController.delegate = self
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        guard let touch = touches.first else { return }
        guard let selectedNode = selectedNode else { return }
        let touchPoint = touch.location(in: sceneView)
        
        switch objectMode {
        case .freeform:
            addNodeInFront(selectedNode)
        case .plane:
            addNodeToPlane(selectedNode, using: touchPoint)
        default:
            break
        }
    }
}

// MARK: - Actions
extension ViewController {
    @IBAction func changeObjectMode(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            objectMode = .freeform
        case 1:
            objectMode = .plane
        case 2:
            objectMode = .image
        default:
            break
        }
    }
}

// MARK: - OptionsViewControllerDelegate
extension ViewController: OptionsViewControllerDelegate {
    func objectSelected(node: SCNNode) {
        selectedNode = node
        dismiss(animated: true, completion: nil)
    }
    
    func togglePlaneVisualization() {
        dismiss(animated: true, completion: nil)
        isPlaneVisualizationEnabled.toggle()
    }
    
    func undoLastObject() {
        
    }
    
    func resetScene() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - ARSCNViewDelegate
extension ViewController {
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if let planeAnchor = anchor as? ARPlaneAnchor {
            nodeAdded(node, for: planeAnchor)
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor, let planeNode = node.childNodes.first, let plane = planeNode.geometry as? SCNPlane else { return }
        
        planeNode.position = SCNVector3(planeAnchor.center.x, 0, planeAnchor.center.z)
        plane.width = CGFloat(planeAnchor.extent.x)
        plane.height = CGFloat(planeAnchor.extent.z)
    }
}

// MARK: - Private functions
extension ViewController {
    func nodeAdded(_ node: SCNNode, for anchor: ARPlaneAnchor) {
        let surfaceColor: UIColor = anchor.alignment == .horizontal ? .green : .red
        let planeVisualisationSurface = createSurace(planeAnchor: anchor, with: surfaceColor)
        planeVisualisationSurface.isHidden = !isPlaneVisualizationEnabled
        
        node.addChildNode(planeVisualisationSurface)
        planeNodes.append(planeVisualisationSurface)
    }
    
    func createSurace(planeAnchor: ARPlaneAnchor, with color: UIColor) -> SCNNode {
        let node = SCNNode()
        let surface = SCNPlane(width: CGFloat(planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.z))
        
        surface.firstMaterial?.diffuse.contents = color
        node.geometry = surface
        node.opacity = 0.4
        rotateNode90Deg(node)
        
        return node
    }
    
    func rotateNode90Deg(_ node: SCNNode) {
        node.eulerAngles.x = -Float.pi / 2
    }
    
    func addNodeInFront(_ node: SCNNode) {
        guard let currentFrame = sceneView.session.currentFrame else { return }
        
        var translation = matrix_identity_float4x4
        translation.columns.3.z = -0.2
        node.simdTransform = matrix_multiply(currentFrame.camera.transform, translation)
        
        addNodeToSceneRoot(node)
    }
    
    func addNodeToPlane(_ node: SCNNode, using point: CGPoint) {
        let results = sceneView.hitTest(point, types: [.existingPlaneUsingExtent])
        
        guard let match = results.first else { return }
        let transform = match.worldTransform
        let yOffset = node.boundingBox.max.y
        node.position = SCNVector3(transform.columns.3.x, transform.columns.3.y + yOffset, transform.columns.3.z)
        addNodeToSceneRoot(node)
    }
    
    func addNodeToSceneRoot(_ node: SCNNode) {
        let cloneNode = node.clone()
//        cloneNode.eulerAngles.z = Float.pi
//        cloneNode.eulerAngles.x = Float.pi / 2
//        cloneNode.eulerAngles.y = -Float.pi / 2
        
        sceneView.scene.rootNode.addChildNode(cloneNode)
        placedNodes.append(cloneNode)
    }
    
    func reloadConfiguration() {
        configuration.planeDetection = [.horizontal, .vertical]
    }
}
