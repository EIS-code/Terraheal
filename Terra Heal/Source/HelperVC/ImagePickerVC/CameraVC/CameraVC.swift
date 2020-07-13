//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit
import Photos


class CameraVC: MainVC {
    
    @IBOutlet weak var btnCaptureNow: FloatingRoundButton!
    @IBOutlet weak var lblMsg: ThemeLabel!
    @IBOutlet weak var vwHintLayer: UIView!
    @IBOutlet weak var imgHint: UIImageView!
    @IBOutlet fileprivate var capturePreviewView: UIView!
    @IBOutlet fileprivate var photoModeButton: UIButton!
    @IBOutlet fileprivate var toggleCameraButton: UIButton!
    @IBOutlet fileprivate var toggleFlashButton: UIButton!
    @IBOutlet fileprivate var videoModeButton: UIButton!
    
    let cameraController = CameraController()
    var uploadeDocument: UploadDocumentDetail = UploadDocumentDetail.init()
    var onBtnCaptureTapped: ((_ image: UploadDocumentDetail) -> Void)? = nil
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    override var prefersStatusBarHidden: Bool { return true }
    
    // MARK: Setup
    
    private func setup() {
        
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        func configureCameraController() {
            cameraController.prepare {(error) in
                if let error = error {
                    print(error)
                    Common.showAlert(message: error.localizedDescription)
                }
                
                try? self.cameraController.displayPreview(on: self.capturePreviewView)
            }
        }
        configureCameraController()
        self.initialViewSetup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    func showHint(messae:String,image:String) {
        self.lblMsg.text = messae
        self.imgHint.image = UIImage.init(named: image)
        self.vwHintLayer.isHidden = false
    }
    func hideHint() {
        self.vwHintLayer.isHidden = true
    }
    private func initialViewSetup() {
        self.lblMsg?.setFont(name: FontName.SemiBold, size: FontSize.label_26)
        self.showHint(messae: "CAMERA_LBL_MESSAGE".localized(), image: "asset-face")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    // MARK: - Action Methods
    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
        if let nc = self.navigationController {
                nc.popViewController(animated: true)
        } else {
            self.dismiss(animated: true) {
                
            }
        }
        
    }
    
    @IBAction func toggleFlash(_ sender: UIButton) {
        if cameraController.flashMode == .on {
            cameraController.flashMode = .off
            toggleFlashButton.setImage(#imageLiteral(resourceName: "Flash Off Icon"), for: .normal)
        }
            
        else {
            cameraController.flashMode = .on
            toggleFlashButton.setImage(#imageLiteral(resourceName: "Flash On Icon"), for: .normal)
        }
    }
    
    @IBAction func switchCameras(_ sender: UIButton) {
        do {
            try cameraController.switchCameras()
        }
            
        catch {
            print(error)
        }
        
        switch cameraController.currentCameraPosition {
        case .some(.front):
            toggleCameraButton.setImage(#imageLiteral(resourceName: "Front Camera Icon"), for: .normal)
            
        case .some(.rear):
            toggleCameraButton.setImage(#imageLiteral(resourceName: "Rear Camera Icon"), for: .normal)
            
        case .none:
            return
        }
    }
    
    @IBAction func captureImage(_ sender: UIButton) {
        cameraController.captureImage {(image, error) in
            guard let image = image else {
                
                Common.showAlert(message: error?.localizedDescription ?? "Image capture error" )
                return
            }
            try? PHPhotoLibrary.shared().performChangesAndWait {
                PHAssetChangeRequest.creationRequestForAsset(from: image)
            }
            self.uploadeDocument.image = image
            self.uploadeDocument.name = appSingleton.user.name
            self.uploadeDocument.id = appSingleton.user.id
            if self.onBtnCaptureTapped != nil {
                self.onBtnCaptureTapped!(self.uploadeDocument);
            }
        }
    }
    
}

