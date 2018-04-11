//
//  ALYAgentlevelVC.swift
//  Meimeila
//
//  Created by yanghuan on 2018/4/8.
//  Copyright © 2018年 HJQ. All rights reserved.
//

import UIKit

class ALYAgentlevelVC: DDBaseViewController {

	@IBOutlet weak var levelBgView: UIView!
	var collectionView: UICollectionView!
	
	private lazy var cardDataViewModel: LevelCardDataViewModel = {[weak self] in
		let viewModel = LevelCardDataViewModel.init()
		return viewModel
		}()
	
	init() {
		super.init(nibName: String.init(describing: ALYAgentlevelVC.self), bundle: nil)
		
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
        super.viewDidLoad()
		self.title = "我要赚钱"
        // Do any additional setup after loading the view.
		
        setup()
        cardDataViewModel.getCardData {
            self.collectionView.reloadData()
        }
    }

	func setup() {
		let layout = CardLayout()
		layout.scale = 0.9
		layout.itemSize = CGSize(width: levelBgView.width-100, height: 180)
		
		collectionView = UICollectionView(frame: levelBgView.bounds, collectionViewLayout: layout)
		collectionView.backgroundColor = view.backgroundColor
		collectionView.dataSource = self
        collectionView.delegate = self
		collectionView.showsVerticalScrollIndicator = false
		collectionView.showsHorizontalScrollIndicator = false
		
		collectionView.register(UINib.init(nibName: String.init(describing: ALYLevelCardColCell.self), bundle: nil), forCellWithReuseIdentifier: String.init(describing: ALYLevelCardColCell.self));
		
		levelBgView.addSubview(collectionView)
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
		collectionView.frame = levelBgView.bounds
	}
	
	override var prefersStatusBarHidden: Bool {
		return false
	}
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	

}

extension ALYAgentlevelVC: UICollectionViewDataSource,UICollectionViewDelegate{
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return self.cardDataViewModel.cardListArr.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		 let cell:ALYLevelCardColCell = collectionView.dequeueReusableCell(withReuseIdentifier: String.init(describing: ALYLevelCardColCell.self), for: indexPath) as! ALYLevelCardColCell;
		
		let model = self.cardDataViewModel.cardListArr[indexPath.row];
		cell.cardDataModel = model
		cell.layer.cornerRadius = 5
		cell.layer.masksToBounds = true
		
		return cell
	}
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let vc = ALYAgentMsgInputVC()
        
        navigationController?.pushViewController(vc, animated: true)
    }
}