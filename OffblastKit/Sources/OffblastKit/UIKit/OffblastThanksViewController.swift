//
//  ThanksViewController.swift
//  OffblastKit
//
//  Created by Ryan Renna on 2014-11-16.
//  Copyright (c) 2014 Offblast Softworks. All rights reserved.
//

import UIKit

public class PersonCell : UITableViewCell
{
    public override func awakeFromNib()
    {
        self.textLabel?.backgroundColor = .clear
    }
}

public class OffblastThanksViewController : OffblastScreenViewController, UITableViewDelegate, UITableViewDataSource
{
    //Private
    private let _usernamesToThank : Array<String> = []
    public func usernamesToThank() -> Array<String>
    {
        return _usernamesToThank
    }
    
    // MARK: UITableView Delegate and DataSource Methods
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return usernamesToThank().count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath) as! PersonCell
        let usernameToThank = usernamesToThank()[indexPath.row]
        cell.textLabel?.text = usernameToThank
        
        return cell
    }

}
