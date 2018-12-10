//
//  ViewController.swift
//  SpekEnBonenScanner
//
//  Created by Geart Otten on 20/09/2018.
//  Copyright © 2018 Geart Otten. All rights reserved.
//

import UIKit
import AVFoundation
import CloudKit

class ScanViewController: UIViewController {
    
//    @IBOutlet var topbar: UIView!
    var captureSession = AVCaptureSession()
    var product: Product!
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var qrCodeFrameView = UIView()
    var scannedBarcode: String = ""
    var foundProduct: String = ""
    var scannedProduct: Product?
    private let supportedCodeTypes = [AVMetadataObject.ObjectType.upce,
                                      AVMetadataObject.ObjectType.code39,
                                      AVMetadataObject.ObjectType.code39Mod43,
                                      AVMetadataObject.ObjectType.code93,
                                      AVMetadataObject.ObjectType.code128,
                                      AVMetadataObject.ObjectType.ean8,
                                      AVMetadataObject.ObjectType.ean13,
                                      AVMetadataObject.ObjectType.aztec,
                                      AVMetadataObject.ObjectType.pdf417,
                                      AVMetadataObject.ObjectType.itf14,
                                      AVMetadataObject.ObjectType.dataMatrix,
                                      AVMetadataObject.ObjectType.interleaved2of5,
                                      AVMetadataObject.ObjectType.qr]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVideo()
        captureSession.startRunning()
//        view.bringSubviewToFront(topbar)
        setupScanView()
        self.navigationItem.backBarButtonItem?.title = " "
        
    }
    
    func setupVideo(){
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .unspecified)
        
        guard let captureDevice = deviceDiscoverySession.devices.first else {
            return
        }
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            
            captureSession.addInput(input)
            
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession.addOutput(captureMetadataOutput)
            
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = supportedCodeTypes
            
        } catch {
            print(error)
            return
        }
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPreviewLayer?.frame = view.layer.bounds
        view.layer.addSublayer(videoPreviewLayer!)
    }
    
    func setupScanView(){
        qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
        qrCodeFrameView.layer.borderWidth = 2
        view.addSubview(qrCodeFrameView)
        view.bringSubviewToFront(qrCodeFrameView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NewBarcodeScannedSegue", let destination = segue.destination as? AddScannedItemViewController{
            destination.barcode = scannedBarcode
        }else if segue.identifier == "ProductInDatabaseSegue", let destination = segue.destination as? GroceryListForChildTableViewController{
            destination.product = product
        }
    }
}

extension ScanViewController: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.count == 0 {
            qrCodeFrameView.frame = CGRect.zero
            return
        }
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        if supportedCodeTypes.contains(metadataObj.type) {
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView.frame = barCodeObject!.bounds
            if metadataObj.stringValue != nil {
                if let product = ProductCache.instance.find(by: metadataObj.stringValue!){
                    self.product = product
                    self.performSegue(withIdentifier: "ProductInDatabaseSegue", sender: self)
                    
                }else{
                    scannedBarcode = metadataObj.stringValue!
                    performSegue(withIdentifier: "NewBarcodeScannedSegue", sender: self)
                }
            captureSession.stopRunning()
            }
        }
    }
}
