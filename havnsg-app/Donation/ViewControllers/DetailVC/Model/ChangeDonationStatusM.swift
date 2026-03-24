struct ChangeDonationRequestStatusM : Codable {
    let success: Bool?
    let message: String?
    let errorCount: Int?
    let error: [ChangeDonationStatusError]?
}

struct ChangeDonationStatusError : Codable {
    let param : String?
    let msg : String?
}
