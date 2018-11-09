//
//  CameraViewController.swift
//  Bizy
//
//  Created by Wolf on 11/9/18.
//  Copyright © 2018 Wolf. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation



class CameraViewController: UIViewController, QRCodeReaderViewControllerDelegate {
  
//  let cameraView: UIView            = UIView()
//  let cancelButton: UIButton?       = UIButton()
//  let switchCameraButton: UIButton? = SwitchCameraButton()
//  let toggleTorchButton: UIButton?  = ToggleTorchButton()
//  var overlayView: UIView?          = UIView()
  
  let userURL = ""
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
//    readerVC.requestAuthorization({_ in return})
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  lazy var reader: QRCodeReader = QRCodeReader()
  @IBOutlet weak var previewView: QRCodeReaderView! {
    didSet {
      previewView.setupComponents(showCancelButton: true, showSwitchCameraButton: false, showTorchButton: false, showOverlayView: true, reader: reader)
    }
  }
  
  lazy var readerVC: QRCodeReaderViewController = {
    let builder = QRCodeReaderViewControllerBuilder {
      $0.reader = QRCodeReader(metadataObjectTypes: [.qr], captureDevicePosition: .back)
    }
    
    return QRCodeReaderViewController(builder: builder)
  }()
  
  private func checkScanPermissions() -> Bool {
    do {
      return try QRCodeReader.supportsMetadataObjectTypes()
    } catch let error as NSError {
      let alert: UIAlertController
      
      switch error.code {
      case -11852:
        alert = UIAlertController(title: "Error", message: "This app is not authorized to use Back Camera.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Setting", style: .default, handler: { (_) in
          DispatchQueue.main.async {
            print("Hey Now, Hey Now!!")
          }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
      default:
        alert = UIAlertController(title: "Error", message: "Reader not supported by the current device", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
      }
      
      present(alert, animated: true, completion: nil)
      
      return false
    }
  }
  
  @IBAction func scanInPreviewAction(_ sender: Any) {
    guard checkScanPermissions(), !reader.isRunning else { return }
    
    reader.didFindCode = { result in
      print("Completion with result: \(result.value) of type \(result.metadataType)")
    }
    
    reader.startScanning()
  }
  
  @IBAction func scanInModalAction(_ sender: AnyObject) {
//    guard checkScanPermissions() else { return }
    
    readerVC.modalPresentationStyle = .formSheet
    readerVC.delegate               = self
    
    readerVC.completionBlock = { (result: QRCodeReaderResult?) in
      if let result = result {
        
        print("Completion with result: \(result.value) of type \(result.metadataType)")
      }
    }
    
    present(readerVC, animated: true, completion: nil)
  }
  
  func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
    reader.stopScanning()
    
    dismiss(animated: true) { [weak self] in
      let alert = UIAlertController(
        title: "User Found!",
        message: "Would you like to recieve their information?",
        preferredStyle: .alert
      )
      
      
      alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
      alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {(action) -> Void in
        self?.performSegue(withIdentifier: "showUserProfile", sender: self)
        
      }))
      
      self?.present(alert, animated: true, completion: nil)
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showUserProfile" {
      (segue.destination as! ShowUserController).urlString = userURL
    }
  }
  
  func readerDidCancel(_ reader: QRCodeReaderViewController) {
    reader.stopScanning()
    
    dismiss(animated: true, completion: nil)
  }
  
  
  
  
  
}
