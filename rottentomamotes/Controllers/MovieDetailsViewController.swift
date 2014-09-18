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
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    var movie: NSDictionary = [:]
    var preloadImage: UIImage
    
    required init(coder aDecoder: NSCoder) {
        self.preloadImage = UIImage()
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("movie=\(movie)")
        
        self.textView.text = self.movie["synopsis"] as String
        
//        let thumbNailUrl = (self.movie["posters"] as NSDictionary)["thumbnail"] as String
//        println("thumbNailUrl=\(thumbNailUrl)")
//        let imageUrl = NSURL(string: thumbNailUrl)
//        let nsData = NSData(contentsOfURL: imageUrl)
//        self.imageView.image = UIImage(data: nsData)
        
        self.imageView.image = preloadImage
//        
//        NSString *imageUrl = self.movieData[@"posters"][@"thumbnail"];
//        NSURL *url = [NSURL URLWithString:imageUrl];
//        NSData *imageData = [[NSData alloc] initWithContentsOfURL: url];
//        self.moviePosterView.image = [UIImage imageWithData: imageData];
//
        //[self loadImage:[self.movieData valueForKeyPath:@"posters.original"] :self.moviePosterView];
//        NSURL *url = [NSURL URLWithString:imageURL];
//        
//        [imageView setImageWithURL:url];
        
        let originalUrl = (self.movie["posters"] as NSDictionary)["original"] as String
        
        let url = NSURL(string: originalUrl.stringByReplacingOccurrencesOfString("tmb", withString: "ori", options: nil, range: nil))
        println("high res ur=\(url)")
        self.imageView.setImageWithURL(url)
        
        let offset = CGFloat(350)
        let barHeight = self.navigationController?.toolbar.frame.size.height
        println("frame.origin.y= \(self.view.frame.origin.y)")
        println("self.view.frame.size.height = \(self.view.frame.size.height)")
        println("bar height= \(barHeight)")
        let scrollViewContentHeight = self.view.frame.origin.y + self.view.frame.size.height - barHeight! + offset

        scrollView.contentSize = CGSizeMake(self.view.frame.size.width, scrollViewContentHeight)
        scrollView.alwaysBounceVertical = true
        
        println("textView size= \(textView.frame.origin)")
        
        textView.contentSize = CGSizeMake(320, 568)
        textView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.6)
        textView.textColor = UIColor.whiteColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
