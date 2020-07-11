//
//  MasterViewController.swift
//  PhilMovies
//
//  Created by Philippe ROUGERIE on 02/06/2020.
//  Copyright © 2020 Philippe ROUGERIE. All rights reserved.
//

import UIKit
import MoviesFramework

class MasterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var detailViewController: DetailViewController? = nil
    var movies = [Movie]()
    var loading = true
    let service = MoviesService()
    var page = 1
    var endPoint = MoviesService.Endpoint.nowPlaying
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
           super.viewDidLoad()
           fetchMovies(endpoint: .nowPlaying, page: page)
           let nib = UINib(nibName: MovieCell.identifier, bundle: nil)
           tableView.register(nib, forCellReuseIdentifier: MovieCell.identifier)
              
       }
       
       
       @objc
       func insertNewObject(_ sender: Any) {
           //let indexPath = IndexPath(row: 0, section: 0)
           //tableView.insertRows(at: [indexPath], with: .bottom)
           tableView.reloadData()
       }
       
              
       override func viewWillAppear(_ animated: Bool) {
           //clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
           super.viewWillAppear(animated)
            
       }
       
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "showDetail" {
               if let indexPath = tableView.indexPathForSelectedRow {
                let movie = movies[indexPath.row]
                   let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                   controller.detailItem = movie
                   controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                   controller.navigationItem.leftItemsSupplementBackButton = true
                   detailViewController = controller
               }
           }
       }
       
        override func didReceiveMemoryWarning() {
              super.didReceiveMemoryWarning()
              // Dispose of any resources that can be recreated.
          }

          
       // MARK: - Table View



        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return movies.count
       }
    

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as! MovieCell
           let movie = movies[indexPath.row]
           cell.moviename.text = movie.title
           return cell
       }



        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
           if editingStyle == .delete {
               movies.remove(at: indexPath.row)
               tableView.deleteRows(at: [indexPath], with: .fade)
           } else if editingStyle == .insert {
               // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
           }
               
       }

              // MARK: - Segues
       
       private func fetchMovies(endpoint : MoviesService.Endpoint, page: Int){
           service.fetchMovies(from: endpoint, language: "fr-FR", page :page) { (result: Result<MoviesResponse, NetworkError>) in
               switch result {
                   case .success(let movieResponse):
                       //print(movieResponse.results)
                       self.movies = movieResponse.results
                   DispatchQueue.main.async {
                       self.tableView.reloadData()
                   }
               case .failure(let error):
                       print(error.localizedDescription)
               }
           }
           
       }
    
    @IBAction func nowPlaying(_ sender: Any) {
        page = 1
        endPoint = .nowPlaying
        fetchMovies(endpoint: endPoint, page: page)
    }
    
    @IBAction func upComing(_ sender: Any) {
        page = 1
        endPoint = .upcoming
        fetchMovies(endpoint: endPoint, page: page)
    }
    
    @IBAction func topRated(_ sender: Any) {
        page = 1
        endPoint = .topRated
        fetchMovies(endpoint: .topRated, page: page)
    }
    
    @IBAction func popular(_ sender: Any) {
        page = 1
        endPoint = .popular
        fetchMovies(endpoint: .popular, page : page)
    }
    
    @IBAction func back(_ sender: Any) {
        if (page==1){
            return
        }
        page -= 1
        fetchMovies(endpoint: endPoint, page: page)    }
    
    @IBAction func next(_ sender: Any) {
        
        
        page += 1
        fetchMovies(endpoint: endPoint, page: page)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailViewController = storyboard.instantiateViewController(identifier: "detailViewIdentifier") as! DetailViewController
         detailViewController.detailItem = movie
        navigationController?.pushViewController(detailViewController, animated: true)
    }
                

       
}

