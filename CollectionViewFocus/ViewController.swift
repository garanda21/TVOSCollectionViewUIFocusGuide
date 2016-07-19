//
//  ViewController.swift
//  CollectionViewFocus
//
//  Created by Giovanny Aranda on 19/7/16.
//  Copyright © 2016 Giovanny Aranda. All rights reserved.
//

import UIKit

class ViewController: UIViewController,  UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var btClick: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var focusGuide: UIFocusGuide!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        collectionView.delegate = self;
        collectionView.dataSource = self;
        
        focusGuide = UIFocusGuide();
        focusGuide.preferredFocusedView = btClick
        view.addLayoutGuide(focusGuide)
        
        focusGuide.topAnchor.constraintEqualToAnchor(btClick.topAnchor).active = true
        focusGuide.rightAnchor.constraintEqualToAnchor(collectionView.rightAnchor).active = true
        
        focusGuide.widthAnchor.constraintEqualToAnchor(btClick.widthAnchor, multiplier: 8).active = true
        focusGuide.heightAnchor.constraintEqualToAnchor(btClick.heightAnchor).active = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        self.view.showLayoutGuides()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10;
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1;
    }

    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CollectionViewCell
        cell.lbCollectionName.text = "Item \(indexPath.row+1)";
        return cell;
    }

}

