//
//  ViewController.swift
//  XCReview
//
//  Created by Pichratanak Ky on 26/2/20.
//  Copyright © 2020 Pichratanak Ky. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    private var data: [Review] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        for _ in 0...5 {
            self.data.append(Review())
        }
        
        self.tableView.estimatedRowHeight = 233.0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.selectionStyle = .none
        
        if cell.contentView.subviews.contains(where: { $0.tag == 999 }) == false {
            let customView = Bundle.main.loadNibNamed(String(describing: AwesomeReviewView.self), owner: self, options: nil)?.first as! AwesomeReviewView
            customView.tag = 999
            cell.contentView.addSubview(customView)
            customView.translatesAutoresizingMaskIntoConstraints = false
            customView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor).isActive = true
            customView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor).isActive = true
            customView.topAnchor.constraint(equalTo: cell.contentView.topAnchor).isActive = true
            customView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor).isActive = true
            
            customView.onSeeMoreDidTap { [weak self] in
                
                self?.data[indexPath.row].isExpanded.toggle()
                tableView.beginUpdates()
                tableView.endUpdates()
            }
            
            customView.setupWith(self.data[indexPath.row])
        }
        
        return cell
    }
}

struct Review {
    
    var title: String = "Robert Downey Jr"
    var date: String = "12th Feb 2020"
    var memberSince: String = "Is a member since 2011"
    var isExpanded: Bool = false
    var description: String  = "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text."
}
