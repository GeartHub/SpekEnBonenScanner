//
//  ViewController.swift
//  SpekEnBonenScanner
//
//  Created by Geart Otten on 20/09/2018.
//  Copyright © 2018 Geart Otten. All rights reserved.
//

import UIKit
import AVFoundation
import CoreData

class ScannerController: UIViewController {
    
    @IBOutlet var topbar: UIView!
    
    var captureSession = AVCaptureSession()
    
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var qrCodeFrameView = UIView()
    var scannedBarcode: String = ""
    var foundProduct: String = ""
    
    @IBOutlet weak var productNameLabel: UILabel!
    var products: [Product] = []
    
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
        
        fetchProducts()
        // Get the back-facing camera for capturing videos
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .unspecified)
        
        guard let captureDevice = deviceDiscoverySession.devices.first else {
            print("Failed to get the camera device")
            return
        }
        
        do {
            // Get an instance of the AVCaptureDeviceInput class using the previous device object.
            let input = try AVCaptureDeviceInput(device: captureDevice)
            
            // Set the input device on the capture session.
            captureSession.addInput(input)
            
            // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession.addOutput(captureMetadataOutput)
            
            // Set delegate and use the default dispatch queue to execute the call back
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = supportedCodeTypes
            
        } catch {
            // If any error occurs, simply print it out and don't continue any more.
            print(error)
            return
        }
        
        // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPreviewLayer?.frame = view.layer.bounds
        view.layer.addSublayer(videoPreviewLayer!)
        
        // Start video capture.
        captureSession.startRunning()
        
        // Move the message label and top bar to the front
        view.bringSubviewToFront(topbar)
        view.bringSubviewToFront(productNameLabel)
        
        // Initialize QR Code Frame to highlight the QR code
        
        qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
        qrCodeFrameView.layer.borderWidth = 2
        view.addSubview(qrCodeFrameView)
        view.bringSubviewToFront(qrCodeFrameView)
        self.view.bringSubviewToFront(self.productNameLabel)

    }
    func fetchProducts(){
        let context = CoreDataStack.context
        do {
            products = try context.fetch(Product.fetchRequest())
        }
        catch{
            print("Cant find any products")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NewBarcodeScannedSegue", let destination = segue.destination as? AddScannedItemViewController{
            destination.barcode = scannedBarcode
        }else if segue.identifier == "ProductFoundSegue", let destination = segue.destination as? GroceryListTableViewController{
            destination.productName = foundProduct
            destination.product = scannedProduct
        }
    }
}

extension ScannerController: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        // Check if the metadataObjects array is not nil and it contains at least one object.
            if metadataObjects.count == 0 {
                qrCodeFrameView.frame = CGRect.zero
                return
            }
        
            // Get the metadata object.
            let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
            if supportedCodeTypes.contains(metadataObj.type) {
                // If the found metadata is equal to the code metadata then update the status label's text and set the bounds
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView.frame = barCodeObject!.bounds
            if metadataObj.stringValue != nil {
                let product = products.first(where: {$0.barcode == metadataObj.stringValue})
                scannedBarcode = metadataObj.stringValue!
                if product != nil{
                    UIView.animate(withDuration: 0.5, animations: {
                        self.productNameLabel.text  = product?.name
                        
                        self.productNameLabel.alpha = 1
                        self.foundProduct = (product?.name)!
                        
                        self.scannedProduct?.name = product?.name
                        self.scannedProduct?.barcode = product?.barcode
                        
                    }, completion: { (Value: Bool) in
                        self.performSegue(withIdentifier: "ProductFoundSegue", sender: self)
                        })
                }else{
                    performSegue(withIdentifier: "NewBarcodeScannedSegue", sender: self)
                }
                captureSession.stopRunning()

            }
        }
    }
}
