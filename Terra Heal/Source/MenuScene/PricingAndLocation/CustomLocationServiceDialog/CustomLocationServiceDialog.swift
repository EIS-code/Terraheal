//
//  CustomAlert.swift
//  ModalView
//
//  Created by Jaydeep Vyas on 3/20/17.
//  Copyright © 2017 Aatish. All rights reserved.
//

import UIKit

enum ServiceType: Int {
    case Massages = 0
    case Therapies = 1
}
class CustomLocationServiceDialog: ThemeBottomDialogView {

    @IBOutlet weak var lblTitle: ThemeLabel!
    @IBOutlet weak var btnDone: ThemeButton!
    @IBOutlet weak var collectionVw: UICollectionView!
    @IBOutlet weak var vwServiceSelection: JDSegmentedControl!
    var selectedService: ServiceType = ServiceType.Massages
    var onBtnDoneTapped: (( ) -> Void)? = nil
    
    var arrForData: [String] = ["head, neck and shoulders", "tok sen - thai massage", "hand or foot massage","thai yoga massage","head, neck and shoulders", "tok sen - thai massage", "hand or foot massage","thai yoga massage"]
    
     var arrForMassage: [String] = ["head, neck massage", "tok sen - thai massage", "hand or foot massage","thai yoga massage","head, neck and shoulders", "tok sen - thai massage", "hand or foot massage","thai yoga massage"]
     var arrForTherapies: [String] = ["head, neck therapy", "tok sen - thai therapy", "hand or foot therapy","thai yoga therapy","head, neck and therapy", "tok sen - thai therapy", "hand or foot therapy","thai yoga therapy"]
    
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
        if buttonTitle.isEmpty() {
            self.btnDone.isHidden = true
        } else {
            self.btnDone.setTitle(buttonTitle, for: .normal)
            self.btnDone.isHidden = false
        }
        
    }

    func initialSetup() {
        dialogView.clipsToBounds = true
        self.backgroundColor = .clear

        self.backgroundView.backgroundColor = UIColor.black
        self.backgroundView.alpha = 0.0
        self.backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedOnBackgroundView)))
        dialogView.setRound(withBorderColor: .clear, andCornerRadious: 20.0, borderWidth: 1.0)
        self.lblTitle.setFont(name: FontName.Bold, size: FontSize.label_26)
        self.addPanGesture(view: self)
        self.btnDone.setFont(name: FontName.SemiBold, size: FontSize.button_14)
        self.btnCancel.setFont(name: FontName.Bold, size: FontSize.button_22)
        self.btnDone.setHighlighted(isHighlighted: true)
        transitionAnimator = UIViewPropertyAnimator.init(duration: 0.25, curve: UIView.AnimationCurve.easeInOut, animations: nil)
        self.setupCollectionView(collectionView: self.collectionVw)
        self.vwServiceSelection.allowChangeThumbWidth = false
        self.vwServiceSelection.itemTitles = ["massages".localized(),"therapies".localized()]
        self.vwServiceSelection.changeBackgroundColor(UIColor.themeLightTextColor)
        self.vwServiceSelection.didSelectItemWith = { [weak self] (index,title) in
            guard let self = self else {
                return
            }

            if index == 0 {
                self.massagesTapped()
            } else {
                self.therapiesTapped()
            }
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.btnDone?.layoutIfNeeded()
        self.btnDone?.setHighlighted(isHighlighted: true)
    }

    @IBAction func btnDoneTapped(_ sender: Any) {
            if self.onBtnDoneTapped != nil {
                self.onBtnDoneTapped!();
            }
    }

    func setServicesFor(type:ServiceType) {
        if type == .Massages {
            self.massagesTapped()
        } else {
            self.therapiesTapped()
        }
    }
    
    func massagesTapped(){
        self.arrForData = self.arrForMassage
        self.vwServiceSelection.selectItemAt(index: 0)
        self.selectedService = ServiceType.Massages
        collectionVw.reloadData()
    }
    
    func therapiesTapped(){
        self.arrForData = self.arrForTherapies
        self.vwServiceSelection.selectItemAt(index: 1)
        self.selectedService = ServiceType.Therapies
        collectionVw.reloadData()
    }

    
    
    func openFAQdetailsDialog(index: Int) {
        let alert: CustomInformationDialog = CustomInformationDialog.fromNib()
        alert.initialize(title: arrForData[index], data: "FAQ_CONTENT".localized(), buttonTitle: "".localized(), cancelButtonTitle: "".localized())
        alert.show(animated: true)
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            guard let self = self else { return } ; print(self)
            alert?.dismiss()
        }
        alert.onBtnDoneTapped = {
            [weak alert, weak self]  in
            guard let self = self else { return } ; print(self)
            alert?.dismiss()

        }
    }

}


// MARK: - CollectionView Methods
extension CustomLocationServiceDialog:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private func setupCollectionView(collectionView:  UICollectionView) {
        collectionView.backgroundColor = UIColor.clear
        collectionView.isUserInteractionEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(LocationServiceCltCell.nib()
            , forCellWithReuseIdentifier: LocationServiceCltCell.name)

    }

    // MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrForData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LocationServiceCltCell.name, for: indexPath) as! LocationServiceCltCell
        cell.setData(data: self.arrForData[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        self.openFAQdetailsDialog(index: indexPath.row)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.bounds.width / 2.0
        return CGSize(width: size , height: size)
    }


}
