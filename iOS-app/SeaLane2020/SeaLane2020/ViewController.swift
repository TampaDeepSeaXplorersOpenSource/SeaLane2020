//
//  ViewController.swift
//  SeaLane2020
//
//  Created by Nung Bedell on 3/28/17.
//  Copyright © 2017 Bedell Media LLC. All rights reserved.
//

import UIKit
import AVFoundation
import Foundation
import CoreMedia

class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var imgOverlay: UIImageView!
    @IBOutlet weak var btnCapture: UIButton!
    @IBOutlet weak var map: UIImageView!
    @IBOutlet weak var statBar: UIImageView!
    @IBOutlet weak var ctlBar: UISegmentedControl!
    @IBOutlet weak var compass: UIImageView!
    @IBOutlet weak var crs: UILabel!
    @IBOutlet weak var hdg: UILabel!
    @IBOutlet weak var speed: UILabel!
    @IBOutlet weak var ztime: UILabel!
    @IBOutlet weak var depth: UILabel!
    @IBOutlet weak var redFilter: UIImageView!
    
    let captureSession = AVCaptureSession()
    let stillImageOutput = AVCapturePhotoOutput()
    var previewLayer : AVCaptureVideoPreviewLayer?
    
    // If we find a device we'll store it here for later use
    var captureDevice : AVCaptureDevice?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        captureSession.sessionPreset = AVCaptureSessionPresetHigh
        
        captureDevice = AVCaptureDevice.defaultDevice(withDeviceType: .builtInWideAngleCamera, mediaType: AVMediaTypeVideo, position: .back)
      //  if let devices = AVCaptureDeviceDiscoverySession as? [AVCaptureDevice] {
            // Loop through all the capture devices on this phone
      //      for device in devices {
                // Make sure this particular device supports video
      //          if (device.hasMediaType(AVMediaTypeVideo)) {
                    // Finally check the position and confirm we've got the back camera
      //              if(device.position == AVCaptureDevicePosition.front) {
      //                  captureDevice = device
                        if captureDevice != nil {
                            print("Capture device found")
                            beginSession()
                        }
      //              }
      //          }
      //      }
      //  }
    }
    
    @IBAction func actionCameraCapture(_ sender: AnyObject) {
        
        print("Camera button pressed")
        saveToCamera()
    }
    
    func beginSession() {
        let photoSettings = AVCapturePhotoSettings(format: [AVVideoCodecKey : AVVideoCodecJPEG])
        
        do {
            try captureSession.addInput(AVCaptureDeviceInput(device: captureDevice))
            // stillImageOutput.outputSettings = [AVVideoCodecKey:AVVideoCodecJPEG]
            //stillImageOutput.capturePhoto(with: photoSettings, delegate: captureDelegate )
            
            if captureSession.canAddOutput(stillImageOutput) {
                captureSession.addOutput(stillImageOutput)
            }
            
        }
        catch {
            print("error: \(error.localizedDescription)")
        }
        
        guard let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession) else {
            print("no preview layer")
            return
        }
        
        self.view.layer.addSublayer(previewLayer)
        previewLayer.frame = self.view.layer.frame
        previewLayer.connection.videoOrientation = AVCaptureVideoOrientation.landscapeRight
        previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        
        
        captureSession.startRunning()
        
        self.view.addSubview(redFilter)
        self.view.addSubview(navigationBar)
        self.view.addSubview(imgOverlay)
        self.view.addSubview(btnCapture)
        self.view.addSubview(map)
        self.view.addSubview(statBar)
        self.view.addSubview(ctlBar)
        self.view.addSubview(compass)
        self.view.addSubview(crs)
        self.view.addSubview(hdg)
        self.view.addSubview(speed)
        self.view.addSubview(ztime)
        self.view.addSubview(depth)
        
    }
    
    func saveToCamera() {
        
        if let videoConnection = stillImageOutput.connection(withMediaType: AVMediaTypeVideo) {
            
          //  stillImageOutput.captureStillImageAsynchronously(from: videoConnection, completionHandler: { (CMSampleBuffer, Error) in
          //      if let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(CMSampleBuffer) {
                    
          //          if let cameraImage = UIImage(data: imageData) {
                        
          //              UIImageWriteToSavedPhotosAlbum(cameraImage, nil, nil, nil)
          //          }
          //      }
          //  })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
