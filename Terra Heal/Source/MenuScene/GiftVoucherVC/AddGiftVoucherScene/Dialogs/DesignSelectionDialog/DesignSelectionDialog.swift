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
    var onBtnDoneTapped: ((_ data: Theme,_ id:String ) -> Void)? = nil
    var arrForData: [Design] = []
    var arrForOriginalData: [GiftDesign] = []
    var arrForThemeSelection: [Theme] = []
    
    var selectedTheme: GiftDesign? = nil
    var selectedDesign: Design? = nil
    
    @IBOutlet weak var btnThemeType: DialogFilledRoundedButton!
    
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
        self.getDesignList()
    }
    
    override func initialSetup() {
        super.initialSetup()
        self.lblTitle.setFont(name: FontName.Bold, size: FontSize.header)
        self.setupCollectionView(collectionView: self.collectionVw)
        self.setDataForStepUpAnimation()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    @IBAction func btnDoneTapped(_ sender: Any) {
        if let theme = selectedTheme,let design = selectedDesign {
            if self.onBtnDoneTapped != nil {
                self.onBtnDoneTapped!(theme.toTheme(), design.id);
            }
        } else {
            Common.showAlert(message: "Select Theme and Design First")
        }
        
    }
    
    @IBAction func btnFilterTapped(_ sender: Any) {
        self.openThemeDialog()
    }
    
    
    func openThemeDialog() {
        let alert: CustomThemePicker = CustomThemePicker.fromNib()
        alert.initialize(title: "choose a theme", buttonTitle: "BTN_PROCEED".localized(), cancelButtonTitle: "BTN_CANCEL".localized())
        alert.setDataSource(themeDesign: arrForThemeSelection)
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
            self.filterSelectedDesign(id: data.id)
            
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
        
        for i in 0..<arrForData.count {
            arrForData[i].isSelected = false
        }
        self.arrForData[indexPath.row].isSelected = true
        self.selectedDesign = self.arrForData[indexPath.row]
        self.collectionVw.reloadData()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.bounds.width / 2.0
        return CGSize(width: size , height: size)
    }
}
//MARK: Web Service Call
extension DesignSelectionDialog {
    
    func getDesignList() {
        AppWebApi.getGiftDesignList { (response) in
            if ResponseModel.isSuccess(response: response) {
                self.arrForOriginalData.removeAll()
                for giftDesign in response.giftDesignList {
                    self.arrForOriginalData.append(giftDesign)
                    self.arrForThemeSelection.append(giftDesign.toTheme())
                }
                if !self.arrForOriginalData.isEmpty {
                    self.filterSelectedDesign(id: (self.arrForOriginalData.first?.id) ?? "")
                }
            }
        }
    }
    
    func filterSelectedDesign(id:String) {
        self.arrForData.removeAll()
        if let gift = self.arrForOriginalData.first(where: { (gift) -> Bool in
            return gift.id == id
        }) {
            for design in  gift.designs {
                self.arrForData.append(design)
            }
            self.selectedTheme = gift
        }
        
        self.collectionVw.reloadData()
    }
    
    
}
