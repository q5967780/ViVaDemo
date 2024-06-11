//
//  CaroselView.swift
//  Demo
//
//  Created by CLships on 2024/6/10.
//

import UIKit
import Kingfisher

class CaroselView: UIView {
    private var scrollerView:CaroseScrollerView!
    private var imgDefaults = Array(repeating: UIImage(named: "NoImage")!, count: 1)
    private var pageCtrl = UIPageControl()
    private var dataList:Array<DemoResults.DataList>! = []
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    func setData(dataList:[DemoResults.DataList]){
        self.dataList = dataList
        imgDefaults = Array(repeating: UIImage(named: "NoImage")!, count: self.dataList.count)
        pageCtrl.numberOfPages = imgDefaults.count
        scrollerView.setImage(images: imgDefaults)
        
        for (idx,list) in dataList.enumerated() {
            let urlString = list.thumbnailUrl
            
            if let url = URL(string: urlString) {
                KingfisherManager.shared.retrieveImage(with: url) { [self] result in
                    switch result {
                    case .success(let value):
                        scrollerView.setImage(image: value.image, idx: idx)
                    case .failure(_):
                        print("Error downloading image: CaroselView.\(idx)")
                        break;
                    }
                }
            }
        }
    }
    
    func initView(){
        let rect = CGRect(x: 0, y: 0, width: ModelAppUtils.width, height: self.frame.height)
        scrollerView = CaroseScrollerView(frame: rect,images: imgDefaults)
        scrollerView.carDelegate = self
        addSubview(scrollerView)
        
        pageCtrl = UIPageControl(frame: CGRect(x: 0, y: 0, width: 110, height: 10))
        pageCtrl.numberOfPages = imgDefaults.count
        pageCtrl.currentPageIndicatorTintColor = ModelAppUtils.hexStringToUIColor(hex: "#209CFF")
        pageCtrl.pageIndicatorTintColor = ModelAppUtils.hexStringToUIColor(hex: "#C7C7CE")
        addSubview(pageCtrl)
        
        pageCtrl.translatesAutoresizingMaskIntoConstraints = false
        pageCtrl.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        pageCtrl.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        self.addGestureRecognizer(tapGesture)
    }
}

extension CaroselView:CaroseScrollerViewDelegate{
    func nowPage(page: Int) {
        pageCtrl.currentPage = page
        if dataList.count == 0 {return}
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        let url = dataList[pageCtrl.currentPage].url
//        ModelAppUtils.openLink(url)
        print("tap banner:\(pageCtrl.currentPage) link:\(url)")
    }
}
