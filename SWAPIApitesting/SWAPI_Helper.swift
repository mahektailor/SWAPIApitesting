import Foundation

struct SWAPI_Helper {
    private static let baseURLString = "https://swapi.dev/api/"

    enum ResourceType: String {
        case characters = "people/"
        case starships = "starships/"
        case planets = "planets/"
    }

    static func fetch<T: Codable>(_ resourceType: ResourceType, completion: @escaping (Result<T, Error>) -> Void) {
        let urlString = baseURLString + resourceType.rawValue
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }

            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

enum NetworkError: Error {
    case invalidURL
    case noData
    // Add more error cases as needed
}
