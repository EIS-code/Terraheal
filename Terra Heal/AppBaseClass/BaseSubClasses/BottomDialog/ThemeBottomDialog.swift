//
//  ThemeBottomDialog.swift
//  Terra Heal
//
//  Created by Jaydeep on 09/06/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import Foundation
import UIKit

class ThemeDialogView: ThemeView {
    var isCancellable:Bool = false
    var isAnimated:Bool = false
    deinit {
        print("\(self) \(#function)")
    }
}


class ThemeBottomDialogView: ThemeView {
    
    //Title View
    @IBOutlet weak var lblTitle: ThemeLabel!
    @IBOutlet weak var vwTopBar: UIView!
    @IBOutlet weak var topBarSpace: NSLayoutConstraint!
    //Top Gradient
    @IBOutlet weak var stkHeader: UIView!
    
    //Cancel Button
    @IBOutlet weak var btnCancel: UnderlineTextButton!
    //Done Button
    @IBOutlet weak var btnDone: ThemeButton!
    @IBOutlet weak var btnDoneFloating: FloatingRoundButton!
    @IBOutlet weak var btnNext: ThemeButton!
    //Footer Gradient
    @IBOutlet weak var stkButtons: UIView!
   
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var dialogView: UIView!
    @IBOutlet weak var dialogHeight: NSLayoutConstraint!
    @IBOutlet weak var scrDialogVw: UIScrollView!
    
    var onBtnCancelTapped: (() -> Void)? = nil
    var arrForSteps: [CGFloat]  = []
    //Animation Properties
    var animationDirection: AnimationDirection = .undefined
    var transitionAnimator: UIViewPropertyAnimator? = nil
    var animationProgress: CGFloat = 0
    var yPostion: CGFloat = 0.0
    var isCancellable:Bool = false
    var isAnimated:Bool = false
    var isFixedHeightDialog: Bool = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupTopBar()
        vwTopBar?.backgroundColor = UIColor.themeDarkText
        self.dialogView.clipsToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
       
        self.vwTopBar?.setRound(withBorderColor: .clear, andCornerRadious: 2.5, borderWidth: 1.0)
        self.dialogView?.roundCorners(corners: [.topLeft,.topRight], radius: 40.0)
        self.btnDone?.layoutIfNeeded()
        self.btnDone?.setupFilledButton()
        self.scrDialogVw?.contentInset = UIEdgeInsets(top: (stkHeader?.bounds.height ?? 0) + topBarSpace.constant, left: 0, bottom: stkButtons?.bounds.height ?? 0, right: 0)
    }
    
    deinit {
        print("\(self) \(#function)")
    }
    
    func setupTopBar(isShow:Bool = true, topSpace:CGFloat = 10) {
        self.vwTopBar?.isHidden = !isShow
        self.topBarSpace?.constant = topSpace
    }
    
    func initialSetup() {
        self.lblTitle?.textColor = UIColor.themeDarkText
        self.btnCancel?.setFont(name: FontName.Bold, size: FontSize.button_18)
        self.btnCancel?.setTitleColor(UIColor.themeSecondary, for: .normal)
        self.dialogView.backgroundColor = UIColor.themeDialogBackground
        self.backgroundColor = .clear
        self.backgroundView?.backgroundColor = UIColor.black
        self.backgroundView?.alpha = 0.0
        self.backgroundView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedOnBackgroundView)))
        self.addPanGesture(view: self.dialogView)
        self.transitionAnimator = UIViewPropertyAnimator.init(duration: 0.25, curve: UIView.AnimationCurve.easeInOut, animations: nil)
        self.btnDoneFloating?.setForwardButton()
        self.btnNext?.setFont(name: FontName.SemiBold, size: FontSize.button_14)
        self.btnDone?.setFont(name: FontName.SemiBold, size: FontSize.button_14)
        self.dialogView?.roundCorners(corners: [.topLeft,.topRight], radius: 40.0)
        //self.addBottomFade()
        //self.addTopFade()
    }
    
    func setDialogHeight(height:CGFloat){
        self.dialogHeight?.constant = height
    }
    
    @IBAction func btnCancelTapped(_ sender: Any) {
        if self.onBtnCancelTapped != nil {
            self.onBtnCancelTapped!();
        }
    }
    @objc func didTappedOnBackgroundView(){
        if isCancellable {
            dismiss()
        }
    }

}




