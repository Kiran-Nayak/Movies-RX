//
//  DetailViewController.swift
//  Movie
//
//  Created by Kiran Nayak on 11/07/23.
//

import UIKit
import RxRelay
import RxSwift
import RxCocoa

/// It's the details screen of movie application
class DetailViewController: UIViewController {
    
    @IBOutlet weak var lblRelease: UILabel!
    @IBOutlet weak var lblGenre: UILabel!
    @IBOutlet weak var lblCast: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    var data: Movies?
    @IBOutlet weak var btnRatings: UIButton!
    
    @IBOutlet weak var imgPoster: UIImageView!
    
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let data = data else {
            self.navigationController?.popViewController(animated: true)
            return
        }
        imgPoster.load(urlString: data.Poster ?? "")
        lblTitle.text = data.Title ?? ""
        lblCast.text = "Plot: \(data.Plot ?? "")"
        lblRelease.text = "Released: \(data.Released ?? "")"
        lblGenre.text = "Genre: \(data.Genre ?? "")"
        btnRatings.rx.tap.bind {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "RatingViewController") as! RatingViewController
            vc.arrRatings.accept(data.Ratings ?? [])
            self.present(vc, animated: true)
        }.disposed(by: bag)
        
    }
    
}
