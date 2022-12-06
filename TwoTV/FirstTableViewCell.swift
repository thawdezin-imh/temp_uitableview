//
//  FirstTableViewCell.swift
//  TwoTV
//
//  Created by Thaw De Zin on 12/4/22.
//

import UIKit

class FirstTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var secondTV: UITableView!
    @IBOutlet weak var heightSecondTV: NSLayoutConstraint!
    @IBOutlet weak var firstLbl: UILabel!
    
    var count : Int = 12
    
    var dummyStr : [String] = ["str1", "str2", "str3"]
    var newDummyStr : [String] = ["Hi", "Hello", "Hola"]
    var currentIndex : Int = -1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if let tableView = self.superview as? UITableView{
            if let indexPath = tableView.indexPath(for: self){
                print("Indexpath acquired.")
                print("\(indexPath.row)")
                self.currentIndex = indexPath.row
                
                
            }else{
                print("Indexpath could not be acquired from tableview.")
            }
        }else{
            print("Superview couldn't be cast as tableview")
        }

        
        secondTV.isScrollEnabled = false
  
        secondTV.register(UINib(nibName: "SecondTableViewCell", bundle: nil), forCellReuseIdentifier: "SecondTableViewCell")
        
        secondTV.rowHeight = UITableView.automaticDimension

    }
    
    @IBAction func btnClicked(_ sender: UIButton) {
        if let tableView = self.superview as? UITableView{
            if let indexPath = tableView.indexPath(for: self){
                print("Indexpath acquired.")
                Helper.seeMoreList.append(indexPath.row)
                Helper.currentIndex = indexPath.row
                DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
                    
                    //self.heightFirstTV.constant = self.firstTV.contentSize.height
                    
                    self.secondTV.reloadData()
                    
                    self.secondTV.setNeedsLayout()
                    self.secondTV.layoutIfNeeded()
                    
                    self.secondTV.reloadData()
                    
                })
                NotificationCenter.default.post(name: Notification.Name(rawValue: "ut"), object: nil)
                
            }else{
                print("Indexpath could not be acquired from tableview.")
            }
        }else{
            print("Superview couldn't be cast as tableview")
        }
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        print("layoutSubviews in Cell")
        DispatchQueue.main.async {
            
//            self.secondTV.beginUpdates()
            self.heightSecondTV.constant = self.secondTV.contentSize.height
//            self.secondTV.setNeedsDisplay()
//            self.secondTV.endUpdates()
            
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

extension FirstTableViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("\(Helper.seeMoreList) is Helper.seeMoreList")
        print("\(currentIndex) is current Index")
        print("\(Helper.seeMoreList.contains(Helper.currentIndex)) is true or false")
        
        if Helper.seeMoreList.contains(Helper.currentIndex) {
            return self.newDummyStr.count
        } else {
            return self.dummyStr.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SecondTableViewCell", for:  indexPath) as! SecondTableViewCell
        //cell.innerLbl.text = dummyStr[indexPath.row]
        
        if Helper.seeMoreList.contains(Helper.currentIndex) {
            cell.innerLbl.text = newDummyStr[indexPath.row]
         
        } else {
            cell.innerLbl.text = dummyStr[indexPath.row]
        }
//        cell.setNeedsLayout()
//        cell.layoutIfNeeded()
        NotificationCenter.default.post(name: Notification.Name(rawValue: "ut"), object: nil)
        return cell
    }
    
   
    
    
}
