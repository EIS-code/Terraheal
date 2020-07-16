//
//  ReciepentMassageDetailVC.swift
//  Dumparoo
//  Created by Jaydeep Vyas on 03/05/19.
//  Copyright © 2019 Jaydeepvyas. All rights reserved.
//

import UIKit

struct ReciepentMassageData {
    var reciepent:People = People.init(fromDictionary: [:])
    var services: [ServiceDetail] = []
    static func getDemoArray() -> [ReciepentMassageData] {
        var recData1 = ReciepentMassageData.init()
        let people: People = People.init(fromDictionary: [:])
        people.age = "21"
        people.name = "Sauravsingh Tomar"
        people.id = "1"
        people.gender = "m"
        recData1.reciepent = people
        recData1.services = ServiceDetail.getMassageArray()
        return [recData1]
        
    }
}
class ReciepentMassageDetailVC: MainVC {
    
    @IBOutlet weak var btnAddReciepent: ThemeButton!
    @IBOutlet weak var btnClose: UnderlineTextButton!
    @IBOutlet weak var btnDone: FloatingRoundButton!
    @IBOutlet weak var btnNext: ThemeButton!
    @IBOutlet weak var lblTotal: ThemeLabel!
    @IBOutlet weak var lblTotalValue: ThemeLabel!
    @IBOutlet weak var tableView: UITableView!
    
    var arrForData: [ReciepentMassageData] = []//ReciepentMassageData.getDemoArray()
    var sheetCoordinator: UBottomSheetCoordinator?
    var onBtnNextSelectedTapped: ((_ data: [ReciepentMassageData]) -> Void)? = nil
    var onBtnBackTapped: (() -> Void)? = nil
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        self.lblTitle?.text = "RECIEPENT_DETAIL_TITLE".localized()
        self.lblTitle?.setFont(name: FontName.Bold, size: FontSize.label_26)
        self.btnAddReciepent.setTitle("RECIEPENT_BTN_ADD_RECIEPENT".localized(), for: .normal)
        self.btnClose.setTitle("BTN_BACK".localized(), for: .normal)
        self.btnClose.setFont(name: FontName.SemiBold, size: FontSize.button_22)
        self.btnNext.setTitle("BTN_NEXT".localized(), for: .normal)
        self.btnNext.setFont(name: FontName.SemiBold, size: FontSize.button_14)
        self.lblTotal?.setFont(name: FontName.Bold, size: FontSize.label_22)
        self.lblTotal?.text = "RECIEPENT_LBL_TOTAL".localized()
        self.lblTotalValue?.setFont(name: FontName.Bold, size: FontSize.label_22)
        self.lblTotalValue?.text = "210".localized()
        self.setupTableView(tableView: self.tableView)
        self.btnDone.setForwardButton()
       // self.sheetCoordinator?.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        sheetCoordinator?.startTracking(item: self)
        self.calculateTotal()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.btnAddReciepent?.layoutIfNeeded()
        self.btnAddReciepent?.setHighlighted(isHighlighted: true)
        self.reloadTableDateToFitHeight(tableView: self.tableView)
    }
    @IBAction func btnCloseTapped(_ sender: Any) {
        if self.onBtnBackTapped != nil {
            self.onBtnBackTapped!()
        }
    }
    
    @IBAction func dismissAction() {
        sheetCoordinator?.removeSheetChild(item: self)
    }
    @IBAction func btnAddReciepentTapped(_ sender: Any) {
        self.btnAddReciepent.isEnabled = false
        self.openRecipientSelectionDialog()
    }
    
    
    @IBAction func btnNextTapped(_ sender: Any) {
        self.btnAddReciepent.isEnabled = false
        if self.onBtnNextSelectedTapped != nil {
            self.onBtnNextSelectedTapped!(self.arrForData)
        }
    }
    
    func calculateTotal() {
        var total: Double = 0.0
        for  data in arrForData {
            for service in data.services {
                total = total + service.selectedDuration.amount.toDouble
            }
        }
        self.lblTotalValue.text = total.toString()
    }
    
    
    func openRecipientSelectionDialog() {
        let recipientSelectionDialog: RecipientSelectionDialog  = RecipientSelectionDialog.fromNib()
        recipientSelectionDialog.initialize(title: "RECIEPENT_DIALOG__TITLE".localized(), buttonTitle: "RECIEPENT_DIALOG_BTN_ADD".localized(), cancelButtonTitle: "BTN_BACK".localized())
        recipientSelectionDialog.show(animated: true)
        recipientSelectionDialog.onBtnCancelTapped = {
            [weak recipientSelectionDialog, weak self] in
            guard let self = self else { return } ; print(self)
            recipientSelectionDialog?.dismiss()
            self.btnAddReciepent.isEnabled = true
        }
        recipientSelectionDialog.onBtnDoneTapped = {
            [weak recipientSelectionDialog, weak self] (people) in
            guard let self = self else { return } ; print(self)
            recipientSelectionDialog?.dismiss()
            self.btnAddReciepent.isEnabled = true
            self.arrForData.append(ReciepentMassageData.init(reciepent: people, services: []))
            self.tableView.reloadData()
        }
    }
}

// MARK: - Table View Delegate & Data source

extension ReciepentMassageDetailVC: UITableViewDelegate, UITableViewDataSource {
    private func reloadTableDateToFitHeight(tableView: UITableView) {
        DispatchQueue.main.async {
            tableView.reloadData {
            }
        }
    }
    
    private func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 40
        tableView.sectionFooterHeight = UITableView.automaticDimension
        tableView.estimatedSectionFooterHeight = 70
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 50
        tableView.register(ReciepentTblCell.nib()
            , forCellReuseIdentifier: ReciepentTblCell.name)
        tableView.register(ReciepentTblFooter.nib(), forHeaderFooterViewReuseIdentifier: ReciepentTblFooter.name)
        tableView.register(ReciepentTblSection.nib(), forHeaderFooterViewReuseIdentifier: ReciepentTblSection.name)
        tableView.backgroundColor = .themePrimaryLightBackground
        //tableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrForData[section].services.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        arrForData.count
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: ReciepentTblSection.name)
            as? ReciepentTblSection
            else {
                return nil
        }
        view.setData(data: arrForData[section].reciepent)
        return view
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: ReciepentTblFooter.name)
            as? ReciepentTblFooter
            else {
                return nil
        }
        view.btnAddService.tag = section
        view.btnAddService.addTarget(self, action: #selector(addService(sender:)), for: .touchUpInside)
        return view
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return  UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ReciepentTblCell.name, for: indexPath) as?  ReciepentTblCell
        cell?.layoutIfNeeded()
        cell?.setData(data: arrForData[indexPath.section].services[indexPath.row])
        cell?.btnDelete.addTarget(self
            , action: #selector(removeService(sender:)), for: .touchUpInside)
        cell?.layoutIfNeeded()
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40//UITableView.automaticDimension
    }
    
    @objc func addService(sender: UIButton) {
        let serviceDetailVC:  ServiceSelectionVC =  ServiceSelectionVC.fromNib()
        DispatchQueue.main.async {
            Common.appDelegate.getTopViewController()?.present(serviceDetailVC, animated: true, completion: nil)
        }
        serviceDetailVC.onBtnServiceSelectedTapped = { [weak self] (service) in
            guard let self = self else { return } ; print(self)
            serviceDetailVC.dismiss(animated: true) {
                self.arrForData[sender.tag].services.append(service)
                self.calculateTotal()
                self.tableView.reloadData()
            }
        }
    }
    @objc func removeService(sender: UIButton) {
        let buttonPostion = sender.convert(sender.bounds.origin, to: tableView)
        
        if let indexPath = tableView.indexPathForRow(at: buttonPostion) {
            self.arrForData[indexPath.section].services.remove(at: indexPath.row)
            self.calculateTotal()
            self.tableView.reloadData()
        }
    }
}



extension ReciepentMassageDetailVC: Draggable {
    func draggableView() -> UIScrollView? {
        return tableView
    }
}


extension ReciepentMassageDetailVC:  UBottomSheetCoordinatorDelegate {
    public func bottomSheet(_ container: UIView?, finishTranslateWith extraAnimation: @escaping ((_ percent: CGFloat)->Void)->Void){
        print("Bottom Sheet \(#function)")
       /* if self.onBtnBackTapped != nil {
            self.onBtnBackTapped!()
        }*/
        
    }
    public func bottomSheet(_ container: UIView?, didChange state: SheetTranslationState){
        print("Bottom Sheet \(#function)")
    }
    public func bottomSheet(_ container: UIView?, didPresent state: SheetTranslationState){
        print("Bottom Sheet \(#function)")
    }
}

