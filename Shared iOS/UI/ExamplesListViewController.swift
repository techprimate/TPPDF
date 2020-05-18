//
//  ExamplesListViewController.swift
//  TPPDF_Example
//
//  Created by Philip Niedertscheider on 18.12.19.
//  Copyright © 2019 Philip Niedertscheider. All rights reserved.
//

import Foundation
import UIKit

class ExamplesListViewController: UITableViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidLoad()
        performSegue(withIdentifier: "show-example", sender: IndexPath(row: 0, section: 1))
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return Examples.factories.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Examples.factories[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "example-cell", for: indexPath)

        let section = Examples.factories[indexPath.section]
        let item = section[indexPath.row]

        cell.textLabel?.text = item.0

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "show-example", sender: indexPath)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "show-example", let dest = segue.destination as? ViewController, let index = sender as? IndexPath  {
            let section = Examples.factories[index.section]
            let item = section[index.row]

            dest.exampleFactory = item.1
            dest.navigationItem.title = item.0
        }
    }
}
