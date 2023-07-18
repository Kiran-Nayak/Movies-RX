//
//  RatingBottomSheet.swift
//  Movies
//
//  Created by Kiran Nayak on 17/07/23.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay

/// It's the rating screen of Movie application
class RatingViewController: UIViewController {
    var arrRatings: BehaviorRelay<[Rating?]> = BehaviorRelay(value: [])
    @IBOutlet weak var tblView: UITableView!
    
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblView.register(RatingsTableViewCell.nib(), forCellReuseIdentifier: "RatingsTableViewCell")
        
        arrRatings.bind(to: tblView.rx.items(cellIdentifier: "RatingsTableViewCell", cellType: RatingsTableViewCell.self)) { (index, element, cell) in
            cell.lblTitle.text = element?.Source ?? ""
            cell.lblRating.text = element?.Value ?? ""
        }.disposed(by: bag)

    }
}
