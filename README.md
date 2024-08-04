# Image Carousel with Searchable List

## Overview

This iOS application showcases a simple UI with an image carousel and a searchable table view list. The carousel allows users to swipe through images, while the table view displays a list of items that can be filtered using a search bar. The search bar remains pinned to the top when scrolling the page.

## Features

- **Image Carousel**: 
  - Swipe left or right to view different images.
  - Handles any number of images.
- **List View**:
  - Displays items in a table view.
  - Handles any number of items.
  - List content updates based on the currently displayed image in the carousel.
- **Search Functionality**:
  - Filter the list items based on the user's input.
  - The search bar stays pinned to the top of the screen as the user scrolls.

## Components

- **UIImageView**: Used in the carousel to display images.
- **UICollectionView**: Manages the horizontal image carousel.
- **UITableView**: Displays the list of items that can be filtered.
- **UISearchBar**: Allows users to filter items in the table view.
- **UIScrollView**: Manages the scrolling of the entire view including the carousel and table view.

## Installation

1. Clone the repository:
    ```bash
    git clone https://github.com/yourusername/repository-name.git
    ```

2. Open the project in Xcode.

3. Build and run the project on an iOS simulator or device.

## Usage

- **Image Carousel**: Swipe left or right to navigate through images.
- **Table View**: Scroll through the list of items.
- **Search Bar**: Enter text to filter the items in the list. The list will update dynamically based on the search input.

## Code Explanation

- **ViewController**: The main view controller that handles the setup and functionality of the UI components.
- **setupUI()**: Initializes and configures the scroll view, image carousel, search bar, and table view.
- **setupScrollView()**: Configures the scroll view to hold the image carousel and table view.
- **setupImageCarousel()**: Sets up the UICollectionView for image carousel functionality.
- **setupSearchBar()**: Configures the search bar and its container view.
- **setupTableView()**: Configures the UITableView to display and manage the list of items.
- **scrollViewDidScroll()**: Adjusts the position of the search bar container based on scroll position.

## Contributions

Feel free to fork this repository and submit pull requests. Issues and feature requests are also welcome.
## Demo Video

[Watch the demo video](./demo.mp4)

### GIF Preview
![Demo](./demojif.gif)

