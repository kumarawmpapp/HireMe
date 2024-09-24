//
//  SuggestionsView.swift
//  HireMeClient
//
//  Created by Sanjeewa Bamunusinghe on 11/3/17.
//  Copyright © 2017 Pradeep Kumara. All rights reserved.
//

import UIKit

class SuggestionsTableCell: UITableViewCell {
    @IBOutlet weak var lblPrimary: BaseLabel!
    @IBOutlet weak var lblSecondary: BaseLabel!
}

protocol SuggestionViewDelegate {
    func suggestionsViewSelect(withItem item: AutocompletePrediction)
}

extension SuggestionViewDelegate {
    func suggestionsViewSelect(withItem item: AutocompletePrediction) {
        
    }
}

class SuggestionsView: CustomView {
    @IBOutlet weak var tblSuggestions: UITableView!
    
    var delegate: SuggestionViewDelegate?
    
    var suggestionsArray: Array<AutocompletePrediction> = [AutocompletePrediction]()
    {
        didSet {
            DispatchQueue.main.async {
                self.tblSuggestions.reloadData()
            }
        }
    }
    
    override func initView() {
        super.initView()
        
        tblSuggestions.register(UINib(nibName: "SuggestionsViewCell", bundle: nil), forCellReuseIdentifier: "SuggestionsTableCell")
        
        tblSuggestions.delegate = self
        tblSuggestions.dataSource = self
    }
    
    override func styleSubViews() {
        
    }
    override func localizeSubViews() {
    }
}

extension SuggestionsView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return suggestionsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SuggestionsTableCell", for: indexPath) as! SuggestionsTableCell
        
        let prediction = suggestionsArray[indexPath.row]
        
        cell.lblPrimary.attributedText = prediction.attributedPrimaryText
        cell.lblSecondary.attributedText = prediction.attributedSecondaryText
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let prediction = suggestionsArray[indexPath.row]
        delegate?.suggestionsViewSelect(withItem: prediction)
    }
}
