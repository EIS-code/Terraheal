//
//  CustomAlert.swift
//  ModalView
//
//  Created by Jaydeep Vyas on 3/20/17.
//  Copyright © 2017 Aatish. All rights reserved.
//

import UIKit

class SessionDetail: ResponseModel {
    var id: String = ""
    var name: String = ""
    var detail: String = ""
    var image: String = ""
    var isSelected: Bool = false
    override init(fromDictionary dictionary: [String : Any]) {
        super.init(fromDictionary: dictionary)
        self.id = (dictionary["id"] as? String) ?? ""
        self.name = (dictionary["name"] as? String) ?? ""
        self.detail = (dictionary["detail"] as? String) ?? ""
        self.image = (dictionary["image"] as? String) ?? ""
    }
    
    class func getDemoArray() -> [SessionDetail] {
        var arrForSession: [SessionDetail] = []
        var session:  SessionDetail = SessionDetail.init(fromDictionary: [:])
        session.id = "1"
        session.name = "Single"
        session.detail = "give the gift of self-love"
        session.isSelected = true
        arrForSession.append(session)
        session = SessionDetail.init(fromDictionary: [:])
        session.id = "2"
        session.name = "Couple"
        session.detail = "relax side by side with your preferred companion"
        arrForSession.append(session)
        session = SessionDetail.init(fromDictionary: [:])
        session.id = "3"
        session.name = "groups"
        session.detail = "a special moment with your friends or family"
        arrForSession.append(session)
        return  arrForSession
    }
}
class SessionDialog: ThemeBottomDialogView {
    
    @IBOutlet weak var lblTitle: ThemeLabel!
    @IBOutlet weak var hTblVw: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    var onBtnDoneTapped: ((_ data:SessionDetail) -> Void)? = nil
    var selectedData:SessionDetail = SessionDetail.init(fromDictionary: [:])
    var arrForData: [SessionDetail] = []
    
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
        self.setupTableView(tableView: self.tableView)
        
    }
    
    func select(data:SessionDetail) {
        self.selectedData = data
        for i in 0..<arrForData.count {
            arrForData[i].isSelected = false
            if arrForData[i].id == data.id {
                arrForData[i].isSelected = true
            }
        }
        self.tableView.reloadData()
    }
    
    func setDataSource(data: [SessionDetail]) {
        self.arrForData.removeAll()
        for value in data {
            self.arrForData.append(value)
            if value.isSelected {
                self.selectedData = value
            }
        }
        self.reloadTableDateToFitHeight(tableView: self.tableView)
        //self.select(data: self.selectedData)
    }
    override func initialSetup() {
        super.initialSetup()
        self.lblTitle.setFont(name: FontName.SemiBold, size: FontSize.button_22)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.reloadTableDateToFitHeight(tableView: self.tableView)
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

extension SessionDialog : UITableViewDelegate,UITableViewDataSource {
    
    private func reloadTableDateToFitHeight(tableView: UITableView) {
        tableView.reloadData(heightToFit: self.hTblVw) {
            
        }
    }
    private func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
        tableView.register(SessionTblCell.nib()
            , forCellReuseIdentifier: SessionTblCell.name)
        tableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrForData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SessionTblCell.name, for: indexPath) as?  SessionTblCell
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
        if self.onBtnDoneTapped != nil {
            self.onBtnDoneTapped!(selectedData);
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}



