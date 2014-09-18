//
//  MoviesViewController.swift
//  rottentomamotes
//
//  Created by Perry Zheng on 9/14/14.
//  Copyright (c) 2014 Perry Zheng. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var moviesTableView: UITableView!
    var movies: [NSDictionary] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
        
//        self.view.showActivityViewWithLabel("Loading")
//        self.view.hideActivityViewWithAfterDelay(2)
        
        self.view.showActivityViewWithMode(RNActivityViewModeIndeterminate, label: "Loading", detailLabel: nil) {
            var url = "http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=g6uyqf4fpfv62u74d53zd6hw&limit=20&country=us"
            
            var request = NSURLRequest(URL: NSURL(string: url))
            
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
                (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
                var object = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
                self.movies = object["movies"] as [NSDictionary]
                self.moviesTableView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        [self.searchBar resignFirstResponder];
//        
//        [tableView deselectRowAtIndexPath:indexPath animated:NO];
//        MovieCell *movieCell = (MovieCell *)[tableView cellForRowAtIndexPath:indexPath];
//        
//        MovieDetailViewController *movieDetailViewController = [[MovieDetailViewController alloc] init];
//        if (isSearch) {
//            movieDetailViewController.movie = self.searchResult[indexPath.row];
//        } else {
//            movieDetailViewController.movie = self.movies[indexPath.row];
//        }
//        movieDetailViewController.preloadImage = [movieCell.posterView image];
//        [self.navigationController pushViewController:movieDetailViewController animated:YES];
//        ---------------------------------------------
//            
//            [tableView deselectRowAtIndexPath:indexPath animated:YES];
//        
//        MovieDetailViewController *mdvc = [[MovieDetailViewController alloc]init];
//        NSDictionary *movie = self.movies[indexPath.row];
//        mdvc.movieData = movie;
//        
//        [self.navigationController pushViewController:mdvc animated:YES];
//
//        -------------------------------------------------
//        [tableView deselectRowAtIndexPath:indexPath animated:YES];
//        
//        MovieDetailViewController *mdvc = [[MovieDetailViewController alloc]init];
//        NSDictionary *movie = self.movies[indexPath.row];
//        mdvc.movieData = movie;
//        
//        [self.navigationController pushViewController:mdvc animated:YES];
        
//        tableView.deselectRowAtIndexPath(indexPath, animated: true)
//        let mdvc: MovieDetailsViewController = MovieDetailsViewController()
//        let movie: NSDictionary = self.movies[indexPath.row]
//        mdvc.mov
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let cell = sender as? MovieCell {
            let indexPath = self.moviesTableView.indexPathForCell(cell)
            let mdvc = segue.destinationViewController as MovieDetailsViewController
            mdvc.movie = self.movies[indexPath!.row] as NSDictionary
            mdvc.preloadImage = cell.posterImage!.image!
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("MovieCell") as MovieCell

//        println("Hello, I am at \(indexPath.row), section \(indexPath.section)")
//        cell.textLabel?.text = "Hello, I am at \(indexPath.row), section \(indexPath.section)"
        
        var movie = movies[indexPath.row]
        cell.titleLabel.text = movie["title"] as? String
        cell.synopsisLabel.text = movie["synopsis"] as? String
        
        var posters = movie["posters"] as NSDictionary
        var posterUrl = posters["thumbnail"] as String
        
        cell.posterImage.setImageWithURL(NSURL(string: posterUrl))
        
        return cell
    }
}
