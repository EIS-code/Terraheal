//
//  CustomAlert.swift
//  ModalView
//
//  Created by Jaydeep Vyas on 3/20/17.
//  Copyright © 2017 Aatish. All rights reserved.
//

import UIKit


class DesignSelectionDialog: ThemeBottomDialogView {

    @IBOutlet weak var collectionVw: UICollectionView!
    var onBtnDoneTapped: (( ) -> Void)? = nil
    var arrForData: [String] = ["","","","","","","","","","","",""]
    @IBOutlet weak var btnThemeType: ThemeButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func initialize(title:String,buttonTitle:String, cancelButtonTitle:String) {
        self.initialSetup()
        self.lblTitle.text = title
        if buttonTitle.isEmpty() {
            self.btnDone.isHidden = true
        } else {
            self.btnDone.setTitle(buttonTitle, for: .normal)
            self.btnDone.isHidden = false
        }
        if cancelButtonTitle.isEmpty() {
            self.btnCancel.isHidden = true
        } else {
            self.btnCancel.setTitle(cancelButtonTitle, for: .normal)
            self.btnCancel.isHidden = false
        }
    }

    override func initialSetup() {
        super.initialSetup()
        self.lblTitle.setFont(name: FontName.Bold, size: FontSize.label_22)
        self.setupCollectionView(collectionView: self.collectionVw)
        self.setDataForStepUpAnimation()
        
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.btnThemeType?.setupFilledButton()
    }

    @IBAction func btnDoneTapped(_ sender: Any) {
            if self.onBtnDoneTapped != nil {
                self.onBtnDoneTapped!();
            }
    }
    
    @IBAction func btnFilterTapped(_ sender: Any) {
        self.openThemeDialog()
    }
    
  
    func openThemeDialog() {
        let alert: CustomThemePicker = CustomThemePicker.fromNib()
        alert.initialize(title: "choose a theme", buttonTitle: "BTN_PROCEED".localized(), cancelButtonTitle: "BTN_CANCEL".localized())
        alert.show(animated: true)
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            alert?.dismiss()
            guard let self = self else { return } ; print(self)
        }
        alert.onBtnDoneTapped = {
            [weak alert, weak self] (data) in
            alert?.dismiss()
            guard let self = self else { return } ; print(self)
            self.btnThemeType.setTitle(data.name, for: .normal)
        }
    }
}


// MARK: - CollectionView Methods
extension DesignSelectionDialog:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private func setupCollectionView(collectionView:  UICollectionView) {
        collectionView.backgroundColor = UIColor.clear
        collectionView.isUserInteractionEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(DesignCltCell.nib()
            , forCellWithReuseIdentifier: DesignCltCell.name)
    }

    // MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrForData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DesignCltCell.name, for: indexPath) as! DesignCltCell
        cell.setData(data: self.arrForData[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.bounds.width / 2.0
        return CGSize(width: size , height: size)
    }


}

