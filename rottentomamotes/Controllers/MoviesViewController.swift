//
//  MoviesViewController.swift
//  rottentomamotes
//
//  Created by Perry Zheng on 9/14/14.
//  Copyright (c) 2014 Perry Zheng. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITabBarDelegate {
    var movies: [Movie] = []
    var moviesTabSelected = true
    
    @IBOutlet weak var networkerrorLabel: UILabel!
    @IBOutlet weak var moviesTableView: UITableView!
    
    // refresh controls 
    var refreshControl: UIRefreshControl!
    
    // tab bar navigation controller
    @IBOutlet weak var moviesTabBarItem: UITabBarItem!
    @IBOutlet weak var dvdTabBarItem: UITabBarItem!
    @IBOutlet weak var tabBar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        networkerrorLabel.hidden = true
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        
        fetchDataAndupdateUI()
        addRefreshControl()
    }

    func addRefreshControl() {
        refreshControl = UIRefreshControl()
        var attributedString = NSMutableAttributedString(string: "Pull down to refresh")
        refreshControl.attributedTitle = attributedString
        refreshControl.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        moviesTableView.addSubview(refreshControl)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // alternative implementation
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem!) {
        if (item.title == "Movies") {
            moviesTabSelected = true
            navigationItem.title = "Movies"
            loadMovies()
        } else if (item.title == "DVDs") {
            moviesTabSelected = false
            navigationItem.title = "DVDs"
            loadDVDs()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let cell = sender as? MovieCell {
            let indexPathOpt = self.moviesTableView.indexPathForCell(cell)
            if let indexpath = indexPathOpt  {
                if (segue.identifier == "Show Movie") {
                    if let mdvc = segue.destinationViewController as? MovieDetailsViewController {
                        mdvc.movie = self.movies[indexpath.row]
                        mdvc.preloadImage = cell.posterImage.image!
                    }
                }
            }
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("MovieCell") as MovieCell
        
        var movie: Movie = movies[indexPath.row]
        cell.titleLabel.text = movie.title
        cell.synopsisLabel.text = movie.synopsis
        
        // simulate fade in thumbnail images
        cell.posterImage.alpha = 0
        cell.posterImage.setImageWithURL(NSURL(string: movie.thumbnailPosterUrl))
        // images fade in 
        UIView.animateWithDuration(0.3, animations: {
            cell.posterImage.alpha = 1
        })
        
        return cell
    }
    
    func loadMovies() {
        var url = "http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=g6uyqf4fpfv62u74d53zd6hw&limit=20&country=us"
        fetchDataAndupdateUI(url)
    }
    
    func loadDVDs() {
        var url = "http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=axku2sndnpg2d6dhjw59wj3d&page_limit=20&country=us"
        fetchDataAndupdateUI(url)
    }
    
    func fetchDataAndupdateUI(url: String) {
        // show loading state
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        var request = NSURLRequest(URL: NSURL(string: url)!)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
            (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            if (nil != error) {
                // show network error
                self.networkerrorLabel.hidden = false
                println("got an error = \(error)")
            } else {
                self.networkerrorLabel.hidden = true
                var object = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
                let movies = object["movies"] as [NSDictionary]
                self.movies = Movie.initWithMoviesArray(movies)
                self.moviesTableView.reloadData()
                MBProgressHUD.hideHUDForView(self.view, animated: true)
            }
        }
    }
}
