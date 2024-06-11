//
//  RecommendView.swift
//  Demo
//
//  Created by CLships on 2024/6/12.
//

import UIKit

class RecommendView: UIView {
    private var recommendData :[DemoResults.DataList] = []

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
        let nib = UINib(nibName: "RecommendView", bundle: Bundle(for: type(of: self)))
        let xibView = nib.instantiate(withOwner: self)[0] as! UIView
        addSubview(xibView)
    }
    
    func setRecommendData(data: [DemoResults.DataList]) {
        recommendData = data
        reloadSubviewLayout(count: data.count)
    }
    
    func reloadSubviewLayout(count: Int) {
        if count == 0 {return}
        self.subviews[0].frame = CGRect(x: 0, y: 0, width: ModelAppUtils.width, height: 150.0 * CGFloat(Int(count/2) + 1))
    }
}
