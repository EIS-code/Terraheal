//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit



struct CampaignsDetail {
    var name: String = ""
    var description: String = ""
    var isSelected: Bool = false
}

class CampaignsVC: MainVC {

    @IBOutlet weak var btnBack: FloatingRoundButton!
    @IBOutlet weak var tableView: UITableView!


    var arrForData: [CampaignsDetail] = [
        CampaignsDetail.init(name:"9S75894",description: "FLAT 30 % OFF"),
        CampaignsDetail.init(name:"ABCDEF", description: "FLAT 50 % OFF")

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
            self.tableView?.reloadData({

            })
            self.tableView?.contentInset = UIEdgeInsets(top: headerGradient.frame.height, left: 0, bottom: footerGradient.frame.height, right: 0)

        }


    }
    private func initialViewSetup() {
        
        self.setupTableView(tableView: self.tableView)
        self.lblTitle?.setFont(name: FontName.Bold, size: FontSize.label_26)
        self.setTitle(title: "CAMPAIGNS_TITLE".localized())
       self.btnBack.setBackButton()
    }



    @IBAction func btnBackTapped(_ sender: Any) {
         _ = (self.navigationController as? NC)?.popVC()
    }

    func openCampaignDetail() {
        let alert: CustomCampaignsDetailDialog = CustomCampaignsDetailDialog.fromNib()
        alert.initialize(title: "CAMPAIGNS_DETAIL_DIALOG_TITLE".localized(), buttonTitle: "".localized(), cancelButtonTitle: "BTN_BACK".localized())
        alert.show(animated: true)
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            alert?.dismiss()
             guard let self = self else { return } ; print(self)

        }
        alert.onBtnDoneTapped = {
            [weak alert, weak self] (description) in
            alert?.dismiss()
             guard let self = self else { return } ; print(self)

        }
    }



}


extension CampaignsVC: UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate {

    private func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(CampaignsTblCell.nib()
            , forCellReuseIdentifier: CampaignsTblCell.name)
        tableView.tableFooterView = UIView()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return arrForData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CampaignsTblCell.name, for: indexPath) as?  CampaignsTblCell
        cell?.layoutIfNeeded()
        cell?.setData(data: arrForData[indexPath.row])
        cell?.btnDetails.addTarget(self, action: #selector(btnDetailTapped(button:)), for: .touchUpInside)
        cell?.layoutIfNeeded()
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

    }

    @objc func btnDetailTapped(button: UIButton) {
        self.openCampaignDetail()
    }
    
}

