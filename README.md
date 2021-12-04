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

Extensions to `Array where Element == Individual` include:

- `


<a name="Locus"></a>
### Individual

The `Individual` class holds strata and locus information for a georeferenced individual record.  

The `Individual` class as the following properties:
- `id:UUID`
- `locaiton:CLLocationCoordinate2D`
- `strata:[String:String]`
- `loci:[String:Locus]`

An `Individual` object can be created as:
- `init()` Makes location as latitude = 0 longitude = 0
- `init(from decoder: Decoder)` for compliance with `Coding`

An `Individual` object has the following public functions.
- `setValueForKey( key: String, value: String)` sets either the `.strata` or `.loci` objects from the user interface (say table input).  Will parse data properly.
- `dataForKey(key: String) -> String` Returns string represetnation of either `.strata` or `.loci` object based upon key passed.  Returns empty string for non-existant key.

<a name="Locus"></a>
### AlleleFrequencies
