//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit

struct TherapistQuesionDetail{
    var question: String = ""
    var answer: String = ""
}

class TherapistQuestionariesVC: MainVC {

    @IBOutlet weak var btnBack: FloatingRoundButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnSubmit: ThemeButton!

    var arrForTherapistQuestion: [TherapistQuesionDetail] = [
        TherapistQuesionDetail(question: "Question 1", answer: ""),
        TherapistQuesionDetail(question: "Question 2", answer: ""),
        TherapistQuesionDetail(question: "Question 3", answer: ""),
        TherapistQuesionDetail(question: "Question 4", answer: ""),
        TherapistQuesionDetail(question: "Question 5", answer: ""),
        TherapistQuesionDetail(question: "Question 6", answer: ""),
        TherapistQuesionDetail(question: "Question 7", answer: ""),
        TherapistQuesionDetail(question: "Question 8", answer: ""),
        TherapistQuesionDetail(question: "Question 9", answer: ""),
        TherapistQuesionDetail(question: "Question 10", answer: ""),
        TherapistQuesionDetail(question: "Question 11", answer: ""),
        TherapistQuesionDetail(question: "Question 12", answer: ""),
        TherapistQuesionDetail(question: "Question 13", answer: ""),
        TherapistQuesionDetail(question: "Question 14", answer: ""),
        TherapistQuesionDetail(question: "Question 15", answer: "")
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
        tableView.setContentOffset(CGPoint.init(x: 0, y: -tableView.contentInset.top), animated: true)

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if self.isViewAvailable() {
            self.tableView?.reloadData({

            })
           self.tableView?.contentInset = UIEdgeInsets(top: headerGradient.frame.height, left: 0, bottom: footerGradient.frame.height, right: 0)
            self.btnSubmit?.setHighlighted(isHighlighted: true)
        }


    }
    private func initialViewSetup() {
        
        self.setupTableView(tableView: self.tableView)
        self.lblTitle?.setFont(name: FontName.Bold, size: FontSize.label_26)
        self.setTitle(title: "THERAPIST_QUESTIONARY_TITLE".localized())
         self.btnBack.setBackButton()
        self.btnSubmit.setTitle("BTN_SUBMIT".localized(), for: .normal)
        self.btnSubmit?.setFont(name: FontName.SemiBold, size: FontSize.button_14)
        self.btnSubmit?.setHighlighted(isHighlighted: true)
    }


    @IBAction func btnBackTapped(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnSubmitTapped(_ sender: Any) {
        Common.appDelegate.loadHomeVC()
    }

    func openTextFieldPicker(index:Int = 0) {
        let alert: CustomTextFieldDialog = CustomTextFieldDialog.fromNib()
        alert.initialize(title: arrForTherapistQuestion[index].question, data: arrForTherapistQuestion[index].answer, buttonTitle: "BTN_PROCEED".localized(), cancelButtonTitle: "BTN_SKIP".localized())
        alert.show(animated: true)
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            alert?.dismiss()
        }
        alert.onBtnDoneTapped = {
            [weak alert, weak self] (description) in
            alert?.dismiss()
            guard let self = self else { return }
            self.arrForTherapistQuestion[index].answer = description
            self.tableView.reloadData()
        }
    }
}


extension TherapistQuestionariesVC: UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate {

    private func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(TherapistQuestionariesTblCell.nib()
            , forCellReuseIdentifier: TherapistQuestionariesTblCell.name)
        tableView.tableFooterView = UIView()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return arrForTherapistQuestion.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: TherapistQuestionariesTblCell.name, for: indexPath) as?  TherapistQuestionariesTblCell
        cell?.layoutIfNeeded()
        cell?.setData(data: arrForTherapistQuestion[indexPath.row])
        cell?.layoutIfNeeded()
        return cell!

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.openTextFieldPicker(index: indexPath.row)
    }
    
}

