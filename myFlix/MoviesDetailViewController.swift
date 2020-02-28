//
//  MoviesDetailViewController.swift
//  myFlix
//
//  Created by Aryan Khadiri on 2/27/20.
//  Copyright © 2020 AryanKhadiri@gmail.com. All rights reserved.
//

import UIKit

class MoviesDetailViewController: UIViewController {
    var movie:[String:Any]!
    @IBOutlet weak var backDrop: UIImageView!
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var synopsis: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = movie["title"] as? String
        synopsis.text = movie["overview"] as? String
        titleLabel.sizeToFit()
        synopsis.sizeToFit()
        // Do any additional setup after loading the view.
        let baseURL = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string:baseURL+posterPath)!
        let backdropPath = movie["backdrop_path"] as! String
        let backdropUrl = URL(string:"https://image.tmdb.org/t/p/w780"+backdropPath)
        poster.af_setImage(withURL: posterUrl)
        backDrop.af_setImage(withURL: backdropUrl!)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
