//
//  ARViewController.swift
//  FURARI
//
//  Created by Rudolf Oganesyan on 16.04.2021.
//

import ARKit
import SceneKit
import UIKit

class ARViewController: UIViewController, ARSCNViewDelegate {

  // MARK: - Properties
  // ==================

  // UI element properties
  // ---------------------
  @IBOutlet var sceneView: ARSCNView!
  @IBOutlet weak var blurView: UIVisualEffectView!


  // Artwork names
  // -------------
  let artworkDisplayNames = [
    "object" : "Поворотный механизм"
  ]

  // AR and SceneView update properties
  // ----------------------------------
  let config = ARWorldTrackingConfiguration()
  var isRestartAvailable = true // Prevents the session from restarting while a restart is in progress.

  // A serial queue (also known as a private dispatch queue) that provides thread safety
  // as we make changes to the SceneKit node graph.
  let updateQueue = DispatchQueue(label: "\(Bundle.main.bundleIdentifier!).serialSceneKitQueue")


  // MARK: - View initializers / events
  // ==================================

  override func viewDidLoad() {
    super.viewDidLoad()

    sceneView.delegate = self
    sceneView.session.delegate = self

    initGestureRecognizers()

    startARSession()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    // Prevent the screen from being dimmed to avoid interuppting the AR experience.
    // Doing this *will* cause the battery to be used up more quickly.
    UIApplication.shared.isIdleTimerDisabled = true

    startARSession()
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)

    sceneView.session.pause()
  }


  // MARK: - Touch response
  // ======================

  func initGestureRecognizers() {
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleScreenTap))
    sceneView.addGestureRecognizer(tapGestureRecognizer)
  }

  @objc func handleScreenTap(sender: UITapGestureRecognizer) {
    let tappedSceneView = sender.view as! ARSCNView
    let tapLocation = sender.location(in: tappedSceneView)
    let tapsOnObject = tappedSceneView.hitTest(tapLocation, options: nil)
    if !tapsOnObject.isEmpty {
      let firstObject = tapsOnObject.first
      if let firstObjectName = firstObject?.node.name {
        performSegue(withIdentifier: "showArtNotes", sender: firstObjectName)
      }
    }
  }


  // MARK: - 3D object detection
  // ===========================

  func startARSession() {
    // Make sure that we have an AR resource group.
    guard let referenceObjects = ARReferenceObject.referenceObjects(inGroupNamed: "AR Resources", bundle: nil) else {
      fatalError("This app doesn't have an AR resource group named 'AR Resources'!")
    }

    // Set up the AR configuration.
    config.worldAlignment = .gravityAndHeading
    config.detectionObjects = referenceObjects

    // Start the AR session.
    sceneView.session.run(config, options: [.resetTracking, .removeExistingAnchors])
  }

  func restartExperience() {
    guard isRestartAvailable else { return }
    isRestartAvailable = false

    startARSession()

    // Disable restart for a few seconds in order to give the AR session time to restart.
    DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
      self.isRestartAvailable = true
    }
  }

  // This delegate method gets called whenever the node corresponding to
  // a new AR anchor is added to the scene.
  func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
    // We only want to deal with image anchors, which encapsulate
    // the position, orientation, and size, of a detected image that matches
    // one of our reference images.
    guard let objectAnchor = anchor as? ARObjectAnchor else { return }
    let referenceObject = objectAnchor.referenceObject
    let objectName = referenceObject.name ?? "Unknown"

    // Draw the object’s name over the object.
    updateQueue.async {
      let nameNode = self.createArtworkNameNode(withObjectName: objectName)
      node.addChildNode(nameNode)
    }

    let statusMessage = "Found \(artworkDisplayNames[objectName] ?? "artwork")."

  }

  // Create a text node to display the name of an artwork.
  func createArtworkNameNode(withObjectName objectName: String) -> SCNNode {
    let textScaleFactor: Float = 0.15
    let textFont = "AvenirNext-BoldItalic"
    let textSize: CGFloat = 0.2
    let textDepth: CGFloat = 0.02

    // Create the text node.
    let artworkNameText = SCNText(string: artworkDisplayNames[objectName],
                                  extrusionDepth: CGFloat(textDepth))
    artworkNameText.font = UIFont(name: textFont, size: textSize)
    artworkNameText.alignmentMode = CATextLayerAlignmentMode.center.rawValue
    artworkNameText.firstMaterial?.diffuse.contents = UIColor.orange
    artworkNameText.firstMaterial?.specular.contents = UIColor.white
    artworkNameText.firstMaterial?.isDoubleSided = true
    artworkNameText.chamferRadius = CGFloat(textDepth)
    let artworkNameTextNode = SCNNode(geometry: artworkNameText)
    artworkNameTextNode.scale = SCNVector3Make(textScaleFactor, textScaleFactor, textScaleFactor)
    artworkNameTextNode.name = objectName

    // Make the text node pivot in its middle around the y-axis.
    let (minBound, maxBound) = artworkNameText.boundingBox
    artworkNameTextNode.pivot = SCNMatrix4MakeTranslation((maxBound.x - minBound.x) / 2,
                                                          minBound.y,
                                                          0)

    // Ensure that the artwork name is always readable with a Billboard constraint,
    // which constraints a SceneKit node to always point towards the camera.
    let billboardConstraint = SCNBillboardConstraint()
    billboardConstraint.freeAxes = SCNBillboardAxis.Y
    artworkNameTextNode.constraints = [billboardConstraint]

    return artworkNameTextNode
  }

}


extension ARViewController: ARSessionDelegate {

  // MARK: - ARSessionDelegate
  // =========================

  func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
  }

  func session(_ session: ARSession, didFailWithError error: Error) {
    guard error is ARError else { return }

    let errorWithInfo = error as NSError
    let messages = [
      errorWithInfo.localizedDescription,
      errorWithInfo.localizedFailureReason,
      errorWithInfo.localizedRecoverySuggestion
    ]

    // Use compactMap(_:) to remove optional error messages.
    let errorMessage = messages.compactMap({ $0 }).joined(separator: "\n")

    DispatchQueue.main.async {
      self.displayErrorMessage(title: "The AR session failed.", message: errorMessage)
    }
  }

  func sessionWasInterrupted(_ session: ARSession) {
    blurView.isHidden = false
  }

  func sessionInterruptionEnded(_ session: ARSession) {
    blurView.isHidden = true

    restartExperience()
  }

  func sessionShouldAttemptRelocalization(_ session: ARSession) -> Bool {
    return true
  }


  // MARK: - Error handling
  // ======================

  func displayErrorMessage(title: String, message: String) {
    // Blur the background.
    blurView.isHidden = false

    // Present an alert informing about the error that has occurred.
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let restartAction = UIAlertAction(title: "Restart Session", style: .default) { _ in
      alertController.dismiss(animated: true, completion: nil)
      self.blurView.isHidden = true
      self.startARSession()
    }
    alertController.addAction(restartAction)
    present(alertController, animated: true, completion: nil)
  }

}
