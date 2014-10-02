//
//  MovieDetailsViewController.swift
//  rottentomamotes
//
//  Created by Perry Zheng on 9/15/14.
//  Copyright (c) 2014 Perry Zheng. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    var movie: Movie!
    var preloadImage: UIImage!
    
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingsLabel: UILabel!
    @IBOutlet weak var mpaaLabel: UILabel!
    @IBOutlet weak var synopsisTextView: UITextView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("movie=\(movie)")
        
        self.titleLabel.text = movie.title
        self.ratingsLabel.text = "Critics Score: \(movie.criticsScore), Audience Score: \(movie.audienceScore)"
        self.mpaaLabel.text = movie.mpaaRating
        self.synopsisTextView.text = movie.synopsis
        self.imageView.image = preloadImage
        self.imageView.setImageWithURL(NSURL(string: movie.originalPosterUrl))
        
        let offset = CGFloat(350) // space between top of screen to top of the details view
        let barHeight = self.navigationController?.toolbar.frame.size.height // let's say 30
        let scrollViewContentHeight = self.view.frame.origin.y + self.view.frame.size.height + offset - barHeight!   // 0 + 568 + 350 - 30 --> basically the height has to be larger than the screen (so when it comes back up it fits exactly into the screen - minus the bar height area)

        scrollView.contentSize = CGSizeMake(self.view.frame.size.width, scrollViewContentHeight)
        scrollView.alwaysBounceVertical = true
        
        self.detailsView.sizeToFit() // snuggle into the main screen
        self.detailsView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.6)
        
        // set different parts' colors
        self.titleLabel.textColor = UIColor.whiteColor()
        self.ratingsLabel.textColor = UIColor.whiteColor()
        self.mpaaLabel.textColor = UIColor.whiteColor()
        self.synopsisTextView.textColor = UIColor.whiteColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
