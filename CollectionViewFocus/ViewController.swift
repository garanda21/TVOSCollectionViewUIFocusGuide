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
    
    fileprivate var focusGuide: UIFocusGuide!
   // var cellSelected: CollectionViewCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        collectionView.delegate = self;
        collectionView.dataSource = self;
        
        focusGuide = UIFocusGuide();
        focusGuide.preferredFocusedView = btClick
        view.addLayoutGuide(focusGuide)
        
        focusGuide.topAnchor.constraint(equalTo: collectionView.bottomAnchor).isActive = true
        focusGuide.bottomAnchor.constraint(equalTo: btClick.bottomAnchor).isActive = true
        focusGuide.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor).isActive = true
        focusGuide.widthAnchor.constraint(equalTo: collectionView.widthAnchor).isActive = true
        
        
    }
    
    func handleLongPress(_ gestureRecognizer : UILongPressGestureRecognizer){
        
        if (gestureRecognizer.state != UIGestureRecognizerState.began){
            return
        }
        
        var cellSelected = gestureRecognizer.view as? CollectionViewCell;
        
        if(cellSelected != nil)
        {
            let title = NSLocalizedString("A Short Title is Best", comment: "")
            let message = NSLocalizedString("You've selected \(cellSelected!.lbCollectionName.text!)", comment: "")
            let cancelButtonTitle = NSLocalizedString("Cancel", comment: "")
            let deleteButtonTitle = NSLocalizedString("Delete", comment: "")
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            // Create the actions.
            let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .cancel) { _ in
                print("The \"Other\" alert's cancel action occurred.")
            }
            
            let deleteAction = UIAlertAction(title: deleteButtonTitle, style: .destructive) { _ in
                print("The \"Other\" alert's other button one action occurred.")
            }
            
            // Add the actions.
            alertController.addAction(cancelAction)
            alertController.addAction(deleteAction)
            
            present(alertController, animated: true, completion: {
                cellSelected = nil;
                });
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        //self.view.showLayoutGuides()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10;
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.lbCollectionName.text = "Item \(indexPath.row+1)";
        
        if(cell.gestureRecognizers?.count == nil)
        {
            let lpgr : UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.handleLongPress(_:)))
            lpgr.minimumPressDuration = 0.5
            //lpgr.delegate = self
            lpgr.delaysTouchesBegan = true
            cell.addGestureRecognizer(lpgr)
        }
        return cell;
    }

}

