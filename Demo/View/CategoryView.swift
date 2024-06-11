//
//  CategoryView.swift
//  Demo
//
//  Created by CLships on 2024/6/10.
//

import UIKit

class CategoryView: UIView {
    private var categoryData :[DemoResults.DataList] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadXib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadXib()
    }
    
    override func layoutSubviews() {
        self.subviews[0].frame = CGRect(x: 0, y: 0, width: ModelAppUtils.width, height: 300)
    }
    
    func loadXib() {
        let nib = UINib(nibName: "CategoryView", bundle: Bundle(for: type(of: self)))
        let xibView = nib.instantiate(withOwner: self)[0] as! UIView
        addSubview(xibView)
        
    }
    
    func setCategoryData(data: [DemoResults.DataList]) {
        categoryData = data

    }
}
