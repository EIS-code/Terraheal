//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit

struct PeopleDetail{
    var name: String = ""
    var image: String = ""
    var age: String = ""
    var gender: Gender = Gender.Male
    var preferGender:  PreferGender = .NoPreference
    var isSelected: Bool = false
}

class ManagePeopleVC: MainVC {

    @IBOutlet weak var btnBack: FloatingRoundButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnAddNewPeople: ThemeButton!

    var arrForData: [PeopleDetail] = [
        PeopleDetail(name: "Jaydeep", image: "", age: "25", gender: Gender.Male, isSelected: false),
        PeopleDetail(name: "ABC", image: "", age: "24", gender: Gender.Female, isSelected: false),
        PeopleDetail(name: "Test", image: "", age: "23", gender: Gender.Male, isSelected: true),
        PeopleDetail(name: "Jd", image: "", age: "22", gender: Gender.Male, isSelected: false),
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
            self.btnAddNewPeople.layoutIfNeeded()
            self.btnAddNewPeople.setHighlighted(isHighlighted: true)
            self.tableView?.reloadData({

            })
           self.tableView?.contentInset = UIEdgeInsets(top: headerGradient.frame.height, left: 0, bottom: footerGradient.frame.height, right: 0)
        }
    }

    private func initialViewSetup() {
        
        self.setupTableView(tableView: self.tableView)
        self.lblTitle?.setFont(name: FontName.Bold, size: FontSize.label_26)
        self.setTitle(title: "MANAGE_PEOPLE_TITLE".localized())
        self.btnBack.setBackButton()
        self.btnAddNewPeople?.setTitle("MANAGE_PEOPLE_BTN_ADD_NEW".localized(), for: .normal)
        self.btnAddNewPeople?.setFont(name: FontName.SemiBold, size: FontSize.button_14)
        self.btnAddNewPeople?.setHighlighted(isHighlighted: true)
    }

    func openAddPeopleDialog(index: Int = -1) {

        let alert: CustomAddPeopleDialog = CustomAddPeopleDialog.fromNib()
        if index == -1 {
            alert.initialize(title: "MANAGE_PEOPLE_BTN_ADD_NEW".localized(), data: nil, buttonTitle: "BTN_PROCEED".localized(),cancelButtonTitle: "BTN_SKIP".localized())
            alert.select(gender: Gender.Male)

        } else {
            alert.initialize(title: "MANAGE_PEOPLE_BTN_ADD_NEW".localized(), data: self.arrForData[index],buttonTitle: "BTN_PROCEED".localized(),cancelButtonTitle: "BTN_SKIP".localized())

        }
        alert.show(animated: true)
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            alert?.dismiss()
            guard let self = self else { return }
            self.btnAddNewPeople.isEnabled = true

        }
        alert.onBtnDeleteTapped = {
            [weak alert, weak self] in
            alert?.dismiss()
            guard let self = self else { return }
            self.arrForData.remove(at: index)
            self.tableView.reloadData()

        }
        alert.onBtnDoneTapped = {
            [weak alert, weak self] (people) in
            alert?.dismiss()
            guard let self = self else { return }
            self.btnAddNewPeople.isEnabled = true
            if index == -1 {
                self.arrForData.append(people)
            }else {
                self.arrForData[index] = people
            }

            self.tableView.reloadData()
        }
    }

    @IBAction func btnBackTapped(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnAddNewPeopleTapped(_ sender: Any) {
        btnAddNewPeople.isEnabled = false
        self.openAddPeopleDialog()
    }


}


extension ManagePeopleVC: UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate {

    private func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(ManagePeopleTblCell.nib()
            , forCellReuseIdentifier: ManagePeopleTblCell.name)
        tableView.tableFooterView = UIView()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return arrForData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ManagePeopleTblCell.name, for: indexPath) as?  ManagePeopleTblCell
        cell?.layoutIfNeeded()
        cell?.setData(data: arrForData[indexPath.row])
        cell?.layoutIfNeeded()
        return cell!

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.openAddPeopleDialog(index: indexPath.row)
        //self.openRateViewPicker(name: self.arrForData[indexPath.row].title)
    }
    
}

