//
//  ProductsView.swift
//  Demo
//
//  Created by CLships on 2024/6/11.
//

import UIKit

class ProductsView: UIView {
    @IBOutlet weak var coView: UICollectionView!
    private var productsData :[DemoResults.DataList] = []

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
        let nib = UINib(nibName: "ProductsView", bundle: Bundle(for: type(of: self)))
        let xibView = nib.instantiate(withOwner: self)[0] as! UIView
        addSubview(xibView)
        
        coView.register(UINib(nibName: "ProductsCell", bundle: nil), forCellWithReuseIdentifier: "ProductsCell")
    }
    
    func setProductsData(data: [DemoResults.DataList]) {
        productsData = data
        coView.reloadData()
    }
}

extension ProductsView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductsCell", for: indexPath) as! ProductsCell
        cell.setView(obj: productsData[indexPath.row])
        return cell
    }
}
