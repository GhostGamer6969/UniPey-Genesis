import Foundation

// Define the CPData struct with Identifiable conformance.
struct CPData: Codable, Identifiable {
    var id: UUID = UUID()  // Use UUID for the id field
    let name: String
    let flag: String
    let code: String
    let dial_code: String
    let pattern: String
    let limit: Int
    
    // Example data for testing purposes
    static let allCountry: [CPData] = Bundle.main.decode("CountryNumbers.json")
    static let example = allCountry[0]
}

// Bundle extension to decode the JSON data.
extension Bundle {
    func decode<T: Decodable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        let decoder = JSONDecoder()

        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }

        return loaded
    }
}
