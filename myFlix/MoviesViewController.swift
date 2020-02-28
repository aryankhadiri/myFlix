//
//  MoviesViewController.swift
//  myFlix
//
//  Created by Aryan Khadiri on 2/12/20.
//  Copyright © 2020 AryanKhadiri@gmail.com. All rights reserved.
//

import UIKit
import AlamofireImage
class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var movies = [[String:Any]]() //this is an array of dictoinary. [String;Any] means a dictionary with string keys and Any Values
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

              // TODO: Get the array of movies
              // TODO: Store the movies in a property to use elsewhere
              // TODO: Reload your table view data
            self.movies = dataDictionary["results"] as! [[String:Any]]
            self.tableView.reloadData() //it tells the tabledata to re run the two functions

           }

        }
        task.resume()
        // Do any additional setup after loading the view.
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        // what it does: it lets the user to reuse a cell
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        cell.title_label.text = title
        let synopsis = movie["overview"] as! String
        cell.synopsisLabel.text = synopsis
        //let img = movie["poster_path"] as! UIImage
        //cell.posterView.image = img
        let baseURL = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string:baseURL+posterPath)!
        cell.posterView.af_setImage(withURL: posterUrl)
        return cell
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // find the selected movie
        //the sender is the cell that has been tapped on
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for:cell)!
        let movie = movies[indexPath.row]
        
        //pass the selected movie to the detailsviewcontroller
        let detailsViewController = segue.destination as! MoviesDetailViewController
        detailsViewController.movie = movie
        tableView.deselectRow(at: indexPath, animated: true)//takes away the highlighted row when we come back
        
        print("New Screen")
    }
    
}
