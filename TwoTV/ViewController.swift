//
//  ViewController.swift
//  TwoTV
//
//  Created by Thaw De Zin on 12/4/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var firstTV: UITableView!
    @IBOutlet weak var heightFirstTV: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        firstTV.register(UINib(nibName: "FirstTableViewCell", bundle: nil), forCellReuseIdentifier: "FirstTableViewCell")
        firstTV.rowHeight = UITableView.automaticDimension
        allAboutNoti()
        
    }
    
    func allAboutNoti(){
        NotificationCenter.default.addObserver(self, selector: #selector(refreshEntireTable), name: Notification.Name(rawValue: "ut"), object: nil)
    }
    
    @objc func refreshEntireTable(){
        print("layoutSubView in inner cell")
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
            
            //self.heightFirstTV.constant = self.firstTV.contentSize.height
            
            self.firstTV.reloadData()
            
            self.firstTV.setNeedsLayout()
            self.firstTV.layoutIfNeeded()
            
            self.firstTV.reloadData()
            
        })
    }

}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FirstTableViewCell", for:  indexPath) as! FirstTableViewCell
        cell.firstLbl.text = "\(indexPath.row)"
//        cell.setNeedsLayout()
//        cell.layoutIfNeeded() 
        return cell
    }
    
    
}

class Helper {
    static var seeMoreList : [Int]  = []
    static var currentIndex : Int = -999
}
extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
