//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit


//MARK: Massage Preference Menu
enum HowItworkMenu: String {
    case MassageCenter = "1"
    case Hotel = "2"
    case EventsAndCorporate = "3"
    func name() -> String {
        switch self {
        case .MassageCenter:
            return "HOW_IT_WORK_TITLE_1".localized()
        case .Hotel:
            return  "HOW_IT_WORK_TITLE_2".localized()
        case .EventsAndCorporate:
            return  "HOW_IT_WORK_TITLE_3".localized()
            
        }
    }
}

struct HowItworkMenuDetail {
    var type: HowItworkMenu = HowItworkMenu.MassageCenter
    var shortDescription: String = ""
    var description: String = ""
    var image: String = ""
    var isSelected: Bool = false
}

class HowItWorkVC: MainVC {
    
    @IBOutlet weak var btnBack: FloatingRoundButton!
    @IBOutlet weak var tableView: UITableView!
    
    var arrForMenu: [HowItworkMenuDetail] = [
        HowItworkMenuDetail(type: .MassageCenter, shortDescription: "HOW_IT_WORK_SHORT_DESCRIPTION".localized(), description: "HOW_IT_WORK_LONG_DESCRIPTION".localized(), image: "", isSelected: false),
        HowItworkMenuDetail(type: .Hotel, shortDescription: "HOW_IT_WORK_SHORT_DESCRIPTION".localized(), description: "HOW_IT_WORK_LONG_DESCRIPTION".localized(), image: "", isSelected: false),
        HowItworkMenuDetail(type: .EventsAndCorporate, shortDescription: "HOW_IT_WORK_SHORT_DESCRIPTION".localized(), description: "HOW_IT_WORK_LONG_DESCRIPTION".localized(), image: "", isSelected: false),
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
     self.setTitle(title: "HOW_IT_WORK_TITLE".localized())
        self.btnBack.setBackButton()
    }
    
    
    @IBAction func btnBackTapped(_ sender: Any) {
        _ = (self.navigationController as? NC)?.popVC()
    }

}


extension HowItWorkVC: UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate {
    
    private func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(HowItWorkTblCell.nib()
            , forCellReuseIdentifier: HowItWorkTblCell.name)
        tableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrForMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HowItWorkTblCell.name, for: indexPath) as?  HowItWorkTblCell
        cell?.layoutIfNeeded()
        cell?.setData(data: arrForMenu[indexPath.row])
        cell?.layoutIfNeeded()
        return cell!
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

