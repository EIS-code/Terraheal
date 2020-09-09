//
//  MassagePreferenceTblCell.swift
//  Terra Heal
//
//  Created by Jaydeep on 12/05/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import UIKit

class MyBookingTblCell: TableCell {

    @IBOutlet weak var lblName: ThemeLabel!
    @IBOutlet weak var vwCollapse: UIView!
    @IBOutlet weak var btnAction: ThemeButton!
    @IBOutlet weak var ivForplace: UIImageView!
    @IBOutlet weak var vwExpanded: UIView!
    
    @IBOutlet weak var vwBar: UIView!
    
    
    @IBOutlet weak var vwDate: UIView!
    @IBOutlet weak var lblDate: ThemeLabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var htblVw: NSLayoutConstraint!
    var anyArray:[String] = ["a","b","c","d"]
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        self.lblName?.setFont(name: FontName.Bold, size: FontSize.label_18)
        self.lblDate?.setFont(name: FontName.Bold, size: FontSize.label_18)
        self.vwCollapse?.setRound(withBorderColor: .clear, andCornerRadious: 15.0, borderWidth: 1.0)
        self.vwExpanded?.setRound(withBorderColor: .clear, andCornerRadious: 15.0, borderWidth: 1.0)
        self.btnAction?.setFont(name: FontName.SemiBold, size: FontSize.header)
        self.vwDate?.setRound(withBorderColor: .clear, andCornerRadious: 15, borderWidth: 1.0)
    }

    func setData(data: MyBookingTblDetail ) {
        self.lblName.text = data.title
        self.vwBar.backgroundColor =  data.isSelected ? UIColor.green : UIColor.red
        self.expandCell(isExpand: data.isSelected)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.vwCollapse?.setRound(withBorderColor: .clear, andCornerRadious: 15.0, borderWidth: 1.0)
        self.vwExpanded?.setRound(withBorderColor: .clear, andCornerRadious: 15.0, borderWidth: 1.0)
        self.vwDate?.setRound(withBorderColor: .clear, andCornerRadious: 15, borderWidth: 1.0)
    }

    func expandCell(isExpand:Bool) {
        if isExpand {
            self.vwExpanded.isHidden = false
            self.vwCollapse.isHidden = true
           // self.setupTableView(tableView: self.tableView)
        } else {
            self.vwExpanded.isHidden = true
            self.vwCollapse.isHidden = false
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}


extension MyBookingTblCell :  UITableViewDelegate,UITableViewDataSource {
    private func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        //tableView.register(MyBookingTblCell.nib(), forCellReuseIdentifier: MyBookingTblCell.name)
        tableView.tableFooterView = UIView()
        tableView
            .reloadData(heightToFit: self.htblVw) {
                
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return anyArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
            return UITableViewCell(style: .default, reuseIdentifier: "cell")
            }
            return cell
        }()
        
        cell.textLabel?.text = anyArray[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section \(section)"
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vw = UIView()
        vw.backgroundColor = UIColor.red
        return vw
    }
}
