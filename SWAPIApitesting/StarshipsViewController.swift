import UIKit

class StarshipsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var starships: [Starship] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self

        // Fetch starships from SWAPI
        SWAPI_Helper.fetch(.starships) { [weak self] (result: Result<[Starship], Error>) in
            switch result {
            case .success(let starships):
                self?.starships = starships
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print("Error fetching starships: \(error)")
            }
        }
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return starships.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StarshipCell", for: indexPath)
        let starship = starships[indexPath.row]
        cell.textLabel?.text = starship.name
        // Configure cell with other starship properties if needed
        return cell
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Handle row selection, navigate to starship detail view, etc.
    }
}
