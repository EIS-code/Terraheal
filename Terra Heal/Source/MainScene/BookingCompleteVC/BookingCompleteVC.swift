//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit


struct CompletionData {
    var strHeader: String = ""
    var strMessage: String = ""
    var strImg: String = ""
    var strButtonTitle: String = "BTN_HOME".localized()
}
class BookingCompleteVC: MainVC {


    @IBOutlet weak var btnHome: ThemeButton!
    @IBOutlet weak var lblHeader: ThemeLabel!
    @IBOutlet weak var lblMessage: ThemeLabel!
    @IBOutlet var vwBg: UIView!
    var completionData: CompletionData = CompletionData.init()
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

    func setData(completionData: CompletionData) {
        self.lblHeader.text = completionData.strHeader
        self.lblMessage.text = completionData.strMessage
        self.btnHome.setTitle(completionData.strButtonTitle, for: .normal)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if self.isViewAvailable() {
            self.btnHome.setHighlighted(isHighlighted: false)
            self.vwBg?.setRound()
        }
    }

    private func initialViewSetup() {
        self.lblHeader?.setFont(name: FontName.SemiBold, size: FontSize.label_26)
        self.lblMessage?.setFont(name: FontName.Regular, size: FontSize.label_18)
        self.btnHome?.setFont(name: FontName.Regular, size: FontSize.button_18)
        self.setData(completionData: completionData)
    }
    
    
    

    // MARK: - Action Methods
    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
         _ = (self.navigationController as? NC)?.popVC()
    }

    @IBAction func btnHomeTapped(_ sender: Any) {
        Common.appDelegate.loadHomeVC()
    }
}

