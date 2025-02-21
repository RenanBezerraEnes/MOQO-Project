## Overview
This mobile application efficiently displays Points of Interest (POIs) on a map while optimizing API requests to minimize server load and maximize performance. The application fetches POIs from the Moqo API, implements optimized data handling using bounding boxes, and provides a detailed view for selected POIs.

## Features
- **Map Display with POIs**
  - Fetch POIs using the Moqo API.
  - Optimize API requests using bounding box filtering to limit data to relevant geographical areas.
  - Implement pagination for efficient data loading.
  - Display POIs as markers on an interactive map.

- **Detail View with Additional Information**
  - Retrieve detailed POI information upon user selection.
  - Include POI name, vehicle type, provider name, and images.

- **Efficient Data Refresh**
  - Implement a refresh mechanism to reload POIs dynamically within the current bounding box.
  - Ensure the bounding box updates based on the visible map area.

- **Testing & Code Quality**
  - Integration tests for Service.
  - Unit tests for ViewModel.

## API Usage
### Fetch POIs with Bounding Box Filtering
```
GET https://prerelease.moqo.de/api/graph/discovery/pois?filter[bounding_box]={"ne_lat":51.648968,"ne_lng":7.4278984,"sw_lat":49.28752,"sw_lng":5.3754444}&page[size]=10&page[number]=1
```
- Use the `filter[bounding_box]` parameter to restrict data to a specific region.
- Implement pagination with `page[size]` and `page[number]` to load results efficiently.

### Fetch Specific POI by ID
```
GET https://prerelease.moqo.de/api/graph/discovery/pois?filter[id]=POI_ID&extra_fields[pois]=image,provider
```
- Replace `POI_ID` with the actual POI id.

## Installation & Setup
1. Clone the repository:
   ```bash
   git clone https://github.com/RenanBezerraEnes/MOQO-Project.git
   cd MOQO-Project
   ```
2. Open the project in Xcode:
   - Open Xcode and select `Open a project or file`.
   - Navigate to the cloned repository and open the `.xcodeproj` file.

3. Build and run the project:
   - Select a simulator or a connected device.
   - Click the **Run** button or press `Cmd + R`.

## How to Use It
- When you run the project, you will be positioned at a fixed location on the map with the first set of markers loaded by the API.
- Clicking on a marker will call the API endpoint with a specific POI ID and display relevant details in a second view.
- Clicking outside a marker on the map will close the detail view.
- Use `Ctrl` (Windows/Linux) or `Cmd` (Mac) along with your mouse to move around the map.
- Hold `Shift` and move your mouse in or out to zoom in and out.
- Moving to a different location and hitting the refresh button will load data for the new location using an updated bounding box.
- I've added a SwipeButtonToUnlock that triggers a transition when swiped from left to right, changing the icon from a lock to an unlock state.

Copyright Renan Bezerra.
