//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit


class GiftVoucherVC: MainVC {

    @IBOutlet weak var scrVw: UIScrollView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var hVwContent: NSLayoutConstraint!
    @IBOutlet weak var vwBg: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblMsg: ThemeLabel!
    @IBOutlet weak var lblHeader: ThemeLabel!
    @IBOutlet weak var btnGetStarted: ThemeButton!
    @IBOutlet weak var ivGiftPack: UIImageView!
    @IBOutlet weak var lblTblHeader: ThemeLabel!

    var arrForMenu: [String] = [ "terra heal massage center","terra heal massage center","terra heal massage center","terra heal massage center","terra heal massage center","terra heal massage center"]
    var kTableHeaderHeight:CGFloat = 300.0

    
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
        self.headerView.layoutIfNeeded()

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        if self.isViewAvailable() {

            //self.updateHeaderView()
            self.ivGiftPack.layoutIfNeeded()
            self.ivGiftPack.setRound()
            self.vwBg?.setRound(withBorderColor: UIColor.clear, andCornerRadious: 20.0, borderWidth: 1.0)
            self.vwBg?.setShadow()
            self.btnGetStarted.layoutIfNeeded()
            self.btnGetStarted.setHighlighted(isHighlighted: true)
        }
    }

    private func initialViewSetup() {
        self.setTitle(title: "Gift Voucher")
        self.setupTableView(tableView: self.tableView)
        self.lblHeader.setFont(name: FontName.Bold, size: FontSize.label_18)
        self.lblMsg.setFont(name: FontName.Regular, size: FontSize.label_14)
        self.lblTblHeader.setFont(name: FontName.Bold, size: FontSize.label_22)
        self.btnGetStarted?.setTitle("Get Started".localized(), for: .normal)
        self.btnGetStarted?.setFont(name: FontName.SemiBold, size: FontSize.button_14)
        self.btnGetStarted?.setHighlighted(isHighlighted: true)

    }
    // MARK: - Action Methods
    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
        super.btnLeftTapped()
        self.navigationController?.popViewController(animated: true)
    }
}


extension GiftVoucherVC: UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate {

    private func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        self.scrVw.delegate = self
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(GiftVoucherTblCell.nib()
            , forCellReuseIdentifier: GiftVoucherTblCell.name)
        tableView.tableFooterView = UIView()
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateHeaderView()
    }

    func updateHeaderView() {

       /* if self.scrVw.contentOffset.y < 0 {
            let y = abs(self.scrVw.contentOffset.y)
            let transLation = y/kTableHeaderHeight
            headerView.alpha = transLation
            headerView.transform = CGAffineTransform.init(scaleX: transLation, y: transLation)
            
        } else {
            headerView.alpha = 0.0
        }*/
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrForMenu.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GiftVoucherTblCell.name, for: indexPath) as?  GiftVoucherTblCell
        cell?.layoutIfNeeded()
        cell?.setData(data: arrForMenu[indexPath.row])
        cell?.layoutIfNeeded()
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.width * 0.8
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

    }
}
