//
//  ViewController.swift
//  CollectionViewDemo
//
//  Created by Alexcai on 2017/7/12.
//  Copyright © 2017年 Alexcai. All rights reserved.
//

import Cocoa


fileprivate  let ReusedKey = "DemoCellKey"
fileprivate let cellWidth : CGFloat = 100
fileprivate let cellHeight : CGFloat = 100

class ViewController: NSViewController {
    

    @IBOutlet weak var collectionView: NSCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cellNib = NSNib(nibNamed:"CollectionCell", bundle: nil)
        collectionView.register(cellNib, forItemWithIdentifier: ReusedKey)
        
        
        let flowLayout = collectionView.collectionViewLayout as! NSCollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: cellWidth, height: cellHeight)

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}


extension ViewController : NSCollectionViewDataSource{
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let cellItem = collectionView.makeItem(withIdentifier: ReusedKey, for: indexPath)
    
        return cellItem
    }
    
}
extension ViewController : NSCollectionViewDelegate{
  
}


