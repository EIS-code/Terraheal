//
//  CustomAlert.swift
//  ModalView
//
//  Created by Aatish Rajkarnikar on 3/20/17.
//  Copyright © 2017 Aatish. All rights reserved.
//

import UIKit

class CustomAlert: ThemeDialogView {

    @IBOutlet weak var dialogView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var lblMessage: ThemeLabel!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var animationVw: UIView!
    var onBtnCancelTapped : (() -> Void)? = nil


    func initialize(message:String) {
        self.initialSetup()
        self.lblMessage.setFont(name: FontName.Ovo, size: FontSize.label_26)
        lblMessage.text = message
    }

    func initialSetup() {
        dialogView.clipsToBounds = true
        self.backgroundColor = .clear
        self.backgroundView.backgroundColor = UIColor.black
        self.backgroundView.alpha = 0.0
        self.backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedOnBackgroundView)))
        dialogView.setRound(withBorderColor: .clear, andCornerRadious: 10.0, borderWidth: 1.0)
    }

    func show(animated:Bool){

        self.isAnimated = animated
        self.backgroundView.alpha = 0
        self.frame = UIScreen.main.bounds
        if let topController = Common.appDelegate.getTopViewController() {
            topController.view.addSubview(self)
        }

        if animated {
            self.isUserInteractionEnabled = false
            self.animationVw.alpha = 0.5
            self.animationVw.transform = CGAffineTransform(translationX: self.frame.midX, y: 0)
            UIView.animate(withDuration: 0.35, delay: 0, options: [.curveEaseOut], animations: {
                self.animationVw.transform = CGAffineTransform.identity
                self.backgroundView.alpha = 0.66
                self.animationVw.alpha = 1.0
            }) { (completion) in
               // self.animationVw.shake()
                self.isUserInteractionEnabled = true
            }
        }
        else {
            self.backgroundView.alpha = 0.66
        }

    }

    func dismiss(){
        if self.isAnimated {
            self.animationVw.transform = CGAffineTransform.identity
            self.backgroundView.alpha = 0.66
            self.animationVw.alpha = 1.0
            UIView.animate(withDuration: 0.35, delay: 0.0, options: [.curveEaseOut], animations: {
                self.animationVw.transform = CGAffineTransform(translationX: self.frame.midX, y: 0)
                self.backgroundView.alpha = 0.0
                self.animationVw.alpha = 0.5

            }) { (completion) in
                self.removeFromSuperview()
            }
        }else{
            self.removeFromSuperview()
        }
    }

    @objc func didTappedOnBackgroundView(){
        if isCancellable {
            dismiss()
        }
    }

    @IBAction func btnCalcelTapped(_ sender: Any) {
        if self.onBtnCancelTapped != nil
        {
            self.onBtnCancelTapped!();
            
        }

    }

}
