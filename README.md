#  ArboretumID: CMPSC475 Final Project
## Taylan Unal (@taylanu)

### About ArboretumID
- ArboretumIdentifier (ArboretumID) is an app that enhances the Penn State Arboretum experience through AR and ML. 
- Using the iPhone’s camera, ArborIdentifier scans the placard in front of any plant, and delivers rich details and descriptions about it. 
- ArboretumID provides Penn State students, alumni, and visitors of any age the opportunity to explore the incredible collections of plants, flowers, and trees at the Penn State Arboretum in a whole new way!

### Features
1. Home Tab: 
- Describes The Arboretum at Penn State and its Collections
- Introduces ArborID application

2. Explore Tab: 
- Uses data from PlantFinder for Plant Attributes to build out Collections
    - Remotely loads images for plants, and provides an 'Image Coming Soon' for plants that do not yet have images available.
- Shows all 11 Collections with Images at The Arboretum
- Each Collection has Plants with Images
- Each Plant has a DetailView showing Image, Name, Location, Taxon Name,  Family, Genus

3. Capture Tab:
- Uses CoreML pre-trained model to detect and label plants as one of 5 types:
    - Daisy, Dandelion, Rose, Sunflower, Tulip
- Provides users with 3 Capture Options:
    - Photo Library, Photo Capture, Live Preview
- Each capture option will return its prediction of what label to assign to an image, and its confidence percentage
- In the future, more training data and labels can be added to the model to expand its capabilities

4. Around Me Tab:
- Provides a SwiftUI Map view of the Arboretum, with annotations on where plants are
- Displayed annotations can be filtered by Collection
- User Location Tracking is possible, but is currently disabled.

5. Preferences Tab:
- Preferences Tab is currently unused, in the future will be used to sign in to the arboretum, save favorite plants, etc.

### Collections/Areas at Arboretum:
1. Children's Garden
2. Event Lawn
3. Fountain Garden
4. Marsh Meadow
5. North Terrace
6. Overlook Pavillion
7. Oasis Garden
8. Pollinator's Garden
9. Parking Lot
10. Rose and Fragrance Garden
11. Strolling Garden

### Data Sources:
- The Arboretum at Penn State: https://arboretum.psu.edu
- The Arboretum at Penn State Plant Finder: https://datacommons.maps.arcgis.com/apps/webappviewer/index.html?id=88d9267530dc48db8635703130bb084e
- Image Classification: https://github.com/DavidDuarte22/ImageClassification02

### Code References:
@DavidDuarte22 (AVFoundation & Classification) https://github.com/DavidDuarte22/ImageClassification02 
@NigelGee (URLImage) https://www.hackingwithswift.com/forums/swiftui/loading-images/3292

### Bug Fixes:
- Fix for the small window size, need to set a launchscreen in build settings: https://stackoverflow.com/questions/63195985/swiftui-view-being-rendered-in-small-window-instead-of-full-screen-when-using-xc
