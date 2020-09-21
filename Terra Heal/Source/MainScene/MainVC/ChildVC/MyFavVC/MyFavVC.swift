import UIKit

class MyFavVC: BaseVC {
    
    //MARK:
    //MARK: Outlets
    @IBOutlet weak var collectionVw: UICollectionView!
    var arrForData: [ServiceDetail] = []
    var arrForMassage: [ServiceDetail] = []
    var arrForTherapies: [ServiceDetail] = []
    //MARK:
    //MARK: View life cycle
    override func viewDidLoad(){
        super.viewDidLoad();
        self.setupCollectionView(collectionView:  self.collectionVw)
        self.getServiceCenterDetail()
        self.setBackground(color: .themeBackground)
        
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews();
        setupLayout()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillDisappear(_ animated: Bool){
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool){
        super.viewDidDisappear(animated)
    }
    
   
    
    func  setupLayout(){
        if self.isViewAvailable() {
            self.collectionVw.contentInset = UIEdgeInsets.init(top: JDDeviceHelper.offseter(offset: 80), left: 0, bottom: JDDeviceHelper.offseter(offset: 52), right: 0)
        }
    }
   
    

}
