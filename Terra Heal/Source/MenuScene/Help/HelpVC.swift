//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit

struct HelpDetail{
    var question: String = ""
    var answer: String = ""
}

class HelpVC: MainVC {
    
    @IBOutlet weak var btnBack: FloatingRoundButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblDetails: ThemeLabel!
    
    var arrForData: [HelpDetail] = [
        HelpDetail(question: "Chat", answer: "no recent conversations"),
        HelpDetail(question: "FAQs", answer: "frequently asked questions"),
        HelpDetail(question: "need more help?", answer: "talk to our support team"),
        
    ]
    // MARK: Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    private func setup() {
        
        
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialViewSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.setContentOffset(CGPoint.init(x: 0, y: -tableView.contentInset.top), animated: true)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if self.isViewAvailable() {
            self.tableView?.reloadData({
                
            })
            self.tableView?.contentInset = self.getGradientInset()
            
        }
        
        
    }
    private func initialViewSetup() {
        
        self.setupTableView(tableView: self.tableView)
    
        self.setTitle(title: "HELP_TITLE".localized())
        self.lblDetails.setFont(name: FontName.Regular, size: FontSize.label_12)
        self.btnBack.setBackButton()
    }
    
    
    @IBAction func btnBackTapped(_ sender: Any) {
         _ = (self.navigationController as? NC)?.popVC()
    }
    
    func openChatDialog(index:Int = 0) {
        let alert: CustomChatDialog = CustomChatDialog.fromNib()
        alert.initialize(title: "CHAT_DIALOG_TITLE".localized(), data:"CHAT_DIALOG_MSG".localized(), buttonTitle: "CHAT_DIALOG_BTN_CHAT_NOW".localized(), cancelButtonTitle: "BTN_SKIP".localized())
        alert.show(animated: true)
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            guard let self = self else {return}; print(self)
            alert?.dismiss()
        }
        alert.onBtnDoneTapped = {
            [weak alert, weak self] () in
            guard let self = self else {return}; print(self)
            alert?.dismiss()
            self.tableView.reloadData()
        }
    }
    
    func openFaqDialog() {
        let alert: CustomFaqDialog = CustomFaqDialog.fromNib()
        alert.initialize(title: "FAQ_TITLE".localized(), data:"", buttonTitle: "".localized(), cancelButtonTitle: "".localized())
        alert.show(animated: true)
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            guard let self = self else {return}; print(self)
            alert?.dismiss()
        }
        alert.onBtnDoneTapped = {
            [weak alert, weak self] () in
            guard let self = self else {return}; print(self)
            alert?.dismiss()
            self.tableView.reloadData()
        }
    }
}


extension HelpVC: UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate {
    
    private func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(HelpTblCell.nib()
            , forCellReuseIdentifier: HelpTblCell.name)
        tableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrForData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: HelpTblCell.name, for: indexPath) as?  HelpTblCell
        cell?.layoutIfNeeded()
        cell?.setData(data: arrForData[indexPath.row])
        cell?.layoutIfNeeded()
        return cell!
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            self.openChatDialog()
        } else if indexPath.row == 1 {
            self.openFaqDialog()
        }
    }
    
}

