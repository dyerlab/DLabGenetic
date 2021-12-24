# DLabGenetic

![](https://img.shields.io/badge/license-GPLv3-green) ![](https://img.shields.io/badge/swift-5.5-green) ![](https://img.shields.io/badge/iOS-14.0-green) ![](https://img.shields.io/badge/macOS-11-green) 

Current Version: ![](https://img.shields.io/github/v/tag/dyerlab/DLabGenetic?color=green)

This package is the foundation layer for all genetic data analysis objects and routines needed in software developed for the iOS and OSX platforms from the [DyerLab](https://dyerlab.org).  

<a name="Installation"></a>
# Installation

**Swift Package Manager** (XCode 13)

1. Select **File** > **Swift Packages** > **Add Package Dependency…** from the **File** menu.
2. Paste `https://github.com/dyerlab/DLabGenetic.git` in the dialog box.
3. Follow the Xcode's instruction to complete the installation.

> Why not CocoaPods, or Carthage, or blank?

Supporting multiple dependency managers makes maintaining a library exponentially more complicated and time consuming.  Since, the **Swift Package Manager** is integrated with Xcode 11 (and greater), it's the easiest choice to support going further.

---

This package defines the following base model objects:

- Locus: A base class for genetic loci
- Individual: A spatially referenced, multilocus sample.
- Stratum: A heirarchical (tree-based data structure) collection of individuals.

On this, the following items may be extracted:  

- AlleleFrequencies
- Diversity Statistics
- AMOVA
- PCA
- Population Graph

This package depends upon the [DLMatrix](https://github.com/dyerlab/DLMatrix) Swift Package for underlying vector and matrix representations.
