//
//  CustomAlert.swift
//  ModalView
//
//  Created by Aatish Rajkarnikar on 3/20/17.
//  Copyright © 2017 Aatish. All rights reserved.
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

    @IBOutlet weak var lblTitle: ThemeLabel!
    @IBOutlet weak var btnDone: ThemeButton!
    @IBOutlet weak var hTblVw: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!

    var onBtnDoneTapped: ((_ gender:PreferGender) -> Void)? = nil
    var selectedGender: PreferGender = PreferGender.NoPreference
    var arrForGender: [GenderDetail] = [
        GenderDetail.init(type: PreferGender.NoPreference, name: PreferGender.NoPreference.name(), isSelected: false),
        GenderDetail.init(type: PreferGender.PreferMale, name: PreferGender.PreferMale.name(), isSelected: false),
        GenderDetail.init(type: PreferGender.MaleOnly, name: PreferGender.MaleOnly.name(), isSelected: false),
        GenderDetail.init(type: PreferGender.PrefereFemale, name: PreferGender.PrefereFemale.name(), isSelected: false),
        GenderDetail.init(type: PreferGender.FemaleOnly, name: PreferGender.FemaleOnly.name(), isSelected: false),
    ]
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
        self.select(gender: self.selectedGender)
        self.setupTableView(tableView: self.tableView)

    }

    func select(gender:PreferGender) {
        self.selectedGender = gender
        for i in 0..<arrForGender.count {
            arrForGender[i].isSelected = false
            if arrForGender[i].type == gender {
                arrForGender[i].isSelected = true
            }
        }
        self.tableView.reloadData()
    }

    func initialSetup() {
        dialogView.clipsToBounds = true
        self.backgroundColor = .clear
        self.backgroundView.backgroundColor = UIColor.black
        self.backgroundView.alpha = 0.0
        self.backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedOnBackgroundView)))
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
        vwTopBar?.setRound(withBorderColor: .clear, andCornerRadious: 2.5, borderWidth: 1.0)
        self.btnDone?.setHighlighted(isHighlighted: true)
        self.reloadTableDateToFitHeight(tableView: self.tableView)
    }

    @IBAction func btnDoneTapped(_ sender: Any) {
        if selectedGender
            == PreferGender.NoPreference {
            Common.showAlert(message: "VALIDATION_MSG_PLEASE_SELECT_DATA".localized())
        } else {
            if self.onBtnDoneTapped != nil {
                self.onBtnDoneTapped!(selectedGender);
            }
        }

    }
   
}

extension CustomPreferGenderPicker : UITableViewDelegate,UITableViewDataSource {

    private func reloadTableDateToFitHeight(tableView: UITableView) {
        tableView.reloadData(heightToFit: self.hTblVw) {

        }
    }
    private func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(PreferGenderPickerCell.nib()
            , forCellReuseIdentifier: PreferGenderPickerCell.name)
        tableView.tableFooterView = UIView()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrForGender.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: PreferGenderPickerCell.name, for: indexPath) as?  PreferGenderPickerCell
        cell?.layoutIfNeeded()
        cell?.setData(data: arrForGender[indexPath.row])
        cell?.layoutIfNeeded()
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        for i in 0..<arrForGender.count {
            arrForGender[i].isSelected = false
        }
        self.arrForGender[indexPath.row].isSelected = true
        self.selectedGender = self.arrForGender[indexPath.row].type
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}



