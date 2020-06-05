//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit

class LaunchVC: MainVC {
    
    @IBOutlet weak var ivLogo: UIImageView!

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.ivLogo?.setRound()
    }

    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
            if !PreferenceHelper.shared.getUserId().isEmpty() {
                Common.appDelegate.loadHomeVC()
            }
            else if PreferenceHelper.shared.getIsTutorialShow()  {
                Common.appDelegate.loadTutoraiVC()
            } else {
                Common.appDelegate.loadHomeVC()
            }
        }
    }
    // MARK: - StatusBar
    override var prefersStatusBarHidden: Bool {
        return true
    }

    
    
}
