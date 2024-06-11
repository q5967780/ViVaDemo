//
//  ActivitiesSubView.swift
//  Demo
//
//  Created by CLships on 2024/6/12.
//

import UIKit

class ActivitiesSubView: UIView {
    @IBOutlet weak var coView: UICollectionView!
    private var productData :[DemoResults.DataList.DataProduct] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadXib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadXib()
    }
    
    override func layoutSubviews() {
        self.subviews[0].frame = CGRect(x: 0, y: 0, width: ModelAppUtils.width, height: 150)
    }
    
    func loadXib() {
        let nib = UINib(nibName: "ActivitiesSubView", bundle: Bundle(for: type(of: self)))
        let xibView = nib.instantiate(withOwner: self)[0] as! UIView
        addSubview(xibView)
        
        coView.register(UINib(nibName: "ActivitiesSubCell", bundle: nil), forCellWithReuseIdentifier: "ActivitiesSubCell")
    }
    
    func setProductData(data: [DemoResults.DataList.DataProduct]) {
        productData = data
        coView.reloadData()
    }
}

extension ActivitiesSubView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActivitiesSubCell", for: indexPath) as! ActivitiesSubCell
        cell.setView(obj: productData[indexPath.row])
        return cell
    }
}
