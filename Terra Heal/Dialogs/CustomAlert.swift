//
//  CustomAlert.swift
//  ModalView
//
//  Created by Aatish Rajkarnikar on 3/20/17.
//  Copyright © 2017 Aatish. All rights reserved.
//

import UIKit

class CustomAlert: UIView {


    @IBOutlet weak var dialogView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var lblMessage: ThemeLabel!
    @IBOutlet weak var backgroundView: UIView!




    
    func initialize(message:String) {
        dialogView.clipsToBounds = true
        self.lblMessage.setFont(name: FontName.Ovo, size: FontSize.label_26)

        self.backgroundView.backgroundColor = UIColor.black
        self.backgroundView.alpha = 0.6
       self.backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedOnBackgroundView)))
        lblMessage.text = message
        dialogView.setRound(withBorderColor: .clear, andCornerRadious: 10.0, borderWidth: 1.0)

    }

    func show(animated:Bool){
        self.backgroundColor = .clear
        self.backgroundView.alpha = 0
        self.frame = UIScreen.main.bounds
        if var topController = UIApplication.shared.delegate?.window??.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            topController.view.addSubview(self)
        }

        self.backgroundView.alpha = 0.66
    }

    func dismiss(animated:Bool){
        if animated {
            UIView.animate(withDuration: 0.33, animations: {
                self.backgroundView.alpha = 0
            }, completion: { (completed) in

            })
            UIView.animate(withDuration: 0.33, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 10, options: UIView.AnimationOptions(rawValue: 0), animations: {

            }, completion: { (completed) in
                self.removeFromSuperview()
            })
        }else{
            self.removeFromSuperview()
        }

    }
    @objc func didTappedOnBackgroundView(){
        //dismiss(animated: true)
    }
    @IBAction func btnCalcelTapped(_ sender: Any) {
         dismiss(animated: true)
    }

}
