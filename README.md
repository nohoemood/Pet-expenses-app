# Pet Expenses App

A modern iOS application for tracking personal expenses, built with a hybrid approach using UIKit and SwiftUI. I built this side project to master programmatic UI, compositional layouts, and the MVVM architecture. The app focuses on a fluid, interactive user experience with real-time visual feedback.

### 1. Technologies

* `Swift`
* `UIKit`
* `UICollectionView`
  * `CompositionalLayout`
  * `UICollectionViewCell`
* `Core animation`
* `SwiftUI`
* `MVVM Architecture`

### 2. Features

* **UIKit + SwiftUI:** A hybrid approach combining complex `UICollectionView` input forms with reactive SwiftUI lists.
* **Programmatic UI:** 100% code-based layouts using **Auto Layout** and **Compositional Layout** (zero Storyboards).
* **MVVM Architecture:** Clean separation of business logic and view states using custom delegates and `@ObservedObject`.
* **Dynamic Animations:** Real-time color synchronization and fluid scroll effects built with SwiftUI's `scrollTransition`.

### 3. The Process

* **Architecture:** Structured the app using the **MVVM** pattern to cleanly separate business logic from UI.
* **UIKit Module:** Built the input screen programmatically using `UICollectionView` and `CompositionalLayout` for static, interactive category chips.
* **Dynamic Interactivity:** Implemented custom cell selection logic and real-time UI color synchronization that reacts instantly to user inputs.
* **SwiftUI Module:** Developed the main expense list with SwiftUI, utilizing `scrollTransition` for blur/scale animations and native context menus for deletion.
* **State Bridging:** Synchronized data flow between UIKit and SwiftUI components using custom delegates and `@ObservedObject`.

### 4. What I Learned

* **Hybrid Integration:** Bridging UIKit and SwiftUI to combine granular layout control with declarative UI rendering.
* **Programmatic Layouts:** Building 100% code-based grid systems using `UICollectionViewCompositionalLayout` (zero Storyboards).
* **Cross-Framework State Management:** Maintaining a single source of truth between UIKit delegates and SwiftUI's `@ObservedObject`.
* **Animations:** Implementing real-time interactive feedback using `UIView.animate` and SwiftUI scroll phases.

### 5. How can it be improved?

* Add CoreData or SwiftData to save expenses permanently on the device.
* Add charts and graphs to visualize monthly spending by category.
* Add full Dark Mode support with custom color assets.
* Add editing functionality to update an expense after it's created.

### 6. Running the Project

To run the project in your local environment, follow these steps:

1. Clone the repository to your local machine.
2. Open `Expenses.xcodeproj` in Xcode (requires Xcode 15.0+).
3. Wait for any background indexing to complete.
4. Press `Cmd + R` (or click the Play button) to build and run the app in the iOS Simulator.

### 7. Screenshots 

| Main Dashboard | Interactive Filters | Quick Actions |
| :---: | :---: | :---: |
| <img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-09-03 at 19 53 50" src="https://github.com/user-attachments/assets/2c51639d-b6f6-4de9-bf0c-843bddaa2ef6" /> | <img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-09-03 at 19 53 58" src="https://github.com/user-attachments/assets/a1076570-e572-4026-925d-a8413cb89539" /> | <img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-09-03 at 19 54 02" src="https://github.com/user-attachments/assets/cb061143-80ae-4ce7-95d4-b0c83855d01f" /> |
| Overview of all expenses with total balance and color-coded dashes. | Selecting a filter (e.g., "Low") instantly updates the list and recalculates the total sum. | Native context menus allow for seamless and intuitive expense deletion. |

| Dynamic UI: Low Tier | Dynamic UI: Middle Tier | Dynamic UI: High Tier |
| :---: | :---: | :---: |
| <img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-09-03 at 19 54 34" src="https://github.com/user-attachments/assets/521d2159-bd5b-4bc9-9eb1-2dbe43010fa8" /> | <img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-09-03 at 19 54 45" src="https://github.com/user-attachments/assets/0b5510c9-cdd6-481f-a5b3-d30559da579e" /> | <img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-09-03 at 19 55 04" src="https://github.com/user-attachments/assets/d4901e5b-1f64-477d-a26c-27ebf30a8328" /> |
| Entering a price under $500 triggers the green state and slightly fills the progress ring. | As the price increases, the interface smoothly transitions to the yellow state. | High expenses turn the UI red with a fully completed progress circle. |

| Scroll Animations | Custom UIKit Form |
| :---: | :---: |
| <img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-09-03 at 19 54 10" src="https://github.com/user-attachments/assets/ce0c6ca0-efc7-4ca7-8d21-02eab1af223d" /> | <img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-09-03 at 19 54 17" src="https://github.com/user-attachments/assets/2f99300a-4c4c-49f7-b3d2-436d4af71e70" /> |
| SwiftUI `scrollTransition` adds a beautiful blur and scale effect to expense cards as they scroll into view. | The initial state of the programmatic UIKit input form, featuring perfectly sized chips built with `CompositionalLayout`. |

| Smooth Animations | Real-Time Updates |
| :---: | :---: |
| <img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-09-03 at 19 54 55" src="https://github.com/user-attachments/assets/f1ca8f6a-586d-4e87-b50f-b1487c6a6fda" /> | <img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-09-03 at 19 55 16" src="https://github.com/user-attachments/assets/cb6019c7-2933-487a-ab03-2b0ff4e1051c" /> |
| The custom ring calculates the percentage and changes color dynamically (e.g., $1150 fills the red arc smoothly). | After saving, the new expense instantly appears at the bottom of the list and the total balance updates automatically. |



