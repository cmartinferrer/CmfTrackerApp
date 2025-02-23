import Foundation

struct Event: Identifiable {
    let id: Int
    let title: String
    let desc: String
    let datetime: String
    let imageData: Data?
}
