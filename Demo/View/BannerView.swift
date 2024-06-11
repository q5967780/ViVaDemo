//
//  BannerView.swift
//  Demo
//
//  Created by CLships on 2024/6/10.
//

import UIKit

class BannerView: UIView {
    private var carouselView: CaroselView!
    private var bannerData :[DemoResults.DataList] = []

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
        let nib = UINib(nibName: "BannerView", bundle: Bundle(for: type(of: self)))
        let xibView = nib.instantiate(withOwner: self)[0] as! UIView
        addSubview(xibView)
        
        carouselView = CaroselView(frame: CGRect(x: 0, y: 0, width: ModelAppUtils.width, height: ModelAppUtils.width))
        addSubview(carouselView)
    }
    
    func setBannerData(data: [DemoResults.DataList]) {
        bannerData = data
        carouselView.setData(dataList: bannerData)
    }

}
