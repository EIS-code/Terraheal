//
//  CustomAlert.swift
//  ModalView
//
//  Created by Aatish Rajkarnikar on 3/20/17.
//  Copyright © 2017 Aatish. All rights reserved.
//

import UIKit
import Photos
import MobileCoreServices


class CustomPhotoPicker: ThemeBottomDialogView {


    @IBOutlet weak var lblTitle: ThemeLabel!

    @IBOutlet weak var btnDone: ThemeButton!
    @IBOutlet weak var vwCamera: UIView!
    @IBOutlet weak var btnCamera: UIButton!
    @IBOutlet weak var lblCamera: ThemeLabel!

    @IBOutlet weak var vwGallary: UIView!
    @IBOutlet weak var btnGallary: UIButton!
    @IBOutlet weak var lblGallary: ThemeLabel!

    var picker: UIImagePickerController! = UIImagePickerController()
    var imageSelected:UploadDocumentDetail?;
    var onBtnCameraTapped: ((_ image: UploadDocumentDetail) -> Void)? = nil
    var onBtnGallaryTapped: ((_ image: UploadDocumentDetail) -> Void)? = nil
    var onBtnDoneTapped: (() -> Void)? = nil
    
    //Animation Properties
    func initialize(title:String,buttonTitle:String,cancelButtonTitle:String) {
        self.initialSetup()
        self.lblTitle.text = title
        self.btnDone.setTitle(buttonTitle, for: .normal)
        if cancelButtonTitle.isEmpty() {
            self.btnCancel.isHidden = true
        } else {
            self.btnCancel.setTitle(cancelButtonTitle, for: .normal)
            self.btnCancel.isHidden = false
        }
    }



    func initialSetup() {
        dialogView.clipsToBounds = true
        self.backgroundColor = .clear
        self.backgroundView.backgroundColor = UIColor.black
        self.backgroundView.alpha = 0.0
        self.backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedOnBackgroundView)))

        self.lblCamera.text = "PHOTO_DIALOG_FROM_CAMERA".localized()
        self.lblCamera.setFont(name: FontName.Bold, size: FontSize.label_18)
        self.lblGallary.text = "PHOTO_DIALOG_FROM_GALLARY".localized()
        self.lblGallary.setFont(name: FontName.Bold, size: FontSize.label_18)

        self.btnDone.setFont(name: FontName.SemiBold, size: FontSize.button_14)
        self.btnDone.setHighlighted(isHighlighted: true)

        self.btnCancel.setFont(name: FontName.Bold, size: FontSize.button_22)

        dialogView.setRound(withBorderColor: .clear, andCornerRadious: 20.0, borderWidth: 1.0)
        self.lblTitle.setFont(name: FontName.SemiBold, size: FontSize.button_22)
        transitionAnimator = UIViewPropertyAnimator.init(duration: 0.25, curve: UIView.AnimationCurve.easeInOut, animations: nil)

        self.addPanGesture(view: dialogView)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }

    @IBAction func btnCameraTapped(_ sender: Any) {
        self.photoFromCamera()
    }

    @IBAction func btnGallaryTapped(_ sender: Any) {
        self.photoFromGallary()
    }

    @IBAction func btnDoneTapped(_ sender: Any) {
            if self.onBtnDoneTapped != nil {
                self.onBtnDoneTapped!();
            }
    }




}

extension CustomPhotoPicker:  UIImagePickerControllerDelegate {
    
     func photoFromGallary() {
            picker.delegate = self
            picker.allowsEditing = false
            picker.sourceType = .savedPhotosAlbum
            picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            DispatchQueue.main.async {
                Common.appDelegate.getTopViewController()?.present(self.picker, animated: true, completion: nil)
        }
    }
    func photoFromCamera() {
        let cameraVC:CameraVC =  CameraVC.fromNib()
        DispatchQueue.main.async {
                Common.appDelegate.getTopViewController()?.present(cameraVC, animated: true, completion: nil)
        }
        //Common.appDelegate.loadCameraVC(navigaionVC: Common.appDelegate.getTopViewController() as! UINavigationController)
        cameraVC.onBtnCaptureTapped = { [weak self] (document)  in
            guard let self = self else {
                return
            }
            self.imageSelected = document
            
            Common.appDelegate.getTopViewController()?.dismiss(animated: true, completion: {
                    if self.onBtnCameraTapped != nil {
                        if let image = self.imageSelected {
                                self.onBtnCameraTapped!(image);
                        }
                        
                    }
            })
        }
        
    }

    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            let fileManager = FileManager.default
            let documentsPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
            let imagePath = documentsPath?.appendingPathComponent("image.jpg")
            var imageName: String = "mydocumentImage"
            if let asset = info[UIImagePickerController.InfoKey.phAsset] as? PHAsset {
                let assetResources = PHAssetResource.assetResources(for: asset)
                print(assetResources.first!.originalFilename)
                if let name  = assetResources.first?.originalFilename {
                    imageName = name
                }
            }

            self.imageSelected = UploadDocumentDetail.init(id: appSingleton.user.id, name: imageName, image: image, data: image.pngData(), isCompleted: true)
        }
        else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            let fileManager = FileManager.default
            let documentsPath = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
            let imagePath = documentsPath?.appendingPathComponent("image.jpg")
            var imageName: String = "mydocumentImage"
            if let asset = info[UIImagePickerController.InfoKey.phAsset] as? PHAsset {
                let assetResources = PHAssetResource.assetResources(for: asset)
                print(assetResources.first!.originalFilename)
                if let name  = assetResources.first?.originalFilename {
                    imageName = name
                }
             }
            self.imageSelected = UploadDocumentDetail.init(id: appSingleton.user.id, name: imageName, image: image, data: image.pngData(), isCompleted: true)
        }
        else {
            imageSelected = nil
        }
        Common.appDelegate.getTopViewController()?.dismiss(animated: true, completion: {
                if self.onBtnGallaryTapped != nil {
                    if let image = self.imageSelected {
                            self.onBtnGallaryTapped!(image);
                    }
                    
                }
        })
    }

    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        Common.appDelegate.getTopViewController()?.dismiss(animated: true, completion: nil)
    }


}

extension CustomPhotoPicker: UIDocumentPickerDelegate, UINavigationControllerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        for url in urls {
            let data = try! Data(contentsOf: url)
            let document: UploadDocumentDetail = UploadDocumentDetail(id: url.absoluteString, name: url.pathComponents.last!,image: nil , data: data,isCompleted: true)
            //self.addFileToArray(document: document)

        }
    }

    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        controller.dismiss(animated: true, completion: nil)
    }

    func openDocumentPicker() {
        let types: [String] = ["public.item"]
        let documentPicker = UIDocumentPickerViewController(documentTypes: types, in: .import)
        documentPicker.delegate = self
        documentPicker.modalPresentationStyle = .formSheet
        Common.appDelegate.getTopViewController()?.present(documentPicker, animated: true, completion: nil)
    }
}
