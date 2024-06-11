//
//  CaroseScrollerView.swift
//  Demo
//
//  Created by CLships on 2024/6/10.
//

import Foundation
import UIKit
protocol CaroseScrollerViewDelegate{
    func nowPage(page:Int)
}

class CaroseScrollerView: UIScrollView, UIScrollViewDelegate {
    var carDelegate:CaroseScrollerViewDelegate?
    
    private var images: [UIImage] = []
    private var imgViews: [UIImageView] = []
    private var currentIndex: Int = 0
    private var timer: Timer?
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = UIColor.blue
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        return pageControl
    }()
    
    init(frame: CGRect, images: [UIImage]) {
        super.init(frame: frame)
        self.images = images
        setupScrollView()
        setupPageControl()
        startTimer()
        
        // Disable scroll gesture and add swipe gestures
        isScrollEnabled = false
        addSwipeGestures()
    }
    
    func setImage(image: UIImage,idx:Int){
        self.imgViews[idx].image = image
    }
    
    func setImage(images:[UIImage]){
        self.images = images
        setupScrollView()
        pageControl.numberOfPages = images.count
        startTimer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupScrollView() {
        delegate = self
        isPagingEnabled = true
        contentSize = CGSize(width: frame.width * CGFloat(images.count), height: frame.height)
        
        imgViews.removeAll()
        for (index, image) in images.enumerated() {
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.frame = CGRect(x: frame.width * CGFloat(index), y: 0, width: frame.width, height: frame.height)
            imgViews.append(imageView)
            addSubview(imageView)
        }
    }
    
    private func setupPageControl() {
        pageControl.numberOfPages = images.count
        addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    private func startTimer() {
        if timer != nil {
            timer?.invalidate()
        }
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(nextImage), userInfo: nil, repeats: true)
    }
    
    @objc private func nextImage() {
        let nextPage = (currentIndex + 1) % images.count
        setContentOffset(CGPoint(x: frame.width * CGFloat(nextPage), y: 0), animated: true)
        carDelegate?.nowPage(page: nextPage)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = page
        currentIndex = page
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        timer?.invalidate()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        startTimer()
    }
    
    // MARK: - Swipe Gestures
    
    private func addSwipeGestures() {
        let leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestureHandler(_:)))
        leftSwipeGesture.direction = .left
        addGestureRecognizer(leftSwipeGesture)
        
        let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeGestureHandler(_:)))
        rightSwipeGesture.direction = .right
        addGestureRecognizer(rightSwipeGesture)
    }
    
    @objc private func swipeGestureHandler(_ gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case .left:
            showNextImage()
        case .right:
            showPreviousImage()
        default:
            break
        }
    }
    
    private func showNextImage() {
        let nextPage = (currentIndex + 1) % images.count
        setContentOffset(CGPoint(x: frame.width * CGFloat(nextPage), y: 0), animated: true)
        carDelegate?.nowPage(page: nextPage)
    }
    
    private func showPreviousImage() {
        let previousPage = (currentIndex - 1 + images.count) % images.count
        setContentOffset(CGPoint(x: frame.width * CGFloat(previousPage), y: 0), animated: true)
        carDelegate?.nowPage(page: previousPage)
    }
}
