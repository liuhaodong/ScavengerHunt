//
//  ListViewController.swift
//  ScanvageHunt
//
//  Created by Haodong Liu on 9/23/14.
//  Copyright (c) 2014 Haodong Liu. All rights reserved.
//

import Foundation

import UIKit

class ListViewController : UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var itemsManager = ItemsManager()
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsManager.items.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ListViewCell") as UITableViewCell
        
        let item = itemsManager.items[indexPath.row]
        cell.textLabel!.text = item.name
        
        if(item.isComplete){
            cell.accessoryType = .Checkmark
            cell.imageView!.image = item.photo
        }else{
            cell.accessoryType = .None
            cell.imageView?.image = nil
        }
        
        return cell
    }
    
    @IBAction func unwindToList(segue: UIStoryboardSegue){
        if segue.identifier == "DoneItem"{
            let addItemController = segue.sourceViewController as ViewController
            if let newItem = addItemController.createdItem{
                itemsManager.items += [newItem]
                let indexPath = NSIndexPath(forRow: itemsManager.items.count - 1, inSection: 0)
                self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
                itemsManager.save()
            }
        }
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        let imagePicker = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.Camera){
            imagePicker.sourceType = .Camera
        }else{
            imagePicker.sourceType = .PhotoLibrary
        }
        
        imagePicker.delegate = self
        presentViewController(imagePicker, animated: true, completion: nil)
        
        
    }
    
     func imagePickerController(picker: UIImagePickerController!, didFinishPickingMediaWithInfo info: NSDictionary) {
        let indexPath = tableView.indexPathForSelectedRow()!
        let selectedItem = itemsManager.items[indexPath.row]
        
        let photo = info[UIImagePickerControllerOriginalImage] as UIImage
        selectedItem.photo = photo
        itemsManager.save()
        
        
        dismissViewControllerAnimated(true, completion:{
            self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
            self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation:.Automatic)
        })
    }
    
}