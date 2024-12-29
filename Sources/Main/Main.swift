import Composition

@main
struct Main {
    static func main() async {
        do {
            let appComposition: ApplicationFlow = AppComposition()
            try appComposition.build()
            try await appComposition.start()
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}
