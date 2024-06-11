//
//  CampaignView.swift
//  Demo
//
//  Created by CLships on 2024/6/11.
//

import UIKit

class CampaignView: UIView {
    @IBOutlet weak var coView: UICollectionView!
    private var campaignData :[DemoResults.DataList] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadXib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadXib()
    }
    
    override func layoutSubviews() {
        
    }
    
    func loadXib() {
        let nib = UINib(nibName: "CampaignView", bundle: Bundle(for: type(of: self)))
        let xibView = nib.instantiate(withOwner: self)[0] as! UIView
        xibView.frame = CGRect(x: 0, y: 0, width: ModelAppUtils.width, height: 150)
        addSubview(xibView)
        
        coView.register(UINib(nibName: "CampaignCell", bundle: nil), forCellWithReuseIdentifier: "CampaignCell")
    }
    
    func setCampaignData(data: [DemoResults.DataList]) {
        campaignData = data
        reloadSubviewLayout(count: data.count)
        coView.reloadData()
    }
    
    func reloadSubviewLayout(count: Int) {
        if count == 0 {return}
        self.subviews[0].frame = CGRect(x: 0, y: 0, width: ModelAppUtils.width, height: 150.0 * CGFloat(count))
    }
}


extension CampaignView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ModelAppUtils.width, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return campaignData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CampaignCell", for: indexPath) as! CampaignCell
        cell.setView(obj: campaignData[indexPath.row])
        return cell
    }
}
