//
//  CustomAlert.swift
//  ModalView
//
//  Created by Jaydeep Vyas on 3/20/17.
//  Copyright © 2017 Aatish. All rights reserved.
//

import UIKit


class ServiceSelectionDialog: ThemeBottomDialogView {

    @IBOutlet weak var collectionVw: UICollectionView!
    @IBOutlet weak var vwServiceSelection: JDSegmentedControl!
    var selectedService: ServiceType = ServiceType.Massages
    var onBtnDoneTapped: ((_ data: ServiceDetail ) -> Void)? = nil
    @IBOutlet weak var ivMassageCenter: PaddedImageView!
    
    @IBOutlet weak var contentView: UIView!
    var arrForData: [ServiceDetail] = []
    var arrForMassage: [ServiceDetail] = []
    var arrForTherapies: [ServiceDetail] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func initialize(title:String,buttonTitle:String) {

        self.initialSetup()
        self.lblTitle.text = title
        if buttonTitle.isEmpty() {
            self.btnDone.isHidden = true
        } else {
            self.btnDone.setTitle(buttonTitle, for: .normal)
            self.btnDone.isHidden = false
        }
        
    }

    override func initialSetup() {
        super.initialSetup()
        self.dialogView.backgroundColor = .clear
        contentView.clipsToBounds = true
        contentView.setRound(withBorderColor: .clear, andCornerRadious: 20.0, borderWidth: 1.0)
        self.lblTitle.setFont(name: FontName.Bold, size: FontSize.label_22)
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
        self.setDataForStepUpAnimation()
        self.getServiceCenterDetail()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.ivMassageCenter?.layoutIfNeeded()
        self.ivMassageCenter.setRound()
    }

    @IBAction func btnDoneTapped(_ sender: Any) {
            if self.onBtnDoneTapped != nil {
              //  self.onBtnDoneTapped!();
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

}


// MARK: - CollectionView Methods
extension ServiceSelectionDialog:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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

        let serviceDetailVC:  GiftServiceDetailVC =  GiftServiceDetailVC.fromNib()
        serviceDetailVC.modalPresentationStyle = .fullScreen
        serviceDetailVC.serviceDetail = self.arrForData[indexPath.row]
        DispatchQueue.main.async {
               Common.appDelegate.getTopViewController()?.present(serviceDetailVC, animated: true, completion: nil)
            serviceDetailVC.onBtnDoneTapped = { [weak serviceDetailVC, weak self] (data) in
                
                
            guard let self = self else { return } ; print(self)
                self.arrForData[indexPath.row].selectedDuration = data
                serviceDetailVC?.dismiss(animated: true) {
                    if self.onBtnDoneTapped != nil {
                        self.onBtnDoneTapped!(self.arrForData[indexPath.row]);
                    }
                }
                
            }
        }
        
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.bounds.width / 2.0
        return CGSize(width: size , height: size)
    }


}

extension ServiceSelectionDialog {
        func getServiceCenterDetail() {
            AppWebApi.massageCenterDetail { (response) in
                if ResponseModel.isSuccess(response: response) {
                    for data in response.serviceList {
                        self.arrForData.append(data)
                        self.arrForMassage.append(data)
                        self.arrForTherapies.append(data)
                        self.collectionVw.reloadData()
                    }
                }
            }
        }
}
