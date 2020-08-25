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
    @IBOutlet weak var ivForDocument: UIImageView!
    
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
    }
    // MARK: - Action Methods
    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
        _ = (self.navigationController as? NC)?.popVC()
    }
    
    @IBAction func btnScanTapped(_ sender: Any) {
        
        if capturedBackImage != nil && capturedBackImage != nil {
            Common.appDelegate.loadKycInfoVC(navigaionVC: self.navigationController)
        } else {
            if capturedFrontImage == nil {
                self.capturedFrontImage = UIImage()
                self.progressBar.progress = 0.5
                self.photoFromCamera()
                //self.updateUiForBackImage()
                
            } else {
                self.capturedBackImage = UIImage()
                self.progressBar.progress = 1.0
                self.photoFromCamera()
            }
        }
        
    }
    
    func updateuiForFrontImage() {
        self.lblHeader?.text = "SCAN_PASSPORT_LBL_FRONT_SIDE".localized()
        self.lblHeader?.setFont(name: FontName.SemiBold, size: FontSize.label_26)
        
    }
    
    func photoFromCamera() {
        let cameraVC:CameraVC =  CameraVC.fromNib()
        cameraVC.modalPresentationStyle = .fullScreen
        DispatchQueue.main.async {
            Common.appDelegate.getTopViewController()?.present(cameraVC, animated: true, completion: nil)
        }
        
        cameraVC.onBtnCaptureTapped = { [weak self] (document)  in
            guard let self = self else {
                return
            }
            if let image = UIImage(data: document.data ?? Data()) {
                if self.capturedFrontImage == nil {
                    self.capturedFrontImage = image
                    self.ivForDocument.image = image
                    self.progressBar.progress = 0.5
                    self.updateUiForBackImage()
                } else {
                    self.capturedBackImage = image
                    self.ivForDocument.image = image
                    self.progressBar.progress = 1.0
                }
            }
            Common.appDelegate.getTopViewController()?.dismiss(animated: true, completion: {
            })
        }
        
    }
    
    func updateUiForBackImage() {
        self.lblHeader?.setTextWithAnimation(text: "SCAN_PASSPORT_LBL_BACK_SIDE".localized())
        self.lblHeader?.setFont(name: FontName.SemiBold, size: FontSize.label_26)
    }
}
