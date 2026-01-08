# CoolCalc Pro - macOS Edition

**CoolCalc Pro** is a professional-grade cooling capacity estimator built for macOS, designed to help HVAC technicians and users quickly calculate the required cooling capacity for various room types based on ASHRAE standards.

## Features

- **Standard Cooling Estimates**: Calculate required BTU/h, kW, and HP based on room area.
- **Advanced Inputs**:
  - Huge input range: **0 - 20,000 m²**.
  - Quick slider for common room sizes (2 - 1,000 m²).
  - "Tropical Area" mode (+30% capacity adjustment).
  - Detailed environmental factors (Sun exposure, insulation, occupancy, electronics).
- **Intelligent Recommendations**: Automatically suggests appropriate AC unit configurations (e.g., "1x 1.5 HP Split Unit") based on calculated load.
- **Cost Estimation**: Real-time monthly electricity cost estimation dashboard.
- **Room Management**: Save, rename, and manage multiple room records.
- **Export**: Export calculations to CSV for reporting.
- **Native macOS Experience**:
  - Built with **SwiftUI**.
  - Automatic **Dark Mode** support.
  - Responsive layout.
  - Localized in **English, French, Chinese, and Arabic**.

## Usage

1.  **Input Area**: Type explicitly or use the slider for quick adjustment.
2.  **Select Room Type**: Choose from Bedroom, Living Room, Server Room, etc.
3.  **Adjust Factors**: Toggle environmental factors or Enable "Tropical Area" if applicable.
4.  **View Results**: See instant breakdown of kW, BTU, and HP. Check the "Recommended AC Configuration" card.
5.  **Add Record**: Click "Add to Records" to save the calculation.
6.  **Summary**: Review the "Summary" dashboard at the bottom for total project cost and load.

## Building the Project

### Requirements

- **Xcode 16.0+**
- macOS 15.0+ (Target SDK)

### Steps

1.  Clone the repository.
2.  Open `mac-cooling-calculator.xcodeproj` in Xcode.
3.  Ensure the development team is set (or let Xcode manage signing locally).
4.  Press `Cmd+R` to build and run.

## Tech Stack

- **Language**: Swift 6
- **UI Framework**: SwiftUI
- **Architecture**: MVVM (Model-View-ViewModel)
- **Data Persistence**: UserDefaults (for user preferences)

## License

This project is created for educational and professional estimation purposes.
