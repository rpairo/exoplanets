# Exoplanets Analyzer
This is the library **Exoplanets Analyzer**, designed to consume the provided exoplanets dataset, analyze, process, and serve it. You can find the public repository for this project at https://github.com/rpairo/exoplanets.

**Library Executable:** You can import this project into another Swift-compatible project using Swift Package Management (SPM) with the following coordinates: 

```swift
.package(url: "https://github.com/rpairo/exoplanets.git", from: "1.0.12")
```

Once imported, set up the dependency exposure in your project with:

```swift
.product(name: "ExoplanetsAPI", package: "exoplanets").
```

After this, the library will be ready to use.

**Terminal Executable:** You can also execute the project as a standalone tool. Simply clone the repository and run it using the ExoplanetTerminal target to see results directly in your terminal.

Alternatively, you can use Docker for execution. The Docker image is available on Docker Hub at https://hub.docker.com/repository/docker/rpairo/exoplanets-terminal.

Pull the Docker image into your local environment using the command:

```bash
docker pull rpairo/exoplanets-terminal.
```

Additionally, scripts are provided to simplify the setup of [Docker](docker/setup-docker-resources.sh) or [Kubernetes](k8s/scripts/deploy-k8s-resources.sh). Please note that this project requires some environmental variables to run correctly.

### Docker Setup
There are several scripts available to manage the Docker setup:

[**Using AWS CLI**](docker/setup-docker-aws-secrets.sh): If you have the AWS CLI installed, you can use the script setup-docker-aws-secrets.sh. This script fetches the necessary secrets from AWS and sets up the environment variables for you.

[**Manual Setup**](docker/setup-docker-manual.sh): If you prefer manual setup, use the script setup-docker-manual.sh to configure Docker by directly setting the environment variables.

**Note:** The environment variables have been encoded in Base64 to avoid exposing them directly. However, this is only a basic encoding, not encryption. It’s straightforward to decode them back to plain text. This approach was used since the scripts are publicly accessible, and there’s no alternative way to share standalone scripts securely.

![Docker](https://github.com/user-attachments/assets/5d35feb4-ff57-4a65-8a83-1816a1e49f4c)

### Kubernetes Setup
Several scripts are available for Kubernetes setup, tailored to your installed tools:

Orchestrator Script: Use [deploy-k8s-resources.sh](k8s/scripts/deploy-k8s-resources.sh) as the primary orchestrator script for deploying Kubernetes resources.

Manual Secrets Setup: If you prefer a simpler approach, execute [create-k8s-secrets-manual.sh](k8s/scripts/create-k8s-secrets-manual.sh) to manually set up Kubernetes secrets.

I am running Kubernetes using the Docker Desktop feature. This configuration prevents the use of AWS Secrets Manager with Kubernetes scripts. To address this limitation, I created these custom scripts. In a real production environment, where Kubernetes is deployed in actual clusters, we would manage environment variables directly through deployment scripts.

Additionally, I chose to create a Job instead of a Deployment for this project. Since the project is designed to run once and does not require restarts upon completion, a Job is more appropriate.

![Kubernetes](https://github.com/user-attachments/assets/03488df9-2b35-4532-a388-4664166da674)

### Xcode
To run the project in Xcode, you will need to manually configure the environment variables for the Scheme target. This step is necessary because Xcode does not inherit the OS-level environment variables.

![Xcode](https://github.com/user-attachments/assets/9bd58723-7b14-4750-bb59-b9f372e4f67d)

#### How to Set Up Environment Variables in Xcode:
1. Go to **Product -> Scheme -> Edit Scheme -> \<target>**
2. Manually configure the required environment variables.

![Xcode environment variables setup](https://github.com/user-attachments/assets/50cc3f57-89c6-4d29-9a41-16f2d3652d30)

### API Rest
This library you are currently reading about is not the whole story! I have also created a REST API that uses this library as an external dependency to provide even more functionality and fun!

You can find the REST API repository at https://github.com/rpairo/exoplanets-api.

This API offers more than just basic information through a website and JSON responses — the choice is yours! Comprehensive documentation is available in the README file of the API repository.

### Dataset
Based on the documentation found [here](https://www.kaggle.com/datasets/mrisdal/open-exoplanet-catalogue), there are two versions of the dataset.

The provided JSON for this assessment, available at this [URL](https://gist.githubusercontent.com/joelbirchler/66cf8045fcbb6515557347c05d789b4a/raw/9a196385b44d4288431eef74896c0512bad3defe/exoplanets), is based on version 1.0 of the dataset.

#### Key Details:
- Version 1.0 contains 3,426 exoplanets.
- Version 2.0 contains 3,584 exoplanets.

After analyzing the provided JSON, I can confirm that it matches version 1.0 of the dataset due to the following reasons:
1.	The record names in the provided JSON match those in version 1.0.
2.	The dataset contains the same number of orphan planets (TypeFlag: 3) as in version 1.0, which has only two orphan planets, whereas version 2.0 has three orphan planets.

In the Kaggle documentation for version 2.0, within the “Details” section, there is a reference to the [Open Exoplanet Catalogue (OEC) tables repository](https://github.com/OpenExoplanetCatalogue/oec_tables).

Within this repository, the file [FIELDS.md](https://github.com/OpenExoplanetCatalogue/oec_tables/blob/master/FIELDS.md) provides a detailed description of the dataset fields. This file contains the complete field description list for reference.

### Fields Description
```yaml
1.	name: Primary identifier of the planet
2.	binaryflag: Binary flag
    0 = No known stellar binary companion
	1 = P-type binary (circumbinary)
	2 = S-type binary
	3 = Orphan planet (no star)
3.	mass: Planetary mass [Jupiter masses]
4.	radius: Radius [Jupiter radii]
5.	period: Orbital period [days]
6.	semimajoraxis: Semi-major axis [Astronomical Units]
7.	eccentricity: Orbital eccentricity
8.	periastron: Periastron [degree]
9.	longitude: Longitude [degree]
10.	ascendingnode: Ascending node [degree]
11.	inclination: Inclination [degree]
12.	temperature: Surface or equilibrium temperature [K]
13.	age: Age [Gyr]
14.	discoverymethod: Discovery method
15.	discoveryyear: Discovery year [yyyy]
16.	lastupdate: Last updated [yy/mm/dd]
17.	system_rightascension: Right ascension [hh mm ss]
18.	system_declination: Declination [+/-dd mm ss]
19.	system_distance: Distance from Sun [parsec]
20.	hoststar_mass: Host star mass [Solar masses]
21.	hoststar_radius: Host star radius [Solar radii]
22.	hoststar_metallicity: Host star metallicity [log relative to solar]
23.	hoststar_temperature: Host star temperature [K]
24.	hoststar_age: Host star age [Gyr]
25.	list: Lists the planet is on
```

#### JSON Structure
The provided JSON structure, as received in the assessment, maps to these fields as follows:
```json
{
    "PlanetIdentifier": "HD 45184 b",                   // Maps to `name`
    "TypeFlag": 0,                                      // Maps to `binaryflag`
    "PlanetaryMassJpt": 0.04,                           // Maps to `mass`
    "RadiusJpt": "",                                    // Maps to `radius`
    "PeriodDays": 5.8872,                               // Maps to `period`
    "SemiMajorAxisAU": 0.0638,                          // Maps to `semimajoraxis`
    "Eccentricity": 0.3,                                // Maps to `eccentricity`
    "PeriastronDeg": "",                                // Maps to `periastron`
    "LongitudeDeg": "",                                 // Maps to `longitude`
    "AscendingNodeDeg": "",                             // Maps to `ascendingnode`
    "InclinationDeg": "",                               // Maps to `inclination`
    "SurfaceTempK": 1045.8,                             // Maps to `temperature`
    "AgeGyr": "",                                       // Maps to `age`
    "DiscoveryMethod": "RV",                            // Maps to `discoverymethod`
    "DiscoveryYear": 2011,                              // Maps to `discoveryyear`
    "LastUpdated": "11/09/12",                          // Maps to `lastupdate`
    "RightAscension": "06 24 44",                       // Maps to `system_rightascension`
    "Declination": "-28 46 48",                         // Maps to `system_declination`
    "DistFromSunParsec": 21.9,                          // Maps to `system_distance`
    "HostStarMassSlrMass": "",                          // Maps to `hoststar_mass`
    "HostStarRadiusSlrRad": "",                         // Maps to `hoststar_radius`
    "HostStarMetallicity": "",                          // Maps to `hoststar_metallicity`
    "HostStarTempK": 5940,                              // Maps to `hoststar_temperature`
    "HostStarAgeGyr": ""                                // Maps to `hoststar_age`
}
```

The JSON fields follow a PascalCase format and have different names compared to the original dataset repository. For example, binaryflag from the original dataset is mapped to TypeFlag in the JSON. Even though no explicit documentation confirms this mapping, I am confident about it based on the following observations:

1. The available values for TypeFlag in the JSON are [0, 1, 2, 3], which perfectly align with the range and meaning of the binaryflag field in the dataset.

2. The syntactic similarity and the consistent value range strongly suggest they represent the same concept.

Given this, I have assumed this mapping to work on the assessment. Understanding these mappings is crucial as it allows me to interpret the JSON fields correctly and achieve the proposed goals.

Here is the assumed mapping table for reference:

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

The provided JSON data has a specific issue where some Int and Double fields may either hold valid numeric values or be represented as an empty string ("") when no value is provided. For example:

- `PlanetaryMassJpt` has the value `0.076` for `Gliese 3293 b`.
- However, for `Kepler-1037 b`, the same field is represented as an empty string `("")`.

#### Serialization Issue
This inconsistency can lead to serialization issues because the Decodable protocol in Swift requires a clear type definition for each property. There is no direct conversion from an empty string ("") to valid Int, Double, or nil values.

#### Solution: Custom Decoding
To handle this, I implemented a custom decoding logic by extending the [`KeyedDecodingContainer`](Sources/Domain/Models/Exoplanet.swift) struct. This approach ensures the decoding logic is centralized and maintains clean code organization.

#### Implementation Details
**1. Custom Decodable Constructor:**
    - The constructor attempts to decode the field as a String first.
	- If the value is an empty string (""), it returns nil.
	- If decoding as a String fails, it proceeds to decode the expected type (Int or Double).

**2. Optional Handling for Standardized nil Values:**
    - By using optional types (Int? or Double?), the implementation handles the absence of values gracefully, ensuring consistency in the decoded data.

```swift
extension KeyedDecodingContainer {
    func decodeIfPresentDouble(forKey key: K) throws -> Double? {
        if let _ = try? decodeIfPresent(String.self, forKey: key) {
            return nil // If it's a String, return nil
        }
        return try? decodeIfPresent(Double.self, forKey: key)
    }

    func decodeIfPresentInt(forKey key: K) throws -> Int? {
        if let _ = try? decodeIfPresent(String.self, forKey: key) {
            return nil // If it's a String, return nil
        }
        return try? decodeIfPresent(Int.self, forKey: key)
    }

    func decodeIfPresentString(forKey key: K) throws -> String? {
        if let rawValue = try? decodeIfPresent(String.self, forKey: key) {
            return rawValue.isEmpty ? nil : rawValue
        }
        return nil
    }
}
```

#### Advantages
1. **Centralized Decoding Logic**: The custom extension ensures a clean separation of concerns and improves code reusability.
2. **Handles Null Cases Gracefully**: By using optionals, null values are standardized, preventing runtime errors.
3. **Robustness**: The logic handles both numeric and empty string representations seamlessly.

This solution ensures that data inconsistencies in the JSON file do not disrupt the application’s functionality while maintaining a clean and organized codebase.

## Key Goals Approaches
### 1. Determining the Number of Orphan Planets
To determine the number of orphan planets in the dataset, I followed the algorithm described below, based on the information provided in the documentation:

#### Orphan Planet Definition
**- TypeFlag (binaryflag) with a value of 3** signifies an orphan planet.

#### Algorithm
1. Loop through the dataset once to identify planets where the TypeFlag property is equal to 3.
2. Add the identified exoplanets to a collection structure for further use (e.g., analysis, display, etc.).
3. Return the collection’s count for the final output.

#### Implementation
The following Swift function checks whether an exoplanet is orphaned based on the TypeFlag value:

```swift
private func isOrphan(exoplanet: Exoplanet) -> Bool {
    guard let flag = exoplanet.typeFlag, flag == Constants.orphanTypeFlag else { return false }
    return true
}
```

#### Execution Result
When executing the algorithm, the dataset reveals **2 orphan exoplanets**:
- **PSO J318.5-22**
- **CFBDSIR2149**

By including these orphan planets in a collection, we allow for additional operations beyond just counting, such as displaying detailed information or performing further analysis.

### 2. Finding the Planet Orbiting the Hottest Star
#### Approach
To identify the exoplanet orbiting the hottest star, I followed this strategy:
1.	Iterate through the exoplanets dataset.
2.	For each exoplanet, compare its host star’s temperature (`hostStarTempK`) with the currently stored hottest temperature.
3.	If the current exoplanet’s host star temperature is higher:
    - Replace the stored exoplanet with the current one.
4.	Continue until the end of the dataset. At that point, the stored exoplanet will be the one orbiting the hottest star.

#### Implementation
The following Swift function compares the current hottest exoplanet with a new one and updates accordingly:

```swift
private func determineHottestStar(currentHottest: Exoplanet?, newExoplanet: Exoplanet) -> Exoplanet? {
    guard let newTemp = newExoplanet.hostStarTempK else { return currentHottest }
    guard let currentTemp = currentHottest?.hostStarTempK else { return newExoplanet }
    return newTemp > currentTemp ? newExoplanet : currentHottest
}
```

#### Execution Result
Using this approach, the exoplanet orbiting the hottest star is identified as follows:
- **Exoplanet**: V391 Peg b
- **Host Star Temperature**: 29300 K

### 3. Generating a Timeline of Planet Discoveries Grouped by Size Categories
#### Approach
To create a timeline of planet discoveries grouped by size categories (small, medium, large), the following approach is used:

1.	**Filter Data**: Only include exoplanets with valid `RadiusJpt` (Jupiter radius magnitude) and `DiscoveryYear`.
2.	**Categorize by Size**: Classify exoplanets based on their radius into the following categories:
    - **Small**: Radius < 0.5 Jupiter radii.
    - **Medium**: 0.5 ≤ Radius ≤ 2 Jupiter radii.
    - **Large**: Radius > 2 Jupiter radii.
3.	**Group by Year**: Use a dictionary where:
    - The **key** is the discovery year.
    - The **value** is a structure counting the number of exoplanets discovered in that year for each size category.
4.	**Iterate Through the Dataset**: For each exoplanet:
    - Check if it has valid size and discovery year data.
    - Categorize its size.
    - Update the counts in the corresponding year entry in the dictionary.

#### Implementation
```swift
if let record = createTimelineRecord(for: exoplanet) {
    let currentCount = timeline[record.year] ?? .zero
    timeline[record.year] = currentCount.adding(record.sizes)
}
```

```swift
private func createTimelineRecord(for exoplanet: Exoplanet) -> (year: Int, sizes: PlanetSizeCount)? {
    guard let year = exoplanet.discoveryYear, let radius = exoplanet.radiusJpt, radius >= 0 else { return nil }
    let category = SizeCategory(radius: radius)
    return (year: year, sizes: category.sizeCount)
}
```

#### Encapsulation of Exoplanet Categorization with SizeCategory
To encapsulate the responsibility of categorizing exoplanets by size, I use the [SizeCategory](Sources/Domain/Models/SizeCategory.swift) structure. This approach centralizes the logic for size categorization, making the code more modular, reusable, and easier to maintain.

#### SizeCategory Implementation
The SizeCategory structure defines categories and provides methods to classify exoplanets based on their radius `RadiusJpt`:

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

#### Example Output
The output of the timeline generation using SizeCategory is a dictionary where each year contains counts for each category, mapped to the SizeCategory enum:

```json
[
    2010: [.small: 12, .medium: 35, .large: 5],
    2011: [.small: 18, .medium: 40, .large: 7],
]
```

#### Benefits of Using SizeCategory
1. **Centralized Logic**: Categorization is handled in one place, making changes straightforward.
2. **Readability**: Code becomes easier to understand with the encapsulated logic.
3. **Reusability**: The SizeCategory structure can be used anywhere size-based classification is needed.
4. **Type Safety**: Using an enum ensures only valid categories are used.

#### Encapsulation of Yearly Discovery Timeline Tracking with PlanetSizeCount
To encapsulate the responsibility of tracking yearly discovery timelines grouped by planet size, I use the [PlanetSizeCount](Sources/Domain/Models/PlanetSizeCount.swift) structure. This approach centralizes the logic for maintaining and updating discovery counts, making the code cleaner and more maintainable.

#### PlanetSizeCount Implementation
The PlanetSizeCount structure maintains counts of exoplanets discovered in each size category for a given year. It provides methods to increment counts and retrieve the data.

```swift
public struct PlanetSizeCount: Equatable {
    public let small: Int
    public let medium: Int
    public let large: Int

    public static var zero: PlanetSizeCount {
        .init(small: 0, medium: 0, large: 0)
    }

    public func adding(_ other: PlanetSizeCount) -> PlanetSizeCount {
        .init(
            small: self.small + other.small,
            medium: self.medium + other.medium,
            large: self.large + other.large
        )
    }

    public static func == (lhs: PlanetSizeCount, rhs: PlanetSizeCount) -> Bool {
        lhs.small == rhs.small &&
        lhs.medium == rhs.medium &&
        lhs.large == rhs.large
    }
}
```

#### Usage in the Timeline Generation Logic
By using PlanetSizeCount, the logic for yearly tracking is greatly simplified. Each year is associated with a PlanetSizeCount object, and updates to counts are handled via its methods.

#### Benefits of Using PlanetSizeCount
1.	**Encapsulation**: All size count logic is contained within the PlanetSizeCount structure, reducing complexity in the timeline generation code.
2.	**Reusability**: The structure can be reused for other scenarios requiring size-based count tracking.
3.	**Extensibility**: Future enhancements, like adding new size categories or additional metrics, can be implemented directly within PlanetSizeCount.
4.	**Readability**: Code becomes more intuitive by abstracting size count operations into a dedicated structure.

#### Execution Result: Exoplanets Discovery Timeline by Size
The discovery timeline of exoplanets, categorized by size, is generated during execution. To improve readability, I have formatted the output using the [TimelineFormatter](Sources/Presentation/Formatter/TimelineFormatter.swift).

```yaml
Year   Small  Medium  Large
---------------------------
1781   1      0       0    
1846   1      0       0    
1930   1      0       0    
1999   0      1       0    
2001   1      0       0    
2002   0      1       0    
2004   2      5       0    
2005   1      3       0    
2006   1      6       0    
2007   4      16      0    
2008   1      21      1    
2009   4      6       0    
2010   15     39      0    
2011   32     48      1    
2012   52     21      0    
2013   58     30      2    
2014   830    30      0    
2015   104    30      0    
2016   1267   26      0
```   

## Methodology
### Initial Approach
The initial implementation involved separate iterations over the dataset for each goal:
1.	**Identify Orphan Planets**: Loop through the dataset to find planets with typeFlag == 3.
2.	**Find the Hottest Star’s Planet**: Iterate to find the exoplanet with the highest hostStarTempK.
3.	**Generate the Discovery Timeline**: Iterate again to categorize exoplanets by size and group them by discovery year.

While this approach is straightforward and functionally correct, it requires **three full passes** over the dataset. This results in redundant computations, which, though manageable for small datasets, can become inefficient for larger datasets.

### Optimized Approach
To improve performance, I optimized the methodology by combining all three operations into a **single iteration** through the dataset:
- **Orphan Planets**: Check if the planet’s typeFlag is 3 and add it to a collection of orphan planets.
- **Hottest Star’s Planet**: Dynamically track the exoplanet with the highest hostStarTempK during the iteration.
- **Discovery Timeline**: For each planet with valid discovery data (RadiusJpt and DiscoveryYear), categorize its size (small, medium, large) and update the timeline.

#### Key Benefits of the Optimized Approach
- **Single Loop**: All operations are performed during a single traversal of the dataset, reducing redundant work.
- **Improved Efficiency**: Although both approaches have an **O(n)** complexity, reducing the number of loops improves runtime efficiency, especially for larger datasets.
- **Clean Codebase**: Consolidating operations into a single loop simplifies the code, reducing potential for duplication and errors.

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

#### Results
Using the optimized approach:
1.	**Orphan Planets**: Identified in the same pass.
2.	**Hottest Star**: Dynamically tracked during the iteration.
3.	**Discovery Timeline**: Built incrementally within the same loop.

#### Implementation Benefits
1.	**Reduced Redundancy**:
    - By combining the operations into a single loop, the need for multiple iterations over the dataset is eliminated.
	- This saves computational resources and minimizes redundant data processing.
2.	**Improved Performance**:
	- Although the asymptotic complexity remains O(n), fewer iterations over the dataset result in measurable performance improvements in real-world scenarios.
	- Especially with larger datasets, this optimization significantly reduces runtime overhead.
3.	**Clean and Maintainable Code**:
	- Consolidating the logic into a single loop enhances readability and maintainability.
	- It reduces code duplication and centralizes dataset processing logic, making the code easier to debug and extend.

#### Conclusion
This refined methodology efficiently achieves all three objectives—identifying orphan planets, tracking the hottest star’s exoplanet, and generating the discovery timeline—within a single dataset iteration.

By balancing theoretical computational complexity with practical performance considerations, the approach ensures:
- Optimal use of resources.
- Scalability to handle larger datasets effectively.
- A cleaner and more maintainable codebase.

This optimization serves as an example of how thoughtful design can bridge the gap between academic theory and practical application.

## Technical Details
### AWS Secrets Manager
To enhance security and avoid exposing sensitive information such as the **API URL**, **Docker credentials**, and **Google API keys** in the codebase, I opted to use **AWS Secrets Manager** to externalize and securely store these details.

This setup integrates seamlessly with **GitHub Actions** for CI/CD workflows by retrieving the required secrets during the build and deployment processes.

#### Setup and Workflow
1.	**Storing IAM Credentials**:
    - The **IAM credentials** are stored in the **GitHub Repository Secrets**.
	- These credentials allow GitHub Actions to log in to AWS Secrets Manager and fetch the secrets needed for the CI/CD pipeline.
2.	**Secrets Used in the CI/CD Workflow**:
	- exoplanets-analyzer-api-url-test: Used for testing.
	- docker-credentials: Used to authenticate, scan vulnerabilities, and push the Docker image to Docker Hub.
3.	**Custom IAM Policy**:
	- For enhanced security, I created a custom IAM policy granting **read-only access** to the specific secrets.
	- An IAM user (github-actions-user) was created and assigned this policy to ensure minimal resource access.

#### IAM Policy Example:
```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "secretsmanager:GetSecretValue",
                "secretsmanager:DescribeSecret"
            ],
            "Resource": [
                "arn:aws:secretsmanager:us-west-2:<my-account-id>:secret:docker-credentials-ntKnBq",
                "arn:aws:secretsmanager:us-west-2:<my-account-id>:secret:exoplanets-analyzer-api-url-test-gq8zSR"
            ]
        }
    ]
}
```

#### GitHub Actions Integration
- The **Access Key ID** and **Secret Access Key** of github-actions-user are added to **GitHub Repository Secrets**.
- These credentials are injected into the CI/CD pipeline to securely interact with AWS Secrets Manager.

#### AWS Secrets Configuration
1.	**Region Selection**:
The AWS Secrets Manager is deployed in the `us-west-2` region (closest to Arizona) to minimize latency.
2.	**Secrets Created**:
 - exoplanets-analyzer-api-url-prod: For production environment URLs and configurations.
 - exoplanets-analyzer-api-url-dev: For development environment URLs and configurations.
 - exoplanets-analyzer-api-url-test: For testing environment URLs and configurations.
 - docker-credentials: For building and pushing Docker images to Docker Hub.

#### Visual Overview
#### IAM User
A dedicated **IAM user** (github-actions-user) is created with restricted access based on the custom policy.

![IAM Users](https://github.com/user-attachments/assets/28cb095e-1259-4c62-adad-e3b981bb3caf)

#### AWS Secrets
AWS Secrets Manager is configured to store the required secrets.

![AWS Secrets](https://github.com/user-attachments/assets/25c485a4-bea3-4e6f-a7ac-2fa5aa4a49d9)

#### Benefits of This Approach
1.	**Enhanced Security**:
Sensitive credentials are externalized and securely managed by AWS Secrets Manager.
2.	**Minimized Exposure**:
Only the github-actions-user with limited read-only access can retrieve secrets.
3.	**Efficient CI/CD Workflow**:
Secrets are seamlessly injected into the GitHub Actions pipeline, reducing manual intervention.
4.	**Scalability**:
This setup can easily be extended to manage additional secrets or integrate with new environments.

### GitHub Actions (CI/CD Flow)
The quality flow I implemented follows this pipeline:
**Code -> Git -> GitHub Pull Request -> GitHub Actions -> Docker Hub -> Kubernetes**
As a best practice, the main branch is configured to be **protected** and restricted to changes only via pull requests. However, since I have been working solo on this project, I temporarily disabled this requirement to streamline development.

#### Workflow Details
1. **[validate-pr.yml](.github/workflows/validate-pr.yml):**
    - **Trigger**: Automatically triggered for every pull request.
    - **Purpose**: Ensures code quality by running tests on the proposed changes.
2. **[build-and-deploy.yml](.github/workflows/build-and-deploy.yml):**
    - **Trigger**: Automatically triggered when changes are pushed to the main branch.
    - **Steps**:
        - Runs the **test-swift.yml** workflow to ensure no broken code is published.
	    - Retrieves **Docker credentials** from AWS Secrets Manager.
	    - Builds the Docker image.
	    - Performs a vulnerability scan using **Docker Scout**. The process halts if critical or high vulnerabilities are detected.
	    - Publishes the Docker image to **Docker Hub**.
3. **[test-swift.yml](.github/workflows/test-swift.yml):**
    - **Trigger**: Reusable job called by both validate-pr.yml and build-and-deploy.yml.
    - **Steps**:
	    - Retrieves required environment variables from AWS Secrets Manager for testing.
	    - Executes all Swift tests.
	    - Generates and stores testing artifacts.

#### Optimization: Job Cancellation Strategy
- The workflows are configured to use a **FIFO (First In, First Out) cancellation strategy**.
- If a new job is triggered while the previous one is still running, the earlier job is automatically canceled.
- **Use Case**:
    - This approach is efficient for individual workflows to save time and resources.
    - In collaborative teams with multiple PRs, this strategy may require adjustment to avoid prematurely canceling ongoing workflows.

#### CI/CD Workflow Steps
1. **Pull Request Validation:**
    - Ensures only tested and validated code can be merged into the main branch.
2. **Main Branch Build & Deploy:**
    - Automatically tests, builds, scans, and publishes changes to Docker Hub for deployment.
3. **Swift Testing:**
    - Centralized and reusable job to ensure code reliability.

#### Benefits of This Workflow
1.	**Automated Quality Assurance:**
    - Testing and validation are automatically performed for each pull request and main branch update.
2.	**Security Integration:**
    - Vulnerability scanning is integrated into the build process to ensure secure Docker images.
3.	**Resource Efficiency:**
	- FIFO job cancellation optimizes resources for solo development.
4.	**Scalability:**
	- The modular structure (e.g., reusable test-swift.yml) facilitates easy scaling and collaboration in team environments.

#### Test job performance
![GitHub Actions](https://github.com/user-attachments/assets/4d8fbb6d-a2ec-4ffd-ba70-d41a487dfc1d)

#### CI/CD Jobs Chain
![GitHub Actions Chain](https://github.com/user-attachments/assets/be8183b7-3cd6-40bd-b1be-fc1c44976538)

### Dockerfile
This [Dockerfile](Dockerfile) contains the instructions to build a Docker image for the Exoplanets Analyzer application based on Swift. It incorporates best practices to ensure security, reproducibility, and efficiency.

#### Key Design Decisions
1.	**Avoiding Security Risks with Repository URL:**
	- Using RUN git clone <repository-url> /app could make the image standalone, allowing it to fetch the source code directly from the repository during the build process.
	- Drawback: This exposes the repository URL, raising potential security concerns.
2.	**Ensuring Reproducibility:**
	- Using `COPY . .` ensures that the exact version of the code tested during CI/CD is included in the image, avoiding discrepancies between the development environment and the final image.
	- This approach does not expose sensitive repository details.

```dockerfile
# ---------- STAGE 1: BUILD ----------
FROM swift:6.0.3 AS build

WORKDIR /build

COPY . .

RUN swift build --configuration release

# ---------- STAGE 2: RUNTIME ----------
FROM swift:6.0.3-slim AS terminal

LABEL maintainer="Raul Pera raul_pairo@icloud.com"
LABEL description="ExoplanetsTerminal Swift application"

WORKDIR /app

RUN useradd --create-home --uid 1001 --shell /bin/bash swiftuser
USER swiftuser

COPY --from=build /build/.build/release/ExoplanetsTerminal /app/ExoplanetsTerminal

ENTRYPOINT ["./ExoplanetsTerminal"]
```

#### Explanation of the Dockerfile Stages
1.	**Stage 1: Build**
	- **Base Image:** swift:6.0.3 is used to provide all dependencies required for building the Swift Package Manager project.
	- **Working Directory:** The /build directory is used as the working directory during the build stage.
	- **Copy Code:** The `COPY . .` command copies the codebase into the container.
	- **Build Command:** swift build --configuration release compiles the project in release mode, creating the executable in the .build/release/ directory.
2.	**Stage 2: Runtime**
	- **Base Image:** swift:6.0.3-slim is used to reduce the final image size by including only the minimal runtime dependencies.
	- **User Security:**
	    - Creates a non-root user (swiftuser) to run the application securely.
	    - The USER swiftuser directive switches to this user for running the application.
	- **Copy Executable:** The built executable from the first stage is copied into /app/ExoplanetsTerminal.
	- **Entry Point:** The ENTRYPOINT directive ensures the container runs the application directly.

#### Benefits of the Multistage Build
1.	**Smaller Final Image:**
    - The build environment and its dependencies are excluded from the final runtime image, significantly reducing its size.
2.	**Security:**
    - By creating a non-root user (swiftuser) and running the application under this user, potential vulnerabilities are mitigated.
3.	**Reproducibility:**
    - Using `COPY . .` ensures the exact version of the code tested during CI/CD is included in the image.

### Docker Hub
The Docker images for the **Exoplanet Analyzer Terminal** are stored in the [Exoplanet Analyzer Terminal repository](https://hub.docker.com/repository/docker/rpairo/exoplanets-terminal) on Docker Hub. The images can be accessed and deployed using the following coordinates:

rpairo/exoplanets-terminal

#### Purpose
This executable targets the **ExoplanetsTerminal**, a terminal-based application that processes and displays key results from the exoplanet dataset, including:
1.	**Orphan Exoplanets:** Identifies and lists orphan planets.
2.	**Hottest Star’s Exoplanet:** Displays the exoplanet orbiting the hottest star.
3.	**Discovery Timeline by Sizes:** Generates a timeline of exoplanet discoveries.

![DockerHub](https://github.com/user-attachments/assets/03708b55-78c1-4f6e-9616-09d46696e910)

### API URL Abstraction
To adhere to best practices, sensitive information such as API URLs is abstracted from the code and injected via environment variables. This ensures that configuration details are managed securely and are not hardcoded.
The Infrastructure Layer handles the retrieval and validation of these environment variables using the [ConfigurationFactory](Sources/Infrastructure/Environment/ConfigurationFactory.swift).

#### ConfigurationFactory Implementation
The ConfigurationFactory is responsible for creating an AppConfiguration object by reading environment variables and validating their presence. If any required variable is missing, it throws a ConfigurationError.

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

#### Error Handling
An enumeration ConfigurationError defines error cases for missing environment variables. It conforms to the LocalizedError protocol to provide user-friendly error messages.

```swift
public enum ConfigurationError: Error, LocalizedError {
    case missingEnvironmentVariable(String)

    public var errorDescription: String? {
        switch self {
        case .missingEnvironmentVariable(let variable):
            return "Missing environment variable: \(variable)"
        }
    }
}
```

#### Environment Variables
The ConfigurationFactory reads the following environment variables:
- **BASE_URL**: The base URL for the API.
- **PATH_SEGMENT**: The path segment for the exoplanet API.
- **ENDPOINT_EXOPLANETS**: The specific endpoint for fetching exoplanet data.

#### Benefits of This Approach
1.	**Security:**
    - Sensitive information is not hardcoded into the application codebase.
	- Credentials and URLs can be managed securely via environment variables.
2.	**Flexibility:**
	- The configuration can be easily modified without requiring changes to the code.
	- Different environments (e.g., development, testing, production) can have unique configurations.
3.	**Error Handling:**
	- Missing or invalid environment variables are detected early with clear error messages.
4.	**Scalability:**
	- Additional configuration parameters can be seamlessly added to the AppConfiguration object.

### Dependency Injection
To enhance scalability, maintainability, and modularity, the project uses **Dependency Injection (DI)**. This design pattern follows the **Inversion of Control (IoC) principle**, where dependencies are provided rather than created within components. A dedicated [Dependency Injector](Sources/Composition/DependencyInjection/DIContainer.swift) (DIContainer) manages the responsibility for instance creation and lifecycle management.

This approach improves **readability**, **code clarity**, and **testability** by decoupling components from their dependencies.

#### DIContainer Implementation
The DIContainer is a singleton-based dependency injector that registers and resolves services at runtime. It stores registered implementations in a key-value dictionary and uses generic type inference to resolve dependencies.

```swift
public class DIContainer: DependencyInjection {
    public static var shared: DependencyInjection = DIContainer()
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

enum DIContainerError: Error {
    case dependencyAlreadyRegistered(dependency: String)
    case dependencyNotFound(dependency: String)
}
```

#### Workflow
1.  **Registering a Service Implementation:**
The register method associates a specific implementation with a protocol or type.

```swift
try container.register(URLSessionHTTPClient(), for: HTTPClient.self)
```

2.	**Resolving a Dependency:**
The resolve method retrieves the registered implementation for a given protocol or type.

```swift
try container.register(RemoteExoplanetDataSource(client: container.resolve(), url: url), for: ExoplanetDataSource.self)
```

#### How It Works
1.	Registration:
    - The service implementation is stored in the services dictionary.
	- The **key** is the string representation of the type (String(describing: protocolType)).
	- The **value** is the actual implementation instance.
2.	Resolution:
	- The service is fetched from the services dictionary using the type’s string representation as the key.
	- Generic type inference ensures the correct service type is returned.
3.	Reset:
	- The reset method clears all registered services, which is particularly useful for testing or application shutdown.

#### Example Use Case
1. **Registering Dependencies:**
```swift
let container = DIContainer.shared
try container.register(URLSessionHTTPClient(), for: HTTPClient.self)
try container.register(RemoteExoplanetDataSource(client: container.resolve(), url: url), for: ExoplanetDataSource.self)
```

2. **Resolving Dependencies:**
```swift
let dataSource: ExoplanetDataSource = try container.resolve()
```

3. **Resetting Dependencies:**
```swift
container.reset()
```

#### Benefits
1.	**Scalability:**
    - New dependencies can be added without modifying existing components.
2.	**Maintainability:**
	- Components are loosely coupled, making the system easier to refactor or extend.
3.	**Testability:**
	- Mocks or stubs can be registered in the DIContainer for testing purposes, isolating components from real implementations.
4.	**Centralized Management:**
	- All dependencies are managed in a single place, improving the structure and clarity of the codebase.
5.	**Runtime Flexibility:**
	- The service implementations can be swapped dynamically at runtime, enabling different configurations for development, testing, or production.

### Network Retry Handler
To enhance user experience and ensure reliability, I implemented a **Network Retry Handler**. This system retries a network operation multiple times if it encounters errors, reducing the impact of transient issues such as network instability.

#### Implementation
The NetworkRetryHandler conforms to a RetryableOperation protocol and uses a configuration object (RetryConfiguration) to define retry behavior. It retries the given asynchronous operation up to the configured number of attempts, with a delay between attempts.

```swift
public struct NetworkRetryHandler: RetryableOperation {    
    public var configuration: RetryConfiguration

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

#### Benefits
1. **Improved Reliability:**
    - Automatically retries transient network failures, reducing disruptions to the user experience.
2. **Customizable Behavior:**
	- Allows configuration of the number of retry attempts and the delay between attempts.
3. **Error Handling:**
	- Captures and rethrows the last error if all retries fail, providing detailed context for debugging.
4. **Asynchronous Support:**
	- Designed to work seamlessly with Swift’s async/await model.

### Clean Architecture
The **Exoplanet Analyzer** project adheres to **Clean Architecture** principles to maintain scalability, maintainability, and separation of concerns. It is structured into layers, each with defined responsibilities and dependencies. The project is configured using [Package.swift](Package.swift) with two main targets:

1. ExoplanetsTerminal:
    - A terminal-based executable that fetches, processes, and formats results from the exoplanets API for display in the terminal.
2. ExoplanetsAPI:
    - A library providing an API layer for Swift Package Manager consumers, enabling them to fetch and process exoplanet data.

#### Project Structure
The project is organized into the following layers, following clean architecture conventions:
	
1.	**Domain**
	- **Dependencies**: None
	- **Purpose**: Core business logic, completely agnostic of the rest of the project.
	- **Location**: Sources/Domain
2.	**Data**
	- **Dependencies**: Domain
	- **Purpose**: Handles data consumption logic and data sources.
	- **Location**: Sources/Data
3.	**Infrastructure**
	- **Dependencies**: Data
	- **Purpose**: Configures and manages external connections (e.g., network, databases).
	- **Location**: Sources/Infrastructure
4.	**Presentation**
	- **Dependencies**: Domain
	- **Purpose**: Prepares and presents results obtained from the Domain layer.
	- **Location**: Sources/Presentation
5.	**Composition**
	- **Dependencies**: Domain, Data, Presentation, Infrastructure
	- **Purpose**: Manages project composition, including dependency injection and build flow.
	- **Location**: Sources/Composition
6.	**ExoplanetsTerminal**
	- **Dependencies**: Composition, Presentation
	- **Purpose**: Provides a terminal interface to display processed data.
	- **Location**: Sources/Main
7.	**ExoplanetsAPI**
	- **Dependencies**: Composition, Presentation, Domain
	- **Purpose**: Exposes a library interface for consuming the exoplanet data, abstracting internal logic through DTOs.
	- **Location**: Sources/API
8.	**Tests**
	- **Dependencies**: All layers (Data, Domain, Presentation, Composition, Infrastructure, ExoplanetsAPI)
	- **Purpose**: Contains unit and integration tests for all layers.
	- **Location**: Tests

#### Key Principles
1.	**Layered Structure**:
	- Each layer has a specific purpose and limited dependencies, promoting modularity and clear separation of concerns.
2.	**Dependency Inversion**:
	- Inner layers (e.g., Domain) define protocols or interfaces.
	- Outer layers (e.g., Infrastructure) implement these protocols.
	- This ensures inner layers are independent of implementation details.
3.	**Limited Access**:
	- Dependencies between layers are controlled via the dependencies parameter in Package.swift.

#### Communication Between Layers
- Communication between layers occurs via **Dependency Inversion**:
    - Inner layers expose protocols or abstract interfaces.
    - Outer layers implement these interfaces and provide them to the inner layers via Dependency Injection.

#### Benefits of Clean Architecture
1.	**Scalability**:
    - Layers can evolve independently, enabling easy addition of new features or services.
2.	**Testability**:
	- Decoupling logic into layers allows for isolated unit testing.
3.	**Maintainability**:
	- Clear separation of concerns makes the codebase easier to understand and refactor.
4.	**Flexibility**:
	- Layers can be replaced or reused with minimal impact on other parts of the system.

### Composition Layer
The **Composition Layer** is responsible for building and initializing the project. It ensures that all required dependencies are registered and properly configured, following the principles of **Dependency Injection** and **Inversion of Control**.

This layer orchestrates the setup of the entire application, ensuring that components are modular, reusable, and testable.

#### AppComposition Implementation
The AppComposition struct implements the ApplicationBuilder protocol. It uses the **Dependency Injection Container** (DIContainer) to register services and their dependencies.

```swift
public struct AppComposition: ApplicationBuilder {
    private let container: DependencyInjection

    public init(with dependencyInjector: DependencyInjection = DIContainer.shared) {
        self.container = dependencyInjector
    }

    public func build() async throws {
        do {
            container.reset()

            try registerConfiguration()
            try registerNetworking()
            try registerDataLayer()
            try registerDomainLayer()
            try await registerPresentationLayer()
        } catch {
            print("Error during build: \(error.localizedDescription)")
            throw error
        }
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

enum AppCompositionError: Error {
    case invalidConfigurationURL(String)
}
```

#### Benefits of the Composition Layer
1. **Centralized Configuration**:
    - All dependency registrations and initializations are managed in one place, simplifying the build process.
2. **Modular and Reusable**:
	- Each component is loosely coupled, making it easy to test, extend, or replace.
3. **Improved Readability**:
	- Clear separation of responsibilities for each layer.
4. **Error Safety**:
	- Validates configurations and dependencies during the build process to prevent runtime failures.
5. **Testability**:
	- Dependencies can be mocked or swapped easily during testing.

### API Exposition
The ExoplanetsAPI target provides a public interface (ExoplanetAnalyzerAPIProtocol) that exposes functionality for library clients. This allows consumers to request data related to:
1. **Orphan Exoplanets**
2. **The Hottest Star’s Exoplanet**
3. **Exoplanet Discovery Timeline**

The API ensures a clean separation of internal logic and provides consumer-friendly DTOs (Data Transfer Objects) for interaction.

#### ExoplanetAnalyzerAPIProtocol
The protocol defines the contract for the API, listing the available methods:
```swift
public protocol ExoplanetAnalyzerAPIProtocol {
    func getOrphanPlanets() -> [ExoplanetDTO]?
    func getHottestStarExoplanet() -> ExoplanetDTO?
    func getDiscoveryTimeline() -> YearlyPlanetSizeDistributionDTO?
}
```

#### ExoplanetAnalyzerAPI Implementation
The ExoplanetAnalyzerAPI struct conforms to ExoplanetAnalyzerAPIProtocol. It acts as a wrapper around the ExoplanetPresenting layer, ensuring that only properly formatted data (DTOs) is exposed to clients.
```swift
public struct ExoplanetAnalyzerAPI: ExoplanetAnalyzerAPIProtocol {
    private let presenter: ExoplanetPresenting

    public init(presenter: ExoplanetPresenting) {
        self.presenter = presenter
    }

    public func getOrphanPlanets() -> [ExoplanetDTO]? {
        guard let planets = presenter.orphanPlanets() else { return nil }
        return planets.map { ExoplanetMapper.toDTO(from: $0) }
    }

    public func getHottestStarExoplanet() -> ExoplanetDTO? {
        guard let exoplanet = presenter.hottestStarExoplanet() else { return nil }
        return ExoplanetMapper.toDTO(from: exoplanet)
    }

    public func getDiscoveryTimeline() -> YearlyPlanetSizeDistributionDTO? {
        guard let timeline = presenter.timeline() else { return nil }
        return timeline.reduce(into: [:]) { result, planetSizeCount in
            result[planetSizeCount.key] = PlanetSizeCountDTO.from(domain: planetSizeCount.value)
        }
    }
}
```

#### Default Factory Method
The API includes a convenient static factory method, makeDefault, which initializes the API with the default application composition.
```swift
public extension ExoplanetAnalyzerAPI {
    static func makeDefault() async throws -> ExoplanetAnalyzerAPI {
        let appComposition: ApplicationBuilder = AppComposition()
        try await appComposition.build()
        let presenter: ExoplanetPresenting = try DIContainer.shared.resolve()
        return ExoplanetAnalyzerAPI(presenter: presenter)
    }
}
```

#### Key Components
1. **ExoplanetPresenting**:
    - The API delegates its logic to the ExoplanetPresenting interface, which is part of the Presentation layer.
2. **DTO Mapping**:
    - The ExoplanetMapper converts domain objects to ExoplanetDTO, ensuring that internal logic remains hidden.
3. **Dependency Injection**:
    - The makeDefault method uses the AppComposition and DIContainer to ensure the correct dependencies are injected.

#### Benefits
1. **Separation of Concerns**:
	- Internal logic is encapsulated within the Presentation layer and accessed via the API.
2. **Consumer-Friendly**:
	- Exposes simple DTOs to library clients, abstracting away complexity.
3. **Modularity**:
	- The API is independent of implementation details, making it flexible and extensible.
4. **Ease of Use**:
	- The static makeDefault method simplifies initialization for clients.
5. **Testability**:
	- The API’s reliance on protocols allows for easy mocking in tests.

### Kubernetes
The implementation of **AWS Secrets Manager** integration with Kubernetes faced several blockers due to the use of **Docker Desktop** as the local Kubernetes environment. These challenges primarily stem from the limitations of Docker Desktop, such as:

1. **Encapsulation Issues**:
Docker Desktop’s Kubernetes setup does not expose public endpoints, restricting some configurations and integrations.

2. **Port Forwarding Requirements**:
To access the deployed API REST service, manual port forwarding is required, adding complexity to the setup.

Due to these limitations, I opted to provide **scripts** and a **deployment file** to allow you to deploy and test the system in a more compatible Kubernetes environment, such as a production cluster.

#### Challenges and Workarounds
**Challenge: AWS Secrets Manager Integration**
- **Issue**: Docker Desktop’s Kubernetes lacks native compatibility with AWS Secrets Manager due to its limited networking and encapsulation.
- **Workaround**: Provide a script to manually create Kubernetes secrets and configure the deployment to use these secrets instead of relying on direct integration.

**Challenge: Port Forwarding**
- **Issue**: The Kubernetes service is not publicly accessible due to the local nature of Docker Desktop.
- **Workaround**: Use kubectl port-forward to forward traffic to the local machine for testing the API REST service.

**Challenge: Limited Features in Local Kubernetes**
- **Issue**: Some Kubernetes capabilities are unavailable or restricted in Docker Desktop.
- **Workaround**: Focus on providing a portable solution that works on full-featured Kubernetes clusters (e.g., Amazon EKS, GKE).

#### Recommendations
1.	**Production Setup:**
Deploy to a production Kubernetes cluster like Amazon EKS or Google Kubernetes Engine (GKE) for full AWS Secrets Manager integration.

2.	**Use Kubernetes Secrets for Development:**
In local environments, use Kubernetes secrets instead of AWS Secrets Manager to simplify development and testing.

3.	**Future Enhancements:**
Explore tools like external-secrets for better integration between Kubernetes and AWS Secrets Manager when using production-grade clusters.