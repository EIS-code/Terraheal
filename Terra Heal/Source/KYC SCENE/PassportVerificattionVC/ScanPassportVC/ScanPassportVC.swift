//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit
import AVFoundation



class ScanPassportVC: MainVC, AVCapturePhotoCaptureDelegate {



    @IBOutlet weak var btnScanNow: ThemeButton!
    @IBOutlet weak var lblHeader: ThemeLabel!
    @IBOutlet var previewView: UIView!
    @IBOutlet weak var progressBar: UIProgressView!


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
        self.updateuiForFrontImage()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.btnScanNow?.setupFilledButton()
         self.previewView?.setRound(withBorderColor: .clear, andCornerRadious: 10.0, borderWidth: 1.0)
    }

    private func initialViewSetup() {
        
        self.setBackground(color: UIColor.themeBackground)
        self.lblHeader?.text = "SCAN_PASSPORT_LBL_TITLE".localized()
        self.lblHeader?.setFont(name: FontName.SemiBold, size: FontSize.label_26)
        self.btnScanNow?.setTitle("SCAN_PASSPORT_BTN_SCAN_NOW".localized(), for: .normal)
        self.btnScanNow?.setFont(name: FontName.Regular, size: FontSize.button_18)
        self.progressBar?.progress = 0.0

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
      //  self.updateuiForFrontImage()
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
            self.progressBar.progress = 0.5
            self.updateUiForBackImage()

        } else {
            self.capturedBackImage = UIImage()
            self.progressBar.progress = 1.0
            Common.appDelegate.loadKycInfoVC(navigaionVC: self.navigationController)
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
                self.progressBar.progress = 0.5
                self.updateUiForBackImage()
            } else {
                self.capturedBackImage = image
                self.progressBar.progress = 1.0
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
                    [weak alert/*,weak self*/] in
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
            let alert: CustomAlert = CustomAlert.fromNib()
            alert.initialize(message: "Error Unable to initialize back camera:  \(error.localizedDescription)")
            alert.show(animated: true)
            alert.onBtnCancelTapped = {
                [weak alert/*,weak self*/] in
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
        self.lblHeader?.text = "SCAN_PASSPORT_LBL_FRONT_SIDE".localized()
        self.lblHeader?.setFont(name: FontName.SemiBold, size: FontSize.label_26)
        self.startCamera()
    }

    func updateUiForBackImage() {
        self.captureSession?.stopRunning()
        self.startCamera()
        self.lblHeader?.setTextWithAnimation(text: "SCAN_PASSPORT_LBL_BACK_SIDE".localized()) 
        self.lblHeader?.setFont(name: FontName.SemiBold, size: FontSize.label_26)
    }
}
