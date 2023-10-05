//
//  PlanetsViewController.swift
//  SWAPIApitesting
//
//  Created by mahek on 04/10/2023.
//

import UIKit

class PlanetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var planets: [Planet] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self

        // Fetch planets from SWAPI
        SWAPI_Helper.fetch(.planets) { [weak self] (result: Result<[Planet], Error>) in
            switch result {
            case .success(let planets):
                self?.planets = planets
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print("Error fetching planets: \(error)")
            }
        }
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return planets.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlanetCell", for: indexPath)
        let planet = planets[indexPath.row]
        cell.textLabel?.text = planet.name
        // Configure cell with other planet properties if needed
        return cell
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Handle row selection, navigate to planet detail view, etc.
    }
}
