//
//  MarqueeView.swift
//  Demo
//
//  Created by CLships on 2024/6/10.
//

import UIKit

class MarqueeView: UIView {
    
    @IBOutlet weak var coView: UICollectionView!
    private var marqueeData :[DemoResults.DataList] = []

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
        let nib = UINib(nibName: "MarqueeView", bundle: Bundle(for: type(of: self)))
        let xibView = nib.instantiate(withOwner: self)[0] as! UIView
        addSubview(xibView)
        
        coView.register(UINib(nibName: "MarqueeCell", bundle: nil), forCellWithReuseIdentifier: "MarqueeCell")
    }
    
    func setMarqueeData(data: [DemoResults.DataList]) {
        marqueeData = data
        coView.reloadData()
    }
}

extension MarqueeView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ModelAppUtils.width, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return marqueeData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MarqueeCell", for: indexPath) as! MarqueeCell
        cell.setView(obj: marqueeData[indexPath.row])
        return cell
    }
}
