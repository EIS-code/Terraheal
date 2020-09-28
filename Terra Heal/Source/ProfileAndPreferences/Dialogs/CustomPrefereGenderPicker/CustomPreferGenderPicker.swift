//
//  CustomAlert.swift
//  ModalView
//
//  Created by Jaydeep Vyas on 3/20/17.
//  Copyright © 2017 Jaydeep. All rights reserved.
//

import UIKit

enum PreferGender: String {
    case MaleOnly  = "male"
    case FemaleOnly  = "female"
    case PreferMale  = "prefer male"
    case PrefereFemale  = "prefere female"
    case NoPreference  = "noPreference"

    func name()-> String {
        switch self {
        // Use Internationalization, as appropriate.
        case .MaleOnly: return "GENDER_MALE_ONLY".localized()
        case .FemaleOnly: return "GENDER_FEMALE_ONLY".localized()
        case .PreferMale: return "GENDER_PREFER_MALE".localized()
        case .PrefereFemale: return "GENDER_PREFER_FEMALE".localized()
        default: return "GENDER_NO_PREFERENCE".localized()
        }
    }

}

struct GenderDetail {
    var type: PreferGender = PreferGender.MaleOnly
    var name: String = ""
    var isSelected: Bool = false
}


class CustomPreferGenderPicker: ThemeBottomDialogView {

    @IBOutlet weak var hTblVw: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblRepeatRequest: ThemeLabel!
    @IBOutlet weak var cltVw: UICollectionView!
    @IBOutlet weak var vwForRepeatRequest: UIView!
    
    var onBtnDoneTapped: ((_ gender:PreferenceOption) -> Void)? = nil
    var selectedData: PreferenceOption = PreferenceOption.init(fromDictionary: [:])
    var arrForData: [PreferenceOption] = []
    var arrForTherapist: [MyTherapistDetail] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func initialize(title:String,buttonTitle:String,cancelButtonTitle:String) {
        self.initialSetup()
        self.lblTitle.text = title
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
        self.select(data: self.selectedData)
        self.setupTableView(tableView: self.tableView)

    }

    func select(data:PreferenceOption) {
        self.selectedData = data
        for i in 0..<arrForData.count {
            arrForData[i].isSelected = false
            if arrForData[i].id == data.id {
                arrForData[i].isSelected = true
            }
        }
        self.tableView.reloadData()
    }
    func setDataSource(data:  [PreferenceOption]) {
        self.arrForData.removeAll()
        for option in data {
            self.arrForData.append(option)
            if option.isSelected {
                self.selectedData = option
            }
        }
        self.select(data:self.selectedData)
    }
    
    override func initialSetup() {
        super.initialSetup()
        self.lblTitle.setFont(name: FontName.Bold, size: FontSize.header)
        self.lblRepeatRequest.setFont(name: FontName.SemiBold, size: FontSize.header)
        self.setupCollectionView(collectionView: self.cltVw)
        self.setDataForStepUpAnimation()
        self.getTherapistList()
        self.lblRepeatRequest.text = "THERAPIST_REPEAT_REQUEST".localized()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.reloadTableDataToFitHeight(tableView: self.tableView)
    }

    @IBAction func btnDoneTapped(_ sender: Any) {
        if selectedData.id == "" {
            Common.showAlert(message: "VALIDATION_MSG_PLEASE_SELECT_DATA".localized())
        } else {
            if self.onBtnDoneTapped != nil {
                self.onBtnDoneTapped!(selectedData);
            }
        }
    }
   
}

extension CustomPreferGenderPicker : UITableViewDelegate,UITableViewDataSource {

    private func reloadTableDataToFitHeight(tableView: UITableView) {
        tableView.reloadData()
        /*tableView.reloadData(heightToFit: self.hTblVw) {
        }*/
    }
    private func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = JDDeviceHelper.offseter(offset: 48)
        tableView.register(PreferGenderPickerCell.nib()
            , forCellReuseIdentifier: PreferGenderPickerCell.name)
        tableView.tableFooterView = UIView()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrForData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: PreferGenderPickerCell.name, for: indexPath) as?  PreferGenderPickerCell
        cell?.layoutIfNeeded()
        cell?.setData(data: arrForData[indexPath.row])
        cell?.layoutIfNeeded()
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        for i in 0..<arrForData.count {
            arrForData[i].isSelected = false
        }
        self.arrForData[indexPath.row].isSelected = true
        self.selectedData = self.arrForData[indexPath.row]
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}



// MARK: - CollectionView Methods
extension CustomPreferGenderPicker:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private func setupCollectionView(collectionView:  UICollectionView) {
        collectionView.backgroundColor = UIColor.clear
        collectionView.isUserInteractionEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TherapistCltCell.nib()
            , forCellWithReuseIdentifier: TherapistCltCell.name)

    }

    // MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrForTherapist.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TherapistCltCell.name, for: indexPath) as! TherapistCltCell
        cell.setData(data: self.arrForTherapist[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        for i in 0..<arrForTherapist.count {
            self.arrForTherapist[i].isSelected = false
        }
        self.arrForTherapist[indexPath.row].isSelected = true
        self.cltVw.reloadData()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.bounds.height
        return CGSize(width: size , height: size)
    }
    
    func setTherapistData() {
        if self.arrForTherapist.isEmpty {
            self.vwForRepeatRequest.isHidden = true
            self.setDialogHeight(height: 0.75)
        } else {
            self.cltVw.reloadData()
            self.vwForRepeatRequest.isHidden = false
            self.setDialogHeight(height: 0.95)
        }
    }

}

extension CustomPreferGenderPicker {
    func getTherapistList() {
        AppWebApi.getBookingTherapistList { (response) in
            self.arrForTherapist.removeAll()
            if ResponseModel.isSuccess(response: response, withSuccessToast: false, andErrorToast: false) {
                for data in response.therapistList {
                    self.arrForTherapist.append(data.toViewModel())
                }
                self.setTherapistData()
            }
        }
    }
}
