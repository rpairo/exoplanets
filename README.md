# Exoplanets Analyzer
- This is the library Exoplanets Analyzer, used to consume the provided exoplanets dataset, analyze, process and serve it. You can find the public repository of this project in https://github.com/rpairo/exoplanets.
    - **Library executable:** You can import this project into another swift compatible project using SPM (Swift Package Management) by this coordinates: *.package(url: "https://github.com/rpairo/exoplanets.git", from: "1.0.12")*. Once imported like any other third party library, you should set up the dependency exposition in your project by *.product(name: "ExoplanetsAPI", package: "exoplanets")*, and you will be already ready to use it.
    - **Terminal executable:** You can also execute the project as consumible. Just clone this repository, and run it by the ExoplanetTerminal target, and you will see the result in your terminal. If you prefer, you can also pull the docker for this executable, and use it as easy as you want. You can find the image in dockerhub: https://hub.docker.com/repository/docker/rpairo/exoplanets-terminal and pull it into your local docker by *rpairo/exoplanets-terminal*. I have prepared few scripts that will help you to set up the docker or kubernetes easier, since this projects requires a couple of environmental variables.
        #### [Docker](docker/setup-docker-manual.sh): 
        ![Docker](https://github.com/user-attachments/assets/fb491e18-5038-4918-ae4a-4be07c758777)

        #### [Kubernetes](k8s/scripts/deploy-k8s-resources.sh): Notice there are few scripts I done based on your installed tools. The orchestrator one is *[deploy-k8s-resources.sh](k8s/scripts/deploy-k8s-resources.sh)* but if you wants to do it easier you can execute directly *[create-k8s-secrets-manual.sh](k8s/scripts/create-k8s-secrets-manual.sh)*.
        ![Kubernetes](https://github.com/user-attachments/assets/03488df9-2b35-4532-a388-4664166da674)

- This library that you are currenly reading it is not everything yet. I have created an API Rest that consumes this library as an external dependency, to provide you even more fun! You can find the api rest in https://github.com/rpairo/exoplanets-api. You will find the related documentation in its own README.

## Dataset
Based on the documentation located here: https://www.kaggle.com/datasets/mrisdal/open-exoplanet-catalogue
There are two dataset versions.

I have realised the provided JSON for this assesment: https://gist.githubusercontent.com/joelbirchler/66cf8045fcbb6515557347c05d789b4a/raw/9a196385b44d4288431eef74896c0512bad3defe/exoplanets is based on the version 1.0 of this dataset.

The dataset version 1 has 3426 exoplanets, while the version 2 has 3584.
I have checked, and effectively, by the provided json url, we are receiving 3426 exoplanets. I can confirm it by 2 checks: Same name of records provided, and same number of orphan planets based on TypeFlag: 2. The version 2 has three orphan planets.

In the Kaggle documentation, in the dataset version 2, in detail section we can find referenced the oec tables repository: https://github.com/OpenExoplanetCatalogue/oec_tables.
In this repository, we can find the file FIELDS.md: https://github.com/OpenExoplanetCatalogue/oec_tables/blob/master/FIELDS.md
Where I can find the next field description list:

### Fields description
1. `name` Primary identifier of planet
2. `binaryflag` Binary flag [0=no known stellar binary companion; 1=P-type binary (circumbinary); 2=S-type binary; 3=orphan planet (no star)]
3. `mass` Planetary mass [Jupiter masses]
4. `radius` Radius [Jupiter radii]
5. `period` Period [days]
6. `semimajoraxis` Semi-major axis [Astronomical Units]
7. `eccentricity` Eccentricity
8. `periastron` Periastron [degree]
9. `longitude` Longitude [degree]
10. `ascendingnode` Ascending node [degree]
11. `inclination` Inclination [degree]
12. `temperature` Surface or equilibrium temperature [K]
13. `age` Age [Gyr]
14. `discoverymethod` Discovery method
15. `discoveryyear` Discovery year [yyyy]
16. `lastupdate` Last updated [yy/mm/dd]
17. `system_rightascension` Right ascension [hh mm ss]
18. `system_declination` Declination [+/-dd mm ss]
19. `system_distance` Distance from Sun [parsec]
20. `hoststar_mass` Host star mass [Solar masses]
21. `hoststar_radius` Host star radius [Solar radii]
22. `hoststar_metallicity` Host star metallicity [log relative to solar]
23. `hoststar_temperature` Host star temperature [K]
24. `hoststar_age` Host star age [Gyr]
25. `list` A list of lists the planet is on

I have noticed these fields have been mapped to the received JSON that we had been provided by the assesment. The json structure is the next one:

### JSON Structure
```json
{
    "PlanetIdentifier": "HD 45184 b",
    "TypeFlag": 0,
    "PlanetaryMassJpt": 0.04,
    "RadiusJpt": "",
    "PeriodDays": 5.8872,
    "SemiMajorAxisAU": 0.0638,
    "Eccentricity": 0.3,
    "PeriastronDeg": "",
    "LongitudeDeg": "",
    "AscendingNodeDeg": "",
    "InclinationDeg": "",
    "SurfaceTempK": 1045.8,
    "AgeGyr": "",
    "DiscoveryMethod": "RV",
    "DiscoveryYear": 2011,
    "LastUpdated": "11/09/12",
    "RightAscension": "06 24 44",
    "Declination": "-28 46 48",
    "DistFromSunParsec": 21.9,
    "HostStarMassSlrMass": "",
    "HostStarRadiusSlrRad": "",
    "HostStarMetallicity": "",
    "HostStarTempK": 5940,
    "HostStarAgeGyr": ""
}
```

The JSON fields are based un PascalCase format, with different names mapped from the original dataset repository. Ex. 'binaryflag' is mapped into 'TypeFlag'. I can be sure about it even when I was not able to find any documentation showing up the mapping, cause the available values for 'TypeFlag' are only [0, 1, 2 or 3], the same available values of 'binaryflag'. Since the sintactic aproximation and the values range are really similar, I have assumed they both map eachother.

This is the mapping table I have assumed to work on this assesment.
This mapping is important, since I can understand the fields meaning, to achieve the proposed goals.

### Dataset - JSON field mapping
| **JSON Key**             | **Dataset Field Name**       | **Description**                                                                                  |
|--------------------------|-----------------------------|--------------------------------------------------------------------------------------------------|
| `PlanetIdentifier`       | `name`                     | Primary identifier of the planet.                                                               |
| `TypeFlag`               | `binaryflag`               | Binary flag for planetary system type:                                                          |
|                          |                             | - `0`: No known stellar binary companion.                                                       |
|                          |                             | - `1`: P-type binary (circumbinary).                                                            |
|                          |                             | - `2`: S-type binary (orbits one star in a binary system).                                       |
|                          |                             | - `3`: Orphan planet (no star).                                                                 |
| `PlanetaryMassJpt`       | `mass`                     | Planetary mass in Jupiter masses.                                                              |
| `RadiusJpt`              | `radius`                   | Planetary radius in Jupiter radii.                                                             |
| `PeriodDays`             | `period`                   | Orbital period in days.                                                                         |
| `SemiMajorAxisAU`        | `semimajoraxis`            | Semi-major axis in astronomical units.                                                         |
| `Eccentricity`           | `eccentricity`             | Orbital eccentricity.                                                                           |
| `PeriastronDeg`          | `periastron`               | Argument of periastron in degrees.                                                             |
| `LongitudeDeg`           | `longitude`                | Longitude of periastron in degrees.                                                            |
| `AscendingNodeDeg`       | `ascendingnode`            | Longitude of ascending node in degrees.                                                       |
| `InclinationDeg`         | `inclination`              | Orbital inclination in degrees.                                                                |
| `SurfaceTempK`           | `temperature`              | Surface or equilibrium temperature in Kelvin.                                                  |
| `AgeGyr`                 | `age`                      | Age of the planet/system in billions of years (Gyr).                                           |
| `DiscoveryMethod`        | `discoverymethod`          | Method used to discover the planet.                                                            |
| `DiscoveryYear`          | `discoveryyear`            | Year of discovery.                                                                             |
| `LastUpdated`            | `lastupdate`               | Last update timestamp for the entry.                                                           |
| `RightAscension`         | `system_rightascension`    | Right ascension of the planetary system.                                                       |
| `Declination`            | `system_declination`       | Declination of the planetary system.                                                           |
| `DistFromSunParsec`      | `system_distance`          | Distance from the Sun in parsecs.                                                              |
| `HostStarMassSlrMass`    | `hoststar_mass`            | Mass of the host star in solar masses.                                                         |
| `HostStarRadiusSlrRad`   | `hoststar_radius`          | Radius of the host star in solar radii.                                                        |
| `HostStarMetallicity`    | `hoststar_metallicity`     | Metallicity of the host star relative to solar values.                                         |
| `HostStarTempK`          | `hoststar_temperature`     | Temperature of the host star in Kelvin.                                                        |
| `HostStarAgeGyr`         | `hoststar_age`             | Age of the host star in billions of years (Gyr).                                               |
| `ListsPlanetIsOn`        | `list`                     | A list of catalogs where the planet appears.                                                   |

I have noticed the JSON provided has a specific issue source: Some Int and Double type properties has different type depending if they are null or with value.
Ex. `PlanetaryMassJpt` has `0.076` for `Gliese 3293 b`, but `""` for `Kepler-1037 b`.
This circunsancy can create a serialization issue. This is cause when I create the DTO conforming the Decodable protocol, I have to setup the expected value type. And for Int and Double types, there is not direct conversion from empty string `""` into `0`, `0.0` or `nil`.
To solve this casuistic, I have implemented the decodable constructor, and manually set up the conversions.

I have extended the `KeyedDecodingContainer` struct, that is the responsable to hanlde the type decoding from decodable protocol, and the henadling functions will be cleaner stored in it's better responsability scope. I have created 2 functions to handle the string null casuistic for know Int and Double fields.
First, I try to decode from String type. In case this is `true`, I will return `nil`.
In case it is not possible to decode from String, means its the expected value, `Int` or `Double` depending the case. Then I can decode this and return it.
Thankfuly using the optionals for those values, I can easily handle this casuistic with standarize `null` values.

```swift
// Helper function to handle decoding for Double
func decodeIfPresentDouble(forKey key: K) throws -> Double? {
    if let _ = try? decodeIfPresent(String.self, forKey: key) {
        return nil // If it's a String, return nil
    }
    return try? decodeIfPresent(Double.self, forKey: key)
}

// Helper function to handle decoding for Int
func decodeIfPresentInt(forKey key: K) throws -> Int? {
    if let _ = try? decodeIfPresent(String.self, forKey: key) {
        return nil // If it's a String, return nil
    }
    return try? decodeIfPresent(Int.self, forKey: key)
}
```

Also, after review the dataset, I assumed the dataset constantly uses `""` to mean `no data`, and there is no case where empty string can means anything in this circunscancies. Then, to maintain coherence in the model, and don't have two different `no data` types: `""` and `nil`, that would drive me to have to check if string value is empty or not even when it has value, I have prefered to create a function to handle the empty strings received values and convert them into `nil` values. This will contribute to have a cleaner and more consistent code.

```swift
// Helper function to handle decoding for String
func decodeIfPresentString(forKey key: K) throws -> String? {
    if let rawValue = try? decodeIfPresent(String.self, forKey: key) {
        return rawValue.isEmpty ? nil : rawValue
    }
    return nil
}
```

You can check these cases in [Exoplanet](Sources/Domain/Models/Exoplanet.swift)

## Goals process

### 1. The number of orphan planets.
To filter the dataset and get only the orphan one, I have based the next algorithm in the documentation information. I have noticed the TypeFlag(binaryflag) in value `3` means Orphan planet.

In this case, I have looped once across the dataset, and checked if the exoplanet has the TypeFlag property value equals to 3.

I have added the exoplanet into collection structure to be returned, just in case we want to do anything else more than only show up the collectioun items count.

In the execution, we have find out there are 2 exoplanets those are orphan:
- PSO J318.5-22
- CFBDSIR2149

```swift
private func isOrphan(exoplanet: Exoplanet) -> Bool {
    guard let flag = exoplanet.typeFlag, flag == Constants.orphanTypeFlag else { return false }
    return true
}
```

### 2. Find the planet orbiting the hottest star.

```swift
private func determineHottestStar(currentHottest: Exoplanet?, newExoplanet: Exoplanet) -> Exoplanet? {
    guard let newTemp = newExoplanet.hostStarTempK else { return currentHottest }
    guard let currentTemp = currentHottest?.hostStarTempK else { return newExoplanet }
    return newTemp > currentTemp ? newExoplanet : currentHottest
}
```

### 3. Generate a timeline of planet discoveries grouped by size categories.

```swift
private func createTimelineRecord(for exoplanet: Exoplanet) -> (year: Int, sizes: PlanetSizeCount)? {
    guard let year = exoplanet.discoveryYear, let radius = exoplanet.radiusJpt, radius >= 0 else { return nil }
    let category = SizeCategory(radius: radius)
    return (year: year, sizes: category.sizeCount)
}
```

```swift
enum SizeCategory {
    case small
    case medium
    case large

    static let smallThreshold = 1.0
    static let mediumThreshold = 2.0

    init(radius: Double) {
        switch radius {
        case 0..<Self.smallThreshold:
            self = .small
        case Self.smallThreshold..<Self.mediumThreshold:
            self = .medium
        default:
            self = .large
        }
    }

    var sizeCount: PlanetSizeCount {
        switch self {
        case .small:
            return PlanetSizeCount(small: 1, medium: 0, large: 0)
        case .medium:
            return PlanetSizeCount(small: 0, medium: 1, large: 0)
        case .large:
            return PlanetSizeCount(small: 0, medium: 0, large: 1)
        }
    }
}

```

# Methodology

## Initial Approach
Initially, the process involved iterating over the dataset separately for each goal:
1. Identify orphan planets (those with `typeFlag == 3`).
2. Find the planet orbiting the hottest star.
3. Generate a timeline of planet discoveries grouped by size categories (`small`, `medium`, `large`).

Each of these operations required a full loop over the dataset, resulting in three separate iterations. While this approach is functionally correct, it is suboptimal in terms of performance, as it performs redundant work.

## Optimized Approach
Upon reflection, I realized that all three goals could be achieved within a single loop through the dataset. By combining the logic for these operations:
- We identify orphan planets as we iterate.
- Track the hottest star's planet dynamically by comparing temperatures.
- Incrementally build the discovery timeline for each planet with valid discovery data.

This optimized approach significantly reduces the number of iterations over the dataset while maintaining the same `O(n)` asymptotic complexity. However, in real-world scenarios, reducing the number of loops improves runtime efficiency and can lead to measurable performance gains, especially with larger datasets.

```swift
public func processExoplanets() async throws -> ProcessedExoplanetResult {
    let exoplanets = try await repository.fetchExoplanets()

    var orphanPlanets = [Exoplanet]()
    var timeline = YearlyPlanetSizeDistribution()
    var hottestStarExoplanet: Exoplanet?

    for exoplanet in exoplanets {
        if let record = createTimelineRecord(for: exoplanet) {
            let currentCount = timeline[record.year] ?? .zero
            timeline[record.year] = currentCount.adding(record.sizes)
        }

        if isOrphan(exoplanet: exoplanet) {
            orphanPlanets.append(exoplanet)
        }

        hottestStarExoplanet = determineHottestStar(currentHottest: hottestStarExoplanet, newExoplanet: exoplanet)
    }

    return ProcessedExoplanetResult(
        orphanPlanets: orphanPlanets,
        timeline: timeline,
        hottestStarExoplanet: hottestStarExoplanet
    )
}
```

## Implementation Benefits
1. **Reduced Redundancy:**
   - Combining the operations eliminates the need for multiple loops, saving computational resources.
   
2. **Improved Performance:**
   - Although the asymptotic complexity remains the same, fewer iterations translate to faster execution in practical terms.

3. **Clean and Maintainable Code:**
   - Consolidating the logic into a single loop makes the code easier to read, maintain, and debug.

## Conclusion
This refined methodology achieves all three objectives efficiently within a single iteration of the dataset. It highlights the importance of balancing theoretical computational complexity with real-world performance considerations. By optimizing the approach, we ensure the system remains performant and scalable for larger datasets.

# Technical details

## AWS Secrets Manager

To avoid expose the API url directly to the code, as well as the Docker credentials, I have chose for the option to create an externalised service that vault and provide these details.
Then I just have to store the IAM credentials in my GitHub Repository Secrets, and use them by GitHub Actions to login into AWS Secrets Manager, and retrieve the two Secrets that GitHub Actions require for the CI/CD Flow I have setup: 'exoplanets-analyzer-api-url-test' for testing, and 'docker-credentials' to login, scan image vulnerabilities and push to Docker Hub the new image.

For more security, I have created a custom IAM policy that only has read access only to both Secrets.
I have also create an IAM specific user only for github actions, that implements the custom policy to have only the indispensable resources access.
This is IAM user I have used to set up its Access Key ID and Secret Key.

I have configured the AWS Secrets Manager to be deployed in us-west-2 region since this is the closest one from Arizona, and latency will be reduced.

I have set up 3 secrets:
- exoplanets-analyzer-api-url-prod (To set up the URL's and required environment setup for production).
- exoplanets-analyzer-api-url-dev (To set up the URL's and required environment setup for development).
- exoplanets-analyzer-api-url-test (To set up the URL's and required environment setup for testing).
- docker-credentials (To be able to build and push the new Image to Docker Hub).

## CI/CD Flow
Code -> Git -> GitHub Pull Request -> GitHub Actions -> Docker Hub -> Kubernetes.

In GitHub the main branch is protected and restricted to add code only by Pull Requests.

### GitHub Actions

This [Pull Request Validation](.github/workflows/validate-pr.yml):
- **`validate-pr`:**  
  This job is triggered for every pull request. It performs the following tasks:
  - Checks for conflicts within the pull request.
  - Retrieves URLs and other secrets from AWS Secrets Manager.
  - Sets the retrieved secrets as environment variables.
  - Runs the tests to validate the pull request changes.

This [Build and Deploy](.github/workflows/build-and-deploy.yml):
- **`build-scan-and-push`:**  
  This job it is triggered when changes are merged into the main branch:
  - Retrieves Docker credentials from AWS Secrets Manager.
  - Builds a new Docker image using the main branch code.
  - Scans the Docker image with Docker Scout to identify vulnerabilities.
  - Pushes the image to Docker Hub only if no critical or high-severity vulnerabilities are found during the scan.

### Docker
This [Dockerfile](Dockerfile) file contains the instructions to build up a Docker Image based on my code.

In this case, I could use the command:
```dockerfile
RUN git clone <repository-url> /app
```
To make the image standalone. This means you could create a Docker image using just the `Dockerfile`, without requiring the codebase to be present. During the image build process, the source code would be fetched directly from code repository. However, this approach exposes the repository URL, which can raise security concerns.

Alternatively, I chose to use the command:
```dockerfile
COPY . .
```
This approach ensures that the exact version of the code tested during the CI/CD process is included in the image, without exposing any repository URL.

In the Dockerfile, I chose to use swift:6.0.3 as the base image to ensure that all the required dependencies for building my Swift Package Manager project are available.

After building the executable, Docker creates a second image using swift:6.0.3-slim as the base image, which contains only the minimal dependencies required to run the executable. This approach ensures that the final image is smaller, as it includes only the built executable and the essential runtime environment.

It created two docker images: terminal and api. These ones are the image build from the two exposed targets in the [SPM Package](Package.swift).

#### Docker Hub
The Terminal built images are stored in [Exoplanet Analyzer Terminal](https://hub.docker.com/repository/docker/rpairo/exoplanets-terminal) for easy access and deployment. This is an executable that targets the ExoplanetsTerminal, use a terminal view layer to present the exoplanet list process, with the expected results: *Orphan exoplanets*, *Hottest star exoplanet*, and *Discovery exoplanets timeline by sizes*.

The API built images are stored in [Exoplanet Analyer API](https://hub.docker.com/repository/docker/rpairo/exoplanets-api) for easy access. This is an executable that targets the exoplanetsAPI, exposes the API layer to provide public functions to retrieve the three expected results: *Orphan exoplanets*, *Hottest star exoplanet*, and *Discovery exoplanets timeline by sizes*.

## API URL Abstraction

Configuration Factory definition: [File](Sources/Infrastructure/Environment/ConfigurationFactory.swift)

```swift
public struct ConfigurationFactory {
    static func create() throws -> AppConfiguration {
        let baseURLKey = "BASE_URL"
        let pathSegmentKey = "PATH_SEGMENT"
        let endpointKey = "ENDPOINT_EXOPLANETS"
        let apiRequestMaxAttempts = 5
        let delayBetweenAttempts = 2.0

        guard let base = ProcessInfo.processInfo.environment[baseURLKey] else {
            throw ConfigurationError.missingEnvironmentVariable(baseURLKey)
        }
        guard let path = ProcessInfo.processInfo.environment[pathSegmentKey] else {
            throw ConfigurationError.missingEnvironmentVariable(pathSegmentKey)
        }
        guard let endpoint = ProcessInfo.processInfo.environment[endpointKey] else {
            throw ConfigurationError.missingEnvironmentVariable(endpointKey)
        }

        return AppConfiguration(
            baseAPIURL: base,
            exoplanetsPathSegment: path,
            exoplanetsEndpoint: endpoint,
            apiRequestMaxAttempts: apiRequestMaxAttempts,
            delayBetweenAttempts: delayBetweenAttempts
        )
    }
}
```

## Dependency Injection

To implement proper scalable, maintainable and disacopled architecture, I have worked with dependency inversion approach. This is really powerful when it has a dependency injector to abstract the instances creation.

Dependency Injector definition: [File](Sources/Composition/DependencyInjection/DIContainer.swift)

```swift
public final class DIContainer {
    public static let shared = DIContainer()
    private var services: [String: Any] = [:]
    private init() {}

    public func register<Service>(_ service: Service, for protocolType: Service.Type) throws {
        let key = String(describing: protocolType)
        if services[key] != nil {
            throw DIContainerError.dependencyAlreadyRegistered(dependency: key)
        }
        services[key] = service
    }

    public func resolve<Service>() throws -> Service {
        let key = String(describing: Service.self)
        guard let service = services[key] as? Service else {
            throw DIContainerError.dependencyNotFound(dependency: key)
        }
        return service
    }

    public func reset() {
        services.removeAll()
    }
}
```

The work flow is simple: first you register the implementation for determinate type:
```swift
try container.register(URLSessionHTTPClient(), for: HTTPClient.self)
```

To later resolve the dependency:
```swift
try container.register(RemoteExoplanetDataSource(client: container.resolve(), url: url), for: ExoplanetDataSource.self)
```

The pair implementation and type are stored into key value dictionary at registration time. And by generic type inference, the resolving will get the implementation (value) from the linked type (key), and return it.

Dependency Injection example of usage: [File](Sources/Composition/Application/AppComposition.swift)


## Network Retry Handler

Network Retry Handler definition: [File](Sources/Infrastructure/Network/NetworkRetryHandler.swift)
```swift
public struct NetworkRetryHandler: RetryableOperation {
    private let configuration: RetryConfiguration

    public init(configuration: RetryConfiguration) {
        self.configuration = configuration
    }

    public func execute<T>(_ operation: @escaping () async throws -> T) async throws -> T {
        var lastError: Error?
        for attempt in 1...configuration.maxAttempts {
            do {
                return try await operation()
            } catch {
                lastError = error
                if attempt < configuration.maxAttempts {
                    await configuration.delay()
                }
            }
        }
        throw lastError ?? NetworkError.unableToComplete
    }
}
```

## Clean architecture

Package definition: [File](Package.swift)

This file has the project structure and targets definitions. I have set up two executables: 
- **ExoplanetsTerminal**: Implements Terminal view, that will show up by terminal the exoplanets API fetch, process and formated result.

- **exoplanetsAPI**: Implements an API layer that will provide to Swift Package Manager consumers the capability to request the exoplanet consumtion results.

To develop this project I have followed the clean architecture conventions. In this case, the inned layers are agnostic to the above layers. You can notice the dependencies by the *dependencies: ["layer"]* parameter in the project configuration.

- Domain: Does not has any dependency. It contains the core business logic. It is independent of any other layer.
- Data: Has Domain dependency. It contains the data consumtion required for the aplication.
- Infrastructure: Has Data dependency. It contains the connections and envinronmental configurations.
- Presentation: Has Domain dependency. It contains the logic to prepare the results obtainted from domain, and display them.
- Composition: Has Domain, Data, Presentation and Infrastructure dependencies. It takes care of the project building. It contains the dependency injector and the project build flow.
- ExoplanetsTerminal: Has Composition and Presentaion dependencies. It provides a gateway to present the data by terminal.
- exoplanetsAPI: Has Composition, Presentation and Domain dependencies. It provides an interface to propagate the expolanets information to library consumers.

```swift
// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "ExoplanetAnalyzer",
    platforms: [
        .macOS(.v12)
    ],
    products: [
        .executable(
            name: "ExoplanetsTerminal",
            targets: ["ExoplanetsTerminal"]
        ),
        .executable(
            name: "exoplanetsAPI",
            targets: ["exoplanetsAPI"]
        )
    ],
    targets: [
        .target(
            name: "Domain",
            dependencies: [],
            path: "Sources/Domain"
        ),
        .target(
            name: "Data",
            dependencies: ["Domain"],
            path: "Sources/Data"
        ),
        .target(
            name: "Infrastructure",
            dependencies: ["Data"],
            path: "Sources/Infrastructure"
        ),
        .target(
            name: "Presentation",
            dependencies: ["Domain"],
            path: "Sources/Presentation"
        ),
        .target(
            name: "Composition",
            dependencies: ["Data", "Domain", "Presentation", "Infrastructure"],
            path: "Sources/Composition"
        ),
        .executableTarget(
            name: "ExoplanetsTerminal",
            dependencies: ["Composition", "Presentation"],
            path: "Sources/Main"
        ),
        .executableTarget(
            name: "exoplanetsAPI",
            dependencies: ["Composition", "Presentation", "Domain"],
            path: "Sources/API"
        ),
        .testTarget(
            name: "Tests",
            dependencies: ["Data", "Domain", "Presentation", "Composition", "Infrastructure"],
            path: "Tests"
        )
    ]
)
```

## Composition Layer

AppComposition definition: [File](Sources/Composition/Application/AppComposition.swift)

```swift
public struct AppComposition: ApplicationBuilder {
    private let container = DIContainer.shared
    public init() {}

    public func build() async throws {
        container.reset()

        try registerConfiguration()
        try registerNetworking()
        try registerDataLayer()
        try registerDomainLayer()
        try await registerPresentationLayer()
    }

    private func registerConfiguration() throws {
        try container.register(ConfigurationProvider(), for: AppConfigurationProvider.self)
    }

    private func registerNetworking() throws {
        try container.register(URLSessionHTTPClient(), for: HTTPClient.self)
    }

    private func registerDataLayer() throws {
        let configProvider: AppConfigurationProvider = try container.resolve()
        let config = try configProvider.provideConfiguration()
        guard let url = URL(string: config.apiURL) else {
            throw AppCompositionError.invalidConfigurationURL(config.apiURL)
        }
        try container.register(RemoteExoplanetDataSource(client: container.resolve(), url: url), for: ExoplanetDataSource.self)

        try container.register(
            RetryConfigurationProvider(
                maxAttempts: config.apiRequestMaxAttempts,
                delayBetweenAttempts: config.delayBetweenAttempts),
            for: RetryConfiguration.self
        )

        try container.register(NetworkRetryHandler(configuration: container.resolve()), for: RetryableOperation.self)
        try container.register(
            RemoteExoplanetRepository(
                dataSource: container.resolve(),
                retryHandler: container.resolve()),
            for: ExoplanetRepository.self
        )
    }

    private func registerDomainLayer() throws {
        try container.register(ExoplanetUseCase(repository: container.resolve()), for: ExoplanetProcessing.self)
    }

    private func registerPresentationLayer() async throws {
        try container.register(TimelineFormatter(), for: TimelineFormatting.self)
        try container.register(TerminalMessagePrinter(), for: MessagePrinter.self)
        try await container.register(ExoplanetPresenter(useCases: container.resolve()), for: ExoplanetPresenting.self)
        try container.register(
            TerminalExoplanetView(
                presenter: container.resolve(),
                printer: container.resolve(),
                timelineFormatter: container.resolve()),
            for: ExoplanetDisplaying.self
        )
    }
}
```

## Local Execution by Xcode (Development)
To run the project by Xcode it will requires to manually set up the Environment Variables by the Scheme target.

This is required cause Xcode does not share the OS environment variables.

Product -> Scheme -> Edit Scheme -> <target>

![Xcode environment variables setup](https://github.com/user-attachments/assets/50cc3f57-89c6-4d29-9a41-16f2d3652d30)

## Kubernetes (Local)
I have been using Kubernetes by Docker Desktop, and this has limited me the capacity to implement the AWS Secrets Manager. For that reason, if you are going to try to run by local Docker Desktop, I have prepared few scripts to set up the local secrets that stores the url's environment variables:

- [deploy-k8s.sh](k8s/scripts/deploy-k8s.sh): This file will trigger the deployment flow. First will call *create-secrets-docker-desktop.sh*, then will call *exoplanets-terminal.yaml* to set up the instructions to run the image in kubernetes.

- [create-secrets-docker-desktop.sh](k8s/scripts/create-secrets-docker-desktop.sh): This file will check if kubernetes is running by *Docker Desktop*. In case it does, it will create a local secret decoding the base64 urls. This is necessary cause it is not possible to connect AWS Secrets Manager to local Docker Desktop.

- [exoplanets-terminal.yaml](k8s/base/exoplanets-terminal.yaml): This file contains all the required instructions to pull the image from docker hub, set up and run in kubernetes.

Notice I have chose to create a **Job** instead of **Deployment** since this project is made to run once. Does not requires to be restarted every time it finish and stops.

