//
//  ViewController.swift
//  Movies
//
//  Created by Kiran Nayak on 17/07/23.
//

import UIKit
import RxSwift
import RxCocoa

/// It's the home screen of movie application
class HomeViewController: UIViewController {
    private var homeViewModel: HomeViewModel = HomeViewModel(movieRepository: MovieRepositoryIMPL())
    
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var tblView: UITableView!
    
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
        title = "Movies"
        
        registerTableCell()
        
        searchField.rx.text.orEmpty.throttle(.microseconds(300), scheduler: MainScheduler.instance).distinctUntilChanged().subscribe { [weak self] query in
            self?.homeViewModel.getMoviesSearch(query)
        }.disposed(by: bag)
        
        homeViewModel.moviesList.bind(to: tblView.rx.items) { (tableView, row, element) in
            if element.type == .titleList {
                let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell") as! TitleTableViewCell
                cell.lblTitle.text = element.title ?? ""
                return cell
            }else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell") as! MovieTableViewCell
                cell.lblTitle.text = element.movies?.Title ?? ""
                cell.lblRelease.text = "Released \(element.movies?.Released ?? "")"
                cell.lblLanguage.text = "Language \(element.movies?.Language ?? "")"
                cell.imgPoster.load(urlString: element.movies?.Poster ?? "")
                return cell
            }
        }.disposed(by: bag)
        
        // Handling the errors
        homeViewModel.moviesResponseError.subscribe { [weak self] error in
            let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
            self?.present(alert, animated: true)
        }.disposed(by: bag)
        
        tblView.rx.modelSelected(MoviesList.self).subscribe { [weak self] movieList in
            guard let self = self else {
                return
            }
            if movieList.type == .posterList {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
                vc.data = movieList.movies
                self.navigationController?.pushViewController(vc, animated: true)
            }else {
                self.homeViewModel.getSelectedCategoryItems(type: movieList.category, filter: movieList.title ?? "", filterType: movieList.filterBy)
            }
        }.disposed(by: bag)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Clear All", style: .done, target: self, action: #selector(onClearFilter))
        
        // get the data from server / local
        homeViewModel.getMoviesData()
        
    }
    
    func registerTableCell() {
        tblView.register(TitleTableViewCell.nib(), forCellReuseIdentifier: "TitleTableViewCell")
        tblView.register(MovieTableViewCell.nib(), forCellReuseIdentifier: "MovieTableViewCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    @objc private func onClearFilter() {
        homeViewModel.getMoviesData()
        searchField.text = ""
    }
}
