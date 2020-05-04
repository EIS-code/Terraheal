//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit



class TutorialVC: MainVC {


    @IBOutlet weak var lblMessage: ThemeLabel!
    @IBOutlet weak var lblTutorialTitle: ThemeLabel!
    @IBOutlet weak var btnSkip: UnderlineTextButton!
    @IBOutlet weak var btnNext: ThemeButton!
    @IBOutlet weak var btnDone: ThemeButton!


    // MARK: Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: Setup

    private func setup() {

    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialViewSetup()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.btnDone?.setUpRoundedButton()
    }

    private func initialViewSetup() {
        self.vwBar?.backgroundColor = UIColor.clear
        self.lblMessage?.text = "TUTORIAL_LBL_MESSAGE".localized()
        self.lblMessage?.setFont(name: FontName.Ovo, size: FontSize.label_18)
        self.lblTutorialTitle?.text = "TUTORIAL_LBL_TITLE".localized()
        self.lblTutorialTitle?.font = FontHelper.font(name: FontName.GradDuke, size: FontSize.label_26)
        self.btnSkip?.setTitle("TUTORIAL_BTN_SKIP".localized(), for: .normal)
        self.btnSkip?.setFont(name: FontName.Ovo, size: FontSize.button_20)
        self.btnNext?.setTitle("TUTORIAL_BTN_NEXT".localized(), for: .normal)
        self.btnNext?.setFont(name: FontName.GradDuke, size: FontSize.button_22)
    }

    // MARK: - Action Methods
    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnSkipTapped(_ sender: Any) {
        Common.appDelegate.loadLoginVC()
    }


}

// MARK: - Web API Methods
extension TutorialVC {

}
