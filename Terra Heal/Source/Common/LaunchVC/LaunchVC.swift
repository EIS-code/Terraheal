//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit

class LaunchVC: MainVC {
    
    @IBOutlet weak var ivLogo: UIImageView!
    @IBOutlet weak var lblLogo: UILabel!

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblLogo.font = FontHelper.font(name: FontName.GradDuke, size: FontSize.button_14)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.ivLogo.setRound()
    }

    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
       DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {

        if PreferenceHelper.shared.getSessionToken().isEmpty() {
            Common.appDelegate.loadWelcomeVC()
            } else {
                Common.appDelegate.loadWelcomeVC()
            }
        }
        
        
    }
    // MARK: - StatusBar
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}
