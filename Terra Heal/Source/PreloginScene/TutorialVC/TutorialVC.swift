//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit



class TutorialVC: BaseVC {


    @IBOutlet weak var btnSkip: UnderlineTextButton!
    @IBOutlet weak var btnNext: ThemeButton!
    @IBOutlet weak var btnDone: FloatingProceedButton!
    @IBOutlet weak var cvForTutorial: UICollectionView!
    var arrForTutorials: [TutorialDetail] = []
    var currentIndex: Int = 0
    
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
    }

    private func initialViewSetup() {
        self.setBackground(color: UIColor.themeBackground)
        self.btnNext?.setTitle("TUTORIAL_BTN_NEXT".localized(), for: .normal)
        self.btnNext?.setFont(name: FontName.SemiBold, size: FontSize.button_22)
        for i in 1...3{
            let tutorial: TutorialDetail = TutorialDetail(title: "TUTORIAL_LBL_TITLE_\(i)".localized(), description: "TUTORIAL_LBL_MESSAGE_\(i)".localized(), image: "asset-tutorial-\(i)")
            arrForTutorials.append(tutorial)
        }
        self.btnLeft?.isHidden = true
        self.setupCollectionView()
    }

    // MARK: - Action Methods
    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
         _ = (self.navigationController as? NC)?.popVC()
    }

    @IBAction func btnBackTapped(_ sender: Any) {
        currentIndex = currentIndex - 1
        snapToNearestCell(indexPath: currentIndex)
    }

    @IBAction func btnNextTapped(_ sender: Any) {
        self.btnLeft?.isHidden = false
        currentIndex = currentIndex + 1
        if currentIndex == (arrForTutorials.count) {
            PreferenceHelper.shared.setIsTutorialShow(false)
            Common.appDelegate.loadWelcomeVC()
        }
        else  {
            snapToNearestCell(indexPath: currentIndex)
        }
    }

    
}

// MARK: - CollectionView Methods
extension TutorialVC:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    func setupCollectionView() {
        cvForTutorial?.backgroundColor = UIColor.white
        cvForTutorial?.isUserInteractionEnabled = true
        cvForTutorial?.isPagingEnabled = true
        cvForTutorial?.delegate = self
        cvForTutorial?.dataSource = self
        cvForTutorial?.register(TutorialCell.nib()
            , forCellWithReuseIdentifier: TutorialCell.name)
    }
    
    func snapToNearestCell(indexPath: Int) {
        let index  =  IndexPath.init(row: indexPath, section: 0)
        self.cvForTutorial.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
        if indexPath == 0 {
            self.btnLeft?.isHidden = true
        } else {
            self.btnLeft?.isHidden = false
        }
    }
    
    // MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrForTutorials.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TutorialCell.name, for: indexPath) as! TutorialCell
        cell.layoutIfNeeded()
        cell.setData(tutorialDetail: self.arrForTutorials[indexPath.row])
        cell.layoutIfNeeded()
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.bounds.width
        return CGSize(width: size - 10, height: collectionView.bounds.height)
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
         print("\(#function)")
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let center = CGPoint(x: scrollView.contentOffset.x + (scrollView.frame.width / 2), y: (scrollView.frame.height / 2))
        if let ip = cvForTutorial.indexPathForItem(at: center) {
            self.currentIndex = ip.row
            print("\(#function) \(self.currentIndex)")
            if self.currentIndex == 0 {
                self.btnLeft?.isHidden = true
            } else {
                self.btnLeft?.isHidden = false
            }
            if currentIndex == (arrForTutorials.count - 1) {
                PreferenceHelper.shared.setIsTutorialShow(false)
                Common.appDelegate.loadWelcomeVC()
            }
        }
        
    }
    
}
