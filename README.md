![Dyerlab logo](https://live.staticflickr.com/65535/51722755557_2368c8fb01_o_d.jpg)

# DLGenetic

![](https://img.shields.io/badge/license-GPLv3-green) ![](https://img.shields.io/badge/maintained%3F-Yes-green) ![](https://img.shields.io/badge/swift-5.5-green) ![](https://img.shields.io/badge/iOS-14.0-green) ![](https://img.shields.io/badge/macOS-11-green)

Current Version: 1.0.0

This package is the foundation layer for all genetic data analysis objects and routines needed in software developed for the iOS and OSX platforms from the [DyerLab](https://dyerlab.org).  


<a name="Installation"></a>
## Installation

**Swift Package Manager** (XCode 13)

1. Select **File** > **Swift Packages** > **Add Package Dependency…** from the **File** menu.
2. Paste `https://github.com/dyerlab/DLGenetic.git` in the dialog box.
3. Follow the Xcode's instruction to complete the installation.

> Why not CocoaPods, or Carthage, or blank?

Supporting multiple dependency managers makes maintaining a library exponentially more complicated and time consuming.  Since, the **Swift Package Manager** is integrated with Xcode 11 (and greater), it's the easiest choice to support going further.

---

This package defines the following objects objects:

- <a href="#Locus">Locus</a>
- <a href="#Individual">Individual</a>
- <a href="#AlleleFrequencies">AlleleFrequencies</a>

This package depends upon the [DLMatrix](https://github.com/dyerlab/DLMatrix) Swift Package for underlying vector and matrix representations.

---

## Class Objects

<a name="Locus"></a>
### Locus 

The locus class has the following properties:
- `id: UUID`
- `alleles:[String]`
- `isHeterozygote:Bool`
- `ploidy:Int`
- `isEmpty:Bool`
- `description:String` to conform to `CustomStringConvertable`

A `Locus` object can be constructed as:
- `init()` 
- `init(raw:String)` where `raw` is a string of alleles  separated by a colon (e.g., `3:4`)
- `init(from decoder: Decoder)` for conformance to `Coding`
 

This class conforms to the following protocols: 
- `DLMatrix::asVector()`
- `Identifiable`
- `Equatable`
- `Codable`
- `CustomStringConvertible`

Operators overloaded to handle `Locus` objects include:
- `-` to find the AMOVA distance between the two loci.
- `==` to determine equality of genotypes.


<a name="Locus"></a>
### Individual

The `Individual` class holds strata and locus information for a georeferenced individual record.  

The `Individual` class as the following properties:
- `id:UUID`
- `location:CLLocationCoordinate2D`
- `strata:[String:String]`
- `loci:[String:Locus]`
- `description:String` to comply with CustomStringConvertable

An `Individual` object can be created as:
- `init()` Makes location as latitude = 0 longitude = 0
- `init(from decoder: Decoder)` for compliance with `Coding`

An `Individual` object has the following public functions.
- `setValueForKey( key: String, value: String)` sets either the `.strata` or `.loci` objects from the user interface (say table input).  Will parse data properly.
- `dataForKey(key: String) -> String` Returns string represetnation of either `.strata` or `.loci` object based upon key passed.  Returns empty string for non-existant key.

Overloaded operators for `Individual` objects include:
- `-` A subtraction operator defines the multilocus AMOVA disance between two individuals.


Extensions to `Array where Element == Individual` include the following properties:

- `strataKeys:[String]` Returns names of strata.
- `allLevels:[String]` Returns array of all strata names prepended by "All"
- `locusKeys:[String]` The names of the loci
- `allKeys:[String]` The names of all strata, coordinates, and loci.
- `locations:[CLLocationCoordinate2D]` An array of coordinates for all individuals.
- `center:CLLocationCoordinate2D` The centroid of the individuals.

Extensions to `Array where Element == Individual` include the following functions:
- `levelsForStratum(key: String) -> [String]` Returns the levels within the stratum.
- `getLoci( named: String) -> Loucs` Returns named `Locus` or empty one if not existing.
- locales( stratum: String, values: [String]) -> [Individual]` Grab a subset of indiviudals based upon a particular set of locales.
- `partition(by: String) -> [String: [Individual] ]` Returns a dictionary of indivudals based upon partitions.
- `frequencyFor(locus: String, stratum: String, level: String) -> AlleleFrequency` Returns an `AlleleFrequencies` object for a particular locale.
- `individualsAtStratum(stratim: String, level: String) -> [Individual]` Grab a set of individuals for a particular locale. 





<a name="Locus"></a>
### AlleleFrequencies
