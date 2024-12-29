# Exoplanets

Based on the documentation located here: https://www.kaggle.com/datasets/mrisdal/open-exoplanet-catalogue
There are two dataset versions.

I have realised the provided JSON for this assesment: https://gist.githubusercontent.com/joelbirchler/66cf8045fcbb6515557347c05d789b4a/raw/9a196385b44d4288431eef74896c0512bad3defe/exoplanets is based on the version 1.0 of this dataset.

The dataset version 1 has 3426 exoplanets, while the version 2 has 3584.
I have checked, and effectively, by the provided json url, we are receiving 3426 exoplanets. I can confirm it by 2 checks: Same name of records provided, and same number of orphan planets based on TypeFlag: 2. The version 2 has three orphan planets.

In the Kaggle documentation, in the dataset version 2, in detail section we can find referenced the oec tables repository: https://github.com/OpenExoplanetCatalogue/oec_tables/.
In this repository, we can find the file FIELDS.md: https://github.com/OpenExoplanetCatalogue/oec_tables/blob/master/FIELDS.md
Where I can find the next field description list:

Fields description
==================
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

JSON Structure
==============
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

## Dataset - JSON field mapping
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

### 2. Find the planet orbiting the hottest star.

### 3. Generate a timeline of planet discoveries grouped by size categories.

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

## Implementation Benefits
1. **Reduced Redundancy:**
   - Combining the operations eliminates the need for multiple loops, saving computational resources.
   
2. **Improved Performance:**
   - Although the asymptotic complexity remains the same, fewer iterations translate to faster execution in practical terms.

3. **Clean and Maintainable Code:**
   - Consolidating the logic into a single loop makes the code easier to read, maintain, and debug.

## Conclusion
This refined methodology achieves all three objectives efficiently within a single iteration of the dataset. It highlights the importance of balancing theoretical computational complexity with real-world performance considerations. By optimizing the approach, we ensure the system remains performant and scalable for larger datasets.


I have configured the AWS Secrets Manager to be deployed in region us-west-2 since this is the new zone for Arizona, and latency will be reduced.
