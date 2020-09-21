//
//  CustomAlert.swift
//  ModalView
//
//  Created by Jaydeep Vyas on 3/20/17.
//  Copyright © 2017 Aatish. All rights reserved.
//

import UIKit



class PricingDurationSelectionDialog: ThemeBottomDialogView {
    
    
    @IBOutlet weak var lblMessage: ThemeLabel!
    @IBOutlet weak var collectionVw: UICollectionView!
    @IBOutlet weak var vwTab: UIView!
    @IBOutlet weak var vwHome: UIView!
    @IBOutlet weak var vwTherapist: UIView!
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet weak var btnTherapist: UIButton!
    
    var onBtnDoneTapped: ((_ data:ServiceDurationDetail) -> Void)? = nil
    var selectedData:ServiceDurationDetail = ServiceDurationDetail.init(fromDictionary: [:])
    var arrForData: [ServiceDurationDetail] =  ServiceDurationDetail.getDemoArray()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func initialize(title:String, message:String, buttonTitle:String,cancelButtonTitle:String) {
        self.initialSetup()
        self.lblTitle.text = title
        if cancelButtonTitle.isEmpty() {
            self.btnCancel.isHidden = true
        } else {
            self.btnCancel.setTitle(cancelButtonTitle, for: .normal)
            self.btnCancel.isHidden = false
        }
        if message.isEmpty() {
            self.lblMessage.isHidden = true
        } else {
            self.lblMessage.text = message
            self.lblMessage.isHidden = false
        }
        if buttonTitle.isEmpty() {
            self.btnDone.isHidden = true
        } else {
            self.btnDone.setTitle(buttonTitle, for: .normal)
            self.btnDone.isHidden = false
        }
        self.setupCollectionView(collectionView: self.collectionVw)
        
    }
    
    func select(data:ServiceDurationDetail) {
        self.selectedData = data
        for i in 0..<arrForData.count {
            arrForData[i].isSelected = false
            if arrForData[i].id == data.id {
                arrForData[i].isSelected = true
            }
        }
        self.collectionVw.reloadData()
    }
    
    func setDataSource(data: [ServiceDurationDetail]) {
        self.arrForData.removeAll()
        for value in data {
            self.arrForData.append(value)
            if value.isSelected {
                self.selectedData = value
            }
        }
        self.collectionVw.reloadData()
    }
    override func initialSetup() {
        super.initialSetup()
        self.lblTitle.setFont(name: FontName.Bold, size: FontSize.header)
        self.lblMessage.setFont(name: FontName.SemiBold, size:
            FontSize.small)
        self.setDataForStepUpAnimation()
        self.btnHomeTapped(btnHome)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.collectionVw.reloadData()
        self.vwTab.setRound(withBorderColor: .clear, andCornerRadious: 10.0, borderWidth: 1.0)
        self.vwHome.setRound(withBorderColor: .clear, andCornerRadious: 10.0, borderWidth: 1.0)
        self.vwTherapist.setRound(withBorderColor: .clear, andCornerRadious: 10.0, borderWidth: 1.0)
        
    }
    
    @IBAction func btnDoneTapped(_ sender: Any) {
        if selectedData.id.isEmpty() {
            Common.showAlert(message: "Please select duration")
        } else  {
            if self.onBtnDoneTapped != nil {
                self.onBtnDoneTapped!(selectedData);
            }
        }
    }
    @IBAction func btnHomeTapped(_ sender: UIButton) {
        self.vwHome.visible()
        self.vwTherapist.gone()
        self.btnHome.isSelected = true
        self.btnTherapist.isSelected = false
    }
    @IBAction func btnTherapistTapped(_ sender: Any) {
        self.vwHome.gone()
        self.vwTherapist.visible()
        self.btnTherapist.isSelected = true
        self.btnHome.isSelected = false
    }
    
}

// MARK: - CollectionView Methods
extension PricingDurationSelectionDialog:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private func setupCollectionView(collectionView:  UICollectionView) {
        collectionView.backgroundColor = UIColor.clear
        collectionView.isUserInteractionEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PricingDurationCltCell.nib()
            , forCellWithReuseIdentifier: PricingDurationCltCell.name)
        
    }
    
    // MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrForData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PricingDurationCltCell.name, for: indexPath) as! PricingDurationCltCell
        cell.setData(data: self.arrForData[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        for i in 0..<arrForData.count {
            self.arrForData[i].isSelected = false
        }
        self.arrForData[indexPath.row].isSelected = true
        self.selectedData = self.arrForData[indexPath.row]
        self.collectionVw.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.bounds.width / 2.0 
        return CGSize(width: size , height:size)
    }
}

