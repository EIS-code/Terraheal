//
//  CustomAlert.swift
//  ModalView
//
//  Created by Aatish Rajkarnikar on 3/20/17.
//  Copyright © 2017 Aatish. All rights reserved.
//

import UIKit

enum PreferLanguage: String {
    case English  = "english"
    case Portugues  = "portugues"
    case NoPreference = ""

    func name()-> String {
        switch self {
        // Use Internationalization, as appropriate.
        case .English: return "LANGUAGE_ENGLISH".localized()
        case .Portugues: return "LANGUAGE_PORTUGUES".localized()
        default: return "LANGUAGE_NO_PREFERENCE".localized()
        }
    }

    func flag() -> String {
        switch self {
        // Use Internationalization, as appropriate.
        case .English: return "🇬🇧"
        case .Portugues: return "🇵🇹"
        default: return "--"
        }
    }




}

struct LanguageDetail {
    var type: PreferLanguage = PreferLanguage.English
    var name: String = ""
    var image: String = ""
    var isSelected: Bool = false
}
class CustomLanguagePicker: ThemeBottomDialogView {

    @IBOutlet weak var lblTitle: ThemeLabel!
    @IBOutlet weak var btnDone: ThemeButton!
    @IBOutlet weak var hTblVw: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!

    var onBtnDoneTapped: ((_ Language:PreferLanguage) -> Void)? = nil
    var selectedLanguage: PreferLanguage = PreferLanguage.English
    var arrForLanguage: [LanguageDetail] = [
        LanguageDetail.init(type: PreferLanguage.English, name: PreferLanguage.English.name(), image: PreferLanguage.English.flag(), isSelected: true),
        LanguageDetail.init(type: PreferLanguage.Portugues, name: PreferLanguage.Portugues.name(),image: PreferLanguage.Portugues.flag(), isSelected: false),
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
        self.select(Language: self.selectedLanguage)
        self.setupTableView(tableView: self.tableView)

    }

    func select(Language:PreferLanguage) {
        self.selectedLanguage = Language
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
        if selectedLanguage
            == PreferLanguage.NoPreference {
            Common.showAlert(message: "VALIDATION_MSG_PLEASE_SELECT_DATE".localized())
        } else {
            if self.onBtnDoneTapped != nil {
                self.onBtnDoneTapped!(selectedLanguage);
            }
        }

    }
   
}

extension CustomLanguagePicker : UITableViewDelegate,UITableViewDataSource {

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
        tableView.register(CustomLanguagePickerCell.nib()
            , forCellReuseIdentifier: CustomLanguagePickerCell.name)
        tableView.tableFooterView = UIView()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrForLanguage.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: CustomLanguagePickerCell.name, for: indexPath) as?  CustomLanguagePickerCell
        cell?.layoutIfNeeded()
        cell?.setData(data: arrForLanguage[indexPath.row])
        cell?.layoutIfNeeded()
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        for i in 0..<arrForLanguage.count {
            arrForLanguage[i].isSelected = false
        }
        self.arrForLanguage[indexPath.row].isSelected = true
        self.selectedLanguage = self.arrForLanguage[indexPath.row].type
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}



