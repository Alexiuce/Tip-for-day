//
//  TableViewInputCell.swift
//  SingleDataFlowDemo
//
//  Created by alexiuce  on 2017/8/2.
//  Copyright © 2017年 alexiuce . All rights reserved.
//

import UIKit


protocol TableViewInputCellDelegate : class {
    func inputChanged( cell : TableViewInputCell, text : String );
}


class TableViewInputCell: UITableViewCell {
    
    weak var delegate : TableViewInputCellDelegate?
    @IBOutlet weak var textFiled : UITextField!
    
    @objc @IBAction func textFieldValueChanged(_ sender : UITextField){
        delegate?.inputChanged(cell: self, text: sender.text ?? "")
    }
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
