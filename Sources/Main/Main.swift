import Composition

@main
struct Main {
    static func main() async {
        do {
            let appComposition: ApplicationFlow = AppComposition()
            try await appComposition.build()
            try appComposition.start()
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}
