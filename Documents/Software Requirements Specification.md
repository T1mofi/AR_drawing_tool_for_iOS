# Software Requirements Specification

## 1. Introduction

### 1.1 Purpose
The purpose of AR Drawing tool for iOS is lets users make simple 3D drawings in augmented reality. 

### 1.2 Document conventions
| Term | Definition |
|:---|:---|
| AR | Augmented reality (AR) is a type of interactive, reality-based display environment that takes the capabilities of computer generated display, sound, text and effects to enhance the user's real-world experience. | 
| SceneKit | High-level 3D graphics framework that helps create 3D animated scenes and effects in apps. | 
| ARKit | Framework that helps integrate iOS device camera and motion features to produce augmented reality experiences in app or game. |
| Scene | The SceneKit scene to be displayed in view. |

### 1.3 Intended Audience and Reading Suggestions
Children and youth who are interested in technology. And people of other age categories who are interested AR.

### 1.4 Project scope
The "AR Drawing tool for iOS" allows users to create simple 3D drawings in AR. The user can select objects from the list of basic shapes, select their color and size, and then place them in front of the camera or on the surface.

### 1.5 References
* [Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/ios/overview/themes/)
* [Apple Developer Documentation](https://developer.apple.com/documentation)

## 2. User Requirements

### 2.1 Software Interfaces
Swift language and integrated development environment xcode will be used to develop the application.

| Framework | Discription |
|:---|:---|
| Foundation | The Foundation framework provides a base layer of functionality for apps and frameworks, including data storage and persistence, text processing, date and time calculations, sorting and filtering, and networking. |
| UIKit | Used to construct and manage a graphical, event-driven user interface. |
| ARKit | Integrate iOS device camera and motion features to produce augmented reality experiences in your app or game. |
| SceneKit | Create 3D games and add 3D content to apps using high-level scene descriptions. Easily add animations, physics simulation, particle effects, and realistic physically based rendering. SceneKit combines a high-performance rendering engine with a descriptive API for import, manipulation, and rendering of 3D assets. |

### 2.2 User Interfaces
AR scene screen provides acces to the main functionaliti of the application. Allows to add 3D objects and select add mode.

![AR scene screen](../Images/Mockups/AR%20Drawing%20mockup1%20entity.png)

Screen for choosing a shape. Allows to select shape of the object it's color and size.

![Shape Picker](../Images/Mockups/ShapePicker.png)

Color picker screen allow to select Color.

![Color Picker](../Images/Mockups/ColorPicker.png)

### 2.3 User Characteristics
Children and youth who are interested in technology. And people of other age categories who are interested AR.

### 2.4 Assumptions and Dependencies
User permission to access the camera must be obtained.
The compass and accelerometer of the device should work correctly.
The application can be used only in good lighting.

## 3. System Requirements

### 3.1 Functional Requirements
display reality
add augmented reality
reset scene
undo last
shape piccker -> size picker 
color picker


### 3.2 Non-Functional Requirements
without lags and bugs
constant position on scene
