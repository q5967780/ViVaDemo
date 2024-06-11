//
//  ActivitiesView.swift
//  Demo
//
//  Created by CLships on 2024/6/12.
//

import UIKit

class ActivitiesView: UIView {
    @IBOutlet weak var coView: UICollectionView!
    private var activitiesData :[DemoResults.DataList] = []

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
        let nib = UINib(nibName: "ActivitiesView", bundle: Bundle(for: type(of: self)))
        let xibView = nib.instantiate(withOwner: self)[0] as! UIView
        addSubview(xibView)
        
        coView.register(UINib(nibName: "ActivitiesCell", bundle: nil), forCellWithReuseIdentifier: "ActivitiesCell")
    }
    
    func setActivitiesData(data: [DemoResults.DataList]) {
        activitiesData = data
        reloadSubviewLayout(count: data.count)
        coView.reloadData()
    }
    
    func reloadSubviewLayout(count: Int) {
        if count == 0 {return}
        self.subviews[0].frame = CGRect(x: 0, y: 0, width: ModelAppUtils.width, height: 300.0 * CGFloat(count))
    }
}

extension ActivitiesView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ModelAppUtils.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return activitiesData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActivitiesCell", for: indexPath) as! ActivitiesCell
        cell.setView(obj: activitiesData[indexPath.row])
        return cell
    }
}
