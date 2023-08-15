//
//  CoverProductCell.swift
//  CleanArchitecture
//
//  Created by KHOI LE on 5/30/21.
//  Copyright © 2021 Sun Asterisk. All rights reserved.
//

import UIKit
import ImageSlideshow

class CoverProductCell: PageTableCell {
    
    @IBOutlet weak var covers: ImageSlideshow!
    @IBOutlet weak var paging: UIView!
    @IBOutlet weak var pagingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configView()
    }
    
    private func configView() {
        paging.layer.cornerRadius = 6
        paging.layer.masksToBounds = true
        
        covers.contentScaleMode = UIViewContentMode.scaleAspectFill
        
        let pageIndicator = UIPageControl()
        pageIndicator.currentPageIndicatorTintColor = .clear
        pageIndicator.pageIndicatorTintColor = .clear
        covers.pageIndicator = pageIndicator
        
        covers.activityIndicator = DefaultActivityIndicator()
    }
    
    func bindViewModel(_ viewModel: String) {
        var sdWebImageSource = [SDWebImageSource]()
        let images = viewModel.components(separatedBy: ", ")
        pagingLabel.text = "\(images.count) Hình ảnh"
        print(images)
        for image in images {
            sdWebImageSource.append(SDWebImageSource(url: URL(string: image)!, placeholder: UIImage(named: "empty")))
        }
        covers.setImageInputs(sdWebImageSource)
        covers.pauseTimer()
    }
}
