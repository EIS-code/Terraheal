//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit



class TutorialVC: MainVC {


    @IBOutlet weak var btnBack: FloatingRoundButton!
    @IBOutlet weak var btnSkip: UnderlineTextButton!
    @IBOutlet weak var btnNext: ThemeButton!
    @IBOutlet weak var btnDone: FloatingRoundButton!
    @IBOutlet weak var cvForTutorial: UICollectionView!
    var arrForTutorials: [TutorialDetail] = []
    var currentIndex: IndexPath = IndexPath.init(row: 0, section: 0)
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
        self.vwBar?.backgroundColor = UIColor.clear
        self.btnDone.setForwardButton()
        self.btnBack.setBackButton()

        self.btnNext?.setTitle("TUTORIAL_BTN_NEXT".localized(), for: .normal)
        self.btnNext?.setFont(name: FontName.SemiBold, size: FontSize.button_22)
        for i in 0...3 {
            let tutorial: TutorialDetail = TutorialDetail(title: "TUTORIAL_LBL_TITLE".localized() + " " + i.toString(), description: "TUTORIAL_LBL_MESSAGE".localized() + " " + i.toString())
            arrForTutorials.append(tutorial)
        }
        self.btnBack.isHidden = true
        self.setupCollectionView()
    }

    // MARK: - Action Methods
    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnBackTapped(_ sender: Any) {
        currentIndex.row = currentIndex.row - 1
        snapToNearestCell(indexPath: currentIndex)
        if currentIndex.row == 0 {
            btnBack.isHidden = true
        }

    }

    @IBAction func btnNextTapped(_ sender: Any) {
        self.btnBack.isHidden = false
        currentIndex.row = currentIndex.row + 1
        if currentIndex.row == (arrForTutorials.count) {
            PreferenceHelper.shared.setIsTutorialShow(false)
            Common.appDelegate.loadWelcomeVC()
        }
        else  {
            snapToNearestCell(indexPath: currentIndex)
        }
    }

    private func setupCollectionView() {
        cvForTutorial?.backgroundColor = UIColor.white
        cvForTutorial?.isUserInteractionEnabled = true
        cvForTutorial?.isPagingEnabled = true
        cvForTutorial?.delegate = self
        cvForTutorial?.dataSource = self
        cvForTutorial?.register(TutorialCell.nib()
            , forCellWithReuseIdentifier: TutorialCell.name)
    }

    func snapToNearestCell(indexPath: IndexPath) {
            self.cvForTutorial.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}

// MARK: - CollectionView Methods
extension TutorialVC:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
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

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {

        if scrollView == cvForTutorial {

            /*let middlePoint = Int(scrollView.contentOffset.x + UIScreen.main.bounds.width / 2)
            if let indexPath = self.cvForTutorial.indexPathForItem(at: CGPoint(x: middlePoint, y: Int(self.cvForTutorial.center.y))) {
                self.currentIndex = indexPath
                self.snapToNearestCell(indexPath: indexPath)
            }*/

        }

    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        /*if scrollView == cvForTutorial {
            let middlePoint = Int(scrollView.contentOffset.x + UIScreen.main.bounds.width / 2)
            if let indexPath = self.cvForTutorial.indexPathForItem(at: CGPoint(x: middlePoint, y: Int(self.cvForTutorial.center.y))) {
                self.currentIndex = indexPath
                self.snapToNearestCell(indexPath: indexPath)
            }
        }*/
    }
}
