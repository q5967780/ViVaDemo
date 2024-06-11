//
//  ViewController.swift
//  Demo
//
//  Created by CLships on 2024/6/10.
//

import UIKit

class ViewController: UIViewController {
    let loadingControl = UIRefreshControl()
    
    @IBOutlet weak var myScrollView: UIScrollView!
    @IBOutlet weak var marqueeV: MarqueeView!
    @IBOutlet weak var bannerV: BannerView!
    @IBOutlet weak var categoryV: CategoryView!
    @IBOutlet weak var notificationV: NotificationView!
    @IBOutlet weak var campaignV: CampaignView!
    @IBOutlet weak var activitiesV: ActivitiesView!
    @IBOutlet weak var productsV: ProductsView!
    @IBOutlet weak var recommendV: RecommendView!
    
    @IBOutlet weak var categoryVHeigh: NSLayoutConstraint!
    @IBOutlet weak var campagnVHeigh: NSLayoutConstraint!
    @IBOutlet weak var activitiesVHeigh: NSLayoutConstraint!
    @IBOutlet weak var recommendVHeigh: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        callApi()
    }
    
    func initViews() {
        myScrollView.addSubview(loadingControl)
        loadingControl.addTarget(self, action: #selector(loadingData), for: .valueChanged)
    }
    
    @objc func loadingData(){
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            self.callApi()
            self.loadingControl.endRefreshing()
        }
    }
    
    func callApi() {
        ApiUtils.getApiMarquee { data in
            if data.data.count > 0 {
                print("api_1 count: \(data.data.count)")
                self.marqueeV.setMarqueeData(data: data.data)
            }else{
                print("api_1 empty")
            }
        }
        
        ApiUtils.getApiBanner { data in
            if data.data.count > 0 {
                print("api_2 count: \(data.data.count)")
                self.bannerV.setBannerData(data: data.data)
            }else{
                print("api_2 empty")
            }
        }
        
        
        ApiUtils.getApiCategory { data in
            if data.data.count > 0 {
                print("api_3 count: \(data.data.count)")
                self.categoryV.setCategoryData(data: data.data)
            }else{
                print("api_3 empty")
            }
        }
        
        ApiUtils.getApiNotification{ data in
            if data.data.count > 0 {
                print("api_4 count: \(data.data.count)")
                self.notificationV.setNotificationData(data: data.data)
            }else{
                print("api_4 empty")
            }
        }
        
        ApiUtils.getApiCampaign { data in
            if data.data.count > 0 {
                print("api_5 count: \(data.data.count)")
                self.campagnVHeigh.constant = 150.0 * CGFloat(data.data.count)
                self.campaignV.setCampaignData(data: data.data)
            }else{
                print("api_5 empty")
                self.campagnVHeigh.constant = 0.0
            }
        }
        
        ApiUtils.getApiActivities { data in
            if data.data.count > 0 {
                print("api_6 count: \(data.data.count)")
                self.activitiesVHeigh.constant = 300.0 * CGFloat(data.data.count)
                self.activitiesV.setActivitiesData(data: data.data)
            }else{
                print("api_6 empty")
                self.activitiesVHeigh.constant = 0.0
            }
        }
        
        ApiUtils.getApiProducts { data in
            if data.data.count > 0 {
                print("api_7 count: \(data.data.count)")
                self.productsV.setProductsData(data: data.data)
            }else{
                print("api_7 empty")
            }
        }
        
        ApiUtils.getApiRecommend { data in
            if data.data.count > 0 {
                print("api_8 count: \(data.data.count)")
                self.recommendVHeigh.constant = 150.0 * CGFloat(Int(data.data.count/2) + 1)
                self.recommendV.setRecommendData(data: data.data)
            }else{
                print("api_8 empty")
                self.recommendVHeigh.constant = 0.0
            }
        }
    }

}

//#Preview {
//    SwiftUIView()
//}

