//
//  BrowseMealsTableViewController.swift
//  TableBNB
//
//  Created by Key Hoffman on 7/21/16.
//  Copyright © 2016 Key Hoffman. All rights reserved.
//

import Foundation
import UIKit

// MARK: - BrowseMealsTableViewController

final class BrowseMealsTableViewController: TableViewController<MealTableViewCell>, BrowseMealsViewModelViewDelegate, MealTableViewCellDelegate {
    
    private var mealImages: [UIImage?] = []
    
    // MARK: - BrowseMealsViewModelType Declaration
    
    weak var viewModel: BrowseMealsViewModelType? {
        didSet { viewModel?.viewDelegate = self }
    }
    
    // MARK: - BrowseMealsTableViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BrowseMealsStyleSheet.prepare(self)
    }
    
    // MARK: - BrowseMealsViewModelViewDelegate Required Methods
    
    func appendMeal(meal: Meal) {
        self.data.append(meal)
    }
    
    func appendMealImage(image: UIImage) {
        mealImages.append(image)
    }
    
    func anErrorHasOccured(errorMessage: String) {
        title = title ?? String.emptyString() + errorMessage
    }
    
    // MARK: - MealTableViewCellDelegate Required Methods
    
    func showChefDescriptionPopup(forMeal meal: Meal) {
        viewModel?.showChefDescriptionPopup(forMeal: meal)
    }
    
    func showMealDescriptionPopup(forMeal meal: Meal) {
        viewModel?.showMealDescriptionPopup(forMeal: meal)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MealTableViewCell", forIndexPath: indexPath) as! MealTableViewCell
        cell.cellDelegate = self
        cell.configure(withItem: data[indexPath.row])
        cell.mealImageView.image = mealImages[indexPath.row]
        return cell
    }
    
    // MARK: - Optional TableViewDelegate Methods
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
}