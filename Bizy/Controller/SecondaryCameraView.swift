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



class SecondaryCameraView: UIViewController, QRCodeReaderViewControllerDelegate, QRCodeReaderDisplayable {
  
  let cameraView: UIView            = UIView()
  let cancelButton: UIButton?       = UIButton()
  let switchCameraButton: UIButton? = SwitchCameraButton()
  let toggleTorchButton: UIButton?  = ToggleTorchButton()
  var overlayView: UIView?          = UIView()
  
  func setNeedsUpdateOrientation() {
    return
  }
  
  func setupComponents(showCancelButton: Bool, showSwitchCameraButton: Bool, showTorchButton: Bool, showOverlayView: Bool, reader: QRCodeReader?) {
    print("hey")
  }
  
  
  
  lazy var readerVC: QRCodeReaderViewController = {
    let builder = QRCodeReaderViewControllerBuilder {
      $0.reader = QRCodeReader(metadataObjectTypes: [.qr], captureDevicePosition: .back)
    }
    
    return QRCodeReaderViewController(builder: builder)
  }()
  
  func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
    print("hey")
  }
  
  func readerDidCancel(_ reader: QRCodeReaderViewController) {
    print("hey")
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}
