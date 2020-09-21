//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit
import AVFoundation



class ScanSelfieVC: BaseVC, AVCapturePhotoCaptureDelegate {



    @IBOutlet weak var btnScanNow: FilledRoundedButton!
    @IBOutlet weak var lblHeader: ThemeLabel!
    @IBOutlet var previewView: UIView!


    var captureSession: AVCaptureSession!
    var stillImageOutput: AVCapturePhotoOutput!
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    var capturedFrontImage: UIImage? = nil
    var capturedBackImage: UIImage? = nil

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }


    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: Setup

    private func setup() {

    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialViewSetup()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.previewView?.setRound(withBorderColor: .clear, andCornerRadious: 10.0, borderWidth: 1.0)
    }

    private func initialViewSetup() {
      
        self.setBackground(color: UIColor.themeBackground)
        self.lblHeader?.text = "SCAN_PASSPORT_LBL_TITLE".localized()
        self.lblHeader?.setFont(name: FontName.SemiBold, size: FontSize.subHeader)
        self.btnScanNow?.setTitle("SCAN_PASSPORT_BTN_SCAN_NOW".localized(), for: .normal)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.updateuiForFrontImage()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.captureSession.stopRunning()
    }
    // MARK: - Action Methods
    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
        _ = (self.navigationController as? NC)?.popVC()
    }

    @IBAction func btnScanTapped(_ sender: Any) {
        let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
        stillImageOutput?.capturePhoto(with: settings, delegate: self)

        if capturedFrontImage == nil {
            self.capturedFrontImage = UIImage()
            Common.appDelegate.loadMainVC()
        }
    }

    func setupLivePreview() {

        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)

        videoPreviewLayer.videoGravity = .resizeAspect
        videoPreviewLayer.connection?.videoOrientation = .portrait
        previewView.layer.addSublayer(videoPreviewLayer)

        //Step12
    }


    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {

        guard let imageData = photo.fileDataRepresentation()
            else { return }

        if let image = UIImage(data: imageData) {
            if capturedFrontImage == nil {
                self.capturedFrontImage = image
            }
        }

    }

    func startCamera() {
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .medium
        guard let backCamera = AVCaptureDevice.default(for: AVMediaType.video)
            else {

                let alert: CustomAlert = CustomAlert.fromNib()
                alert.initialize(message: "Unable to access back camera!".localized())
                alert.show(animated: true)
                alert.onBtnCancelTapped = {
                    [weak alert, weak self] in
                    guard let self = self else { return } ; print(self)
                    alert?.dismiss()
                }
                return
        }
        do {
            let input = try AVCaptureDeviceInput(device: backCamera)
            if captureSession.canAddInput(input) && captureSession.canAddOutput(stillImageOutput) {
                captureSession.addInput(input)
                captureSession.addOutput(stillImageOutput)
                setupLivePreview()
            }
        }
        catch let error  {
            print("Error Unable to initialize back camera:  \(error.localizedDescription)")
            let alert: CustomAlert = CustomAlert.fromNib()
            alert.initialize(message: "Error Unable to initialize back camera:  \(error.localizedDescription)")
            alert.show(animated: true)
            alert.onBtnCancelTapped = {
                [weak alert, weak self] in
                guard let self = self else { return } ; print(self)
                alert?.dismiss()
            }
            return
        }
        stillImageOutput = AVCapturePhotoOutput()
        DispatchQueue.global(qos: .userInitiated).async { //[weak self] in
            self.captureSession.startRunning()
            DispatchQueue.main.async {
                self.videoPreviewLayer.frame = self.previewView.bounds
            }
        }

    }

    func updateuiForFrontImage() {
        self.lblHeader?.text = "SELFIE_SCAN_LBL_INFO".localized()
        self.lblHeader?.setFont(name: FontName.Regular, size: FontSize.subHeader)
        self.startCamera()
    }


}
