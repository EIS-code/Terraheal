//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit

struct UploadDocumentDetail {
    var id: String  = ""
    var name: String  = ""
    var image: UIImage? = nil
    var data: Data? = nil
    var isCompleted: Bool  = false
}


class ManageDocumentVC: MainVC {
    
    @IBOutlet weak var btnBack: FloatingRoundButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var vwForEmpty: UIView!
    @IBOutlet weak var vwBg: UIView!
    @IBOutlet weak var lblEmptyTitle: ThemeLabel!
    @IBOutlet weak var lblEmptyMsg: ThemeLabel!
    @IBOutlet weak var btnSubmit: ThemeButton!
    
    var arrForData: [UploadDocumentDetail] = [UploadDocumentDetail.init(id: "599905", name:"Front Side", image: nil, data: nil, isCompleted: true),UploadDocumentDetail.init(id: "599905", name:"Back Side", image: nil, data: nil, isCompleted: false)]
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
        self.updateUI()
        self.addBottomFade()
        self.addTopFade()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if self.isViewAvailable() {
            self.vwBg?.layoutIfNeeded()
            self.vwBg?.setRound()
            self.tableView?.reloadData({
            })
            self.btnSubmit?.setHighlighted(isHighlighted: true)
            self.tableView?.contentInset = UIEdgeInsets(top: headerGradient.frame.height, left: 0, bottom: footerGradient.frame.height, right: 0)
        }
    }
    
    private func initialViewSetup() {
        
        self.setupTableView(tableView: self.tableView)
        self.lblTitle?.setFont(name: FontName.Bold, size: FontSize.label_26)
        self.setTitle(title: "MANAGE_DOCUMENT_TITLE".localized())
        self.lblEmptyTitle.text = "DOCUMENT_EMPTY_TITLE".localized()
        self.lblEmptyMsg.text = "DOCUMENT_EMPTY_MSG".localized()
        self.btnSubmit?.setTitle("MANAGE_DOCUMENT_BTN_ADD_NEW".localized(), for: .normal)
        self.btnSubmit?.setFont(name: FontName.SemiBold, size: FontSize.button_14)
        self.btnSubmit?.setHighlighted(isHighlighted: true)
    }
    
    @IBAction func btnBackTapped(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSubmitTapped(_ sender: Any) {
        self.openNewAddressDialog()
    }
    
    func updateUI()  {
        if arrForData.isEmpty {
            self.vwForEmpty.isHidden = false
            self.tableView.isHidden = true
        } else {
            self.vwForEmpty.isHidden = true
            self.tableView.isHidden = false
        }
        self.tableView.reloadData()
    }
    func openNewAddressDialog(index:Int = -1) {
        
       
    }
    
    func openConfirmationDialog(index:Int) {
        
        let alert: CustomAlertConfirmation = CustomAlertConfirmation.fromNib()
        
        alert.initialize(title: "Remove Document", message: "Are you you want to delete this address",buttonTitle: "Ok", cancelButtonTitle: "Cancel")
        alert.show(animated: true)
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            alert?.dismiss()
        }
        alert.onBtnDoneTapped = {
            [weak alert, weak self]  in
            alert?.dismiss()
            guard  let self = self else {
                return
            }
            
        }
    }
    @objc func removeDocument(button: UIButton) {
        self.openConfirmationDialog(index: button.tag)
    }
   
}


extension ManageDocumentVC: UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate {
    
    private func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        tableView.register(DocumentTblCell.nib()
            , forCellReuseIdentifier: DocumentTblCell.name)
        tableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrForData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: DocumentTblCell.name, for: indexPath) as?  DocumentTblCell
        cell?.layoutIfNeeded()
        cell?.setData(data: arrForData[indexPath.row])
        cell?.btnDelete.tag = indexPath.row
        cell?.btnDelete.addTarget(self, action: #selector(removeDocument), for: .touchUpInside)
        cell?.layoutIfNeeded()
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //self.openNewAddressDialog(index: indexPath.row)
    }
    
}


