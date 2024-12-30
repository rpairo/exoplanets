import Composition
import Presentation

@main
struct Main {
    static func main() async {
        do {
            let appComposition: ApplicationBuilder = AppComposition()
            try await appComposition.build()

            let terminal: ExoplanetDisplaying = try DIContainer.shared.resolve()
            terminal.show()
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}
