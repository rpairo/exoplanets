public extension String {
    func leftAligned(to width: Int) -> String {
        if count >= width {
            return self
        }
        return self + String(repeating: " ", count: width - count)
    }
}
