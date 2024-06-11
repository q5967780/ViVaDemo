//
//  NotificationView.swift
//  Demo
//
//  Created by CLships on 2024/6/11.
//

import UIKit
import Kingfisher

class NotificationView: UIView {
    private var notiData: [DemoResults.DataList] = []
    private var stepRollView: WSLRollView!
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
        let nib = UINib(nibName: "NotificationView", bundle: Bundle(for: type(of: self)))
        let xibView = nib.instantiate(withOwner: self)[0] as! UIView
        addSubview(xibView)
        
        stepRollView = WSLRollView.init(frame: CGRect(x: 0, y: 0, width: ModelAppUtils.width, height: 150))
        stepRollView.scrollStyle = .step
        stepRollView.scrollDirection = .horizontal
        stepRollView.loopEnabled = true
        stepRollView.speed = 120
        stepRollView.delegate = self
        addSubview(stepRollView)
    }
    
    func setNotificationData(data: [DemoResults.DataList]) {
        notiData = data
        setData()
    }
    
    func setData(){
        var idA: [String] = []
        var titleA: [String] = []
        var urlA: [String] = []
        for obj in notiData {
            idA.append(String(obj.id))
            titleA.append(obj.title)
            urlA.append(obj.thumbnailUrl)
        }
        stepRollView.idArray = NSArray(array: idA) as? [Any]
        stepRollView.titleArray = NSArray(array: titleA) as? [Any]
        stepRollView.urlArray = NSArray(array: urlA) as? [Any]
        stepRollView.reloadData()
    }
}

extension NotificationView: WSLRollViewDelegate {
    func spaceOfItem(in rollView: WSLRollView!) -> CGFloat {
        return 5
    }
    
    func rollView(_ rollView: WSLRollView!, cellForItemAt index: Int) -> WSLRollViewCell! {
        let cell = rollView.dequeueReusableCell(withReuseIdentifier: "WSLItemID", for: index)
        cell?.titleLabel.text = "\(String(notiData[index].id))\n\n\(notiData[index].title)"
        
        if let url = URL(string: notiData[index].thumbnailUrl) {
            KingfisherManager.shared.retrieveImage(with: url) { result in
                switch result {
                case .success(let value):
                    cell?.imageView.image = value.image
                case .failure(_):
                    print("Error downloading image: NotificationView.\(index)")
                    break
                }
            }
        }else{
            print("Error id:\(notiData[index].id) thumbnailUrl")
        }
        return cell
    }
    
    
    func rollView(_ rollView: WSLRollView!, sizeForItemAt index: Int) -> CGSize {
        return CGSizeMake(ModelAppUtils.width, 150)
    }
}
