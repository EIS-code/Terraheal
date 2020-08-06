//
//  CustomAlert.swift
//  ModalView
//
//  Created by Jaydeep Vyas on 3/20/17.
//  Copyright © 2017 Aatish. All rights reserved.
//

import UIKit

enum PreferLanguage: String {
    case English  = "en"
    case Portugues  = "pt"
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
    func code() -> String {
        switch self {
        // Use Internationalization, as appropriate.
        case .English: return "en"
        case .Portugues: return "pt"
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

    @IBOutlet weak var hTblVw: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!

    var onBtnDoneTapped: ((_ Language:PreferLanguage) -> Void)? = nil
    var selectedLanguage: PreferLanguage = PreferLanguage.English
    var arrForLanguage: [LanguageDetail] = [
        LanguageDetail.init(type: PreferLanguage.English, name: PreferLanguage.English.name(), image: PreferLanguage.English.flag(), isSelected: true),
        LanguageDetail.init(type: PreferLanguage.Portugues, name: PreferLanguage.Portugues.name(),image: PreferLanguage.Portugues.flag(), isSelected: false),
    ]
    
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
        self.select(language: self.selectedLanguage)
        self.setupTableView(tableView: self.tableView)

    }

    func select(language:PreferLanguage) {
        self.selectedLanguage = language
        for i in 0..<arrForLanguage.count {
            arrForLanguage[i].isSelected = false
            if arrForLanguage[i].type == language {
              arrForLanguage[i].isSelected = true
            }
        }
        self.tableView.reloadData()
    }

    override func initialSetup() {
        super.initialSetup()
        self.lblTitle.setFont(name: FontName.Bold, size: FontSize.label_22)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.reloadTableDateToFitHeight(tableView: self.tableView)
    }

    @IBAction func btnDoneTapped(_ sender: Any) {
        if selectedLanguage
            == PreferLanguage.NoPreference {
            Common.showAlert(message: "VALIDATION_MSG_PLEASE_SELECT_DATA".localized())
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



