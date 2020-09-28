//
//  CustomAlert.swift
//  ModalView
//
//  Created by Jaydeep Vyas on 3/20/17.
//  Copyright © 2017 Jaydeep. All rights reserved.
//

import UIKit


class CustomFaqDialog: ThemeBottomDialogView {

    @IBOutlet weak var tableView: UITableView!

    var onBtnDoneTapped: (( ) -> Void)? = nil
    var selectedCampaignDetail: String = ""
    var arrForData: [FAQItem] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func initialize(title:String, data:String = "", buttonTitle:String,cancelButtonTitle:String) {

        self.initialSetup()
        self.lblTitle.text = title
        self.selectedCampaignDetail = data
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
        self.wsgetFAqList()
        
    }

    override func initialSetup() {
        super.initialSetup()
        self.lblTitle.setFont(name: FontName.Bold, size: FontSize.header)
        self.setupTableView(tableView: self.tableView)
        self.setDataForStepUpAnimation()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    @IBAction func btnDoneTapped(_ sender: Any) {
            if self.onBtnDoneTapped != nil {
                self.onBtnDoneTapped!();
            }
    }

    func openFAQdetailsDialog(index: Int) {
        let alert: CustomInformationDialog = CustomInformationDialog.fromNib()
        alert.initialize(title: arrForData[index].question, data:arrForData[index].answer, buttonTitle: "".localized(), cancelButtonTitle: "BTN_BACK".localized())
        alert.show(animated: true)
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            guard let self = self else {return} ; print(self)
            alert?.dismiss()
        }
        alert.onBtnDoneTapped = {
            [weak alert, weak self]  in
            guard let self = self else {return} ; print(self)
            alert?.dismiss()
        }
    }

}


// MARK: - CollectionView Methods
extension CustomFaqDialog:  UITableViewDelegate, UITableViewDataSource {
    private func setupTableView(tableView: UITableView) {
           tableView.delegate = self
           tableView.dataSource = self
           tableView.backgroundColor = .clear
           tableView.showsVerticalScrollIndicator = false
           tableView.rowHeight = UITableView.automaticDimension
           tableView.estimatedRowHeight = UITableView.automaticDimension
           tableView.register(FaqQuestionCell.nib()
               , forCellReuseIdentifier: FaqQuestionCell.name)
           tableView.tableFooterView = UIView()
       }

       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

           return arrForData.count
       }

       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

           let cell = tableView.dequeueReusableCell(withIdentifier: FaqQuestionCell.name, for: indexPath) as?  FaqQuestionCell
           cell?.layoutIfNeeded()
           cell?.setData(data: arrForData[indexPath.row])
           cell?.vwBg.isUserInteractionEnabled = false
           cell?.layoutIfNeeded()
           return cell!

       }
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return tableView.bounds.width * 0.25
       }
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           tableView.deselectRow(at: indexPath, animated: true)
        self.openFAQdetailsDialog(index: indexPath.row)
       }

}

extension CustomFaqDialog {
    func wsgetFAqList() {
        AppWebApi.getFaqList { (response) in
            if ResponseModel.isSuccess(response: response) {
                self.arrForData = response.dataList
                self.tableView.reloadData()
            }
        }
    }
}
