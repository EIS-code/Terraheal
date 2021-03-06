//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit


class TherapistQuestionariesVC: BaseVC {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnSubmit: FilledRoundedButton!

    var arrForTherapistQuestion: [QuestionDetail] = []
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
        self.wsGetQuestionList()

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
        self.setBackground(color: UIColor.themeBackground)
        self.setupTableView(tableView: self.tableView)
        self.setTitle(title: "THERAPIST_QUESTIONARY_TITLE".localized())
        self.btnSubmit.setTitle("BTN_SUBMIT".localized(), for: .normal)
    }

    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
        super.btnLeftTapped()
        _ = (self.navigationController as? NC)?.popVC()
    }
    
    @IBAction func btnSubmitTapped(_ sender: Any) {
        self.btnSubmit.isEnabled = false
        self.wsSaveQuestionList()
    }

    func openTextFieldPicker(index:Int = 0) {
       let alert: CustomTextFieldDialog = CustomTextFieldDialog.fromNib()
        alert.initialize(title: arrForTherapistQuestion[index].title, data: arrForTherapistQuestion[index].value, buttonTitle: "BTN_PROCEED".localized(), cancelButtonTitle: "BTN_SKIP".localized())
        let data = arrForTherapistQuestion[index]
        let keyBoardtype = data.type == "number" ? UIKeyboardType.numberPad : UIKeyboardType.default
        
        alert.configTextField(data:InputTextFieldDetail.init(isMadatory: true, texFieldType: .Name, minLength: data.min.toInt, maxLength: data.max.toInt, keyBoardType: keyBoardtype) )
        alert.show(animated: true)
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            guard let self = self else { return } ; print(self)
            alert?.dismiss()
        }
        alert.onBtnDoneTapped = {
            [weak alert, weak self] (description) in
            guard let self = self else { return } ; print(self)
            alert?.dismiss()
            self.arrForTherapistQuestion[index].value = description
            self.tableView.reloadData()
        }
        
    }
}


extension TherapistQuestionariesVC: UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate {

    private func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(QuestionTblCell.nib()
            , forCellReuseIdentifier: QuestionTblCell.name)
        tableView.tableFooterView = UIView()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return arrForTherapistQuestion.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: QuestionTblCell.name, for: indexPath) as?  QuestionTblCell
        cell?.layoutIfNeeded()
        cell?.setData(data: arrForTherapistQuestion[indexPath.row])
        cell?.vwBg.isUserInteractionEnabled = false
        cell?.layoutIfNeeded()
        return cell!

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.width * 0.25
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.openTextFieldPicker(index: indexPath.row)
    }
    
}

extension TherapistQuestionariesVC {
    func wsGetQuestionList() {
        Loader.showLoading()
        AppWebApi.therapistQuestionList { (response) in
            if ResponseModel.isSuccess(response: response) {
                self.arrForTherapistQuestion.removeAll()
                for question in response.quastionList {
                    self.arrForTherapistQuestion.append(question)
                }
                self.tableView.reloadData()
            }
            Loader.hideLoading()
        }
    }
    func wsSaveQuestionList() {
        var arrForQuestions: [TherapistQuastionaries.QuestionData] = []
        
        for question in self.arrForTherapistQuestion {
            if question.value.isNotEmpty() {
                let ansQuestion: TherapistQuastionaries.QuestionData = TherapistQuastionaries.QuestionData.init(id: question.id, value: question.value)
                arrForQuestions.append(ansQuestion)
            }
        }
        
        var request: TherapistQuastionaries.SaveQuestionList = TherapistQuastionaries.SaveQuestionList.init()
        request.data = arrForQuestions
        AppWebApi.saveQuestionList(params: request, completionHandler: { (response) in
               Loader.hideLoading()
                self.btnSubmit.isEnabled = true
                if ResponseModel.isSuccess(response: response, withSuccessToast: false, andErrorToast: false) {
                     _ = (self.navigationController as? NC)?.popVC()
                }
                        
        })
        
    }
}
