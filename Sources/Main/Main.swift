import Composition

@main
struct Main {
    static func main() async {
        do {
            let environment = EnvironmentFactory.create()
            let appComposition: ApplicationFlow = AppComposition()
            appComposition.build(for: environment)
            try await appComposition.start()
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}
