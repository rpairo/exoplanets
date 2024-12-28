import Composition

@main
struct Main {
    static func main() async {
        do {
            let environment = try EnvironmentFactory.create()
            let appComposition: ApplicationFlow = AppComposition()
            try appComposition.build(for: environment)
            try await appComposition.start()
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}
