
Food Management App : 

1. Overview
The Food Management App is designed to help users manage their meal plans efficiently. It includes features like adding, updating, and deleting meal plans, with state management handled by MobX and persistent data storage managed via SharedPreferences. 

2. Features
- MobX State Management: Used for managing the meal plan state efficiently in the app.
- Meal Plan Management: Users can add, delete, and view meal plans.
- Price Breakdown: Users can see a price breakdown for each meal.
- SharedPreferences Integration: Meal plans are stored persistently across app sessions using SharedPreferences.

3. Screens in the app
   - SplashScreen
   - Meal Plan Screen
   - Add Plan Screen
   - Set Plan Screen - Double tap on meal plan card (Gesture detector feature)
   - Meal Tracker Screen
   - Feedback Screen
   - Demonstration Video link : https://drive.google.com/file/d/1NOPMaSlRlxYI8tvgdSysYcyjeNeV_fvo/view?usp=drivesdk


4. State Management with MobX
   
MobX is a reactive state management library that simplifies managing app state with a focus on observables and reactions.

6. Why MobX for Small Scale Apps?
   
   MobX is particularly suitable for small-scale apps due to:
   - Simplicity: MobX has a simple API, making it easy to integrate and use.
   - Reactivity: It automatically updates the UI when observable data changes, providing a smooth user experience.
   - Minimal Boilerplate: Unlike other state management libraries like Provider or BLoC, MobX requires less boilerplate code, making it ideal for small apps with       moderate complexity.

   For larger-scale apps, MobX may become harder to manage due to performance concerns, especially with many observable states and actions. For such apps, more        structured state management solutions like BLoC or Redux might be more appropriate.


8. SharedPreferences for Data Persistence

How SharedPreferences is Used:
- Adding Data: When a new meal plan is created, it is encoded to JSON and stored in SharedPreferences.
- Retrieving Data: Stored meal plans are fetched when the app loads, and the UI is updated accordingly.
- Deleting Data: Users can delete meal plans, and the removal is reflected in SharedPreferences, ensuring data consistency between app sessions.

7. Add and Delete Functionality:
   
   a. Add a Meal Plan: 
   - The user inputs meal plan details (e.g., plan name, frequency, amount) and selects meals.
   - Once the form is submitted, the new plan is saved to SharedPreferences.
   - The app immediately updates the UI to show the new meal plan.

   b. Delete a Meal Plan:
   - Users can delete a meal plan by tapping on it, which removes it from the list.
   - Upon deletion, the plan is removed from SharedPreferences and the local state is updated.
   - A confirmation message is displayed after the deletion.


8. Screens and Navigation
   
   a. Meal Plan Screen: Displays a list of all saved meal plans.
   - Users can view meal details.
   - Meal plans can be added by navigating to the "Add Plan" screen.

   b. Add Plan Screen: Provides a form to add a new meal plan.
   - Includes input fields for plan name, amount, frequency, and meal options.
   - The user can toggle the price breakdown for each meal.

   c. Delete Plan: When a meal plan is tapped, it is deleted from the list, and the changes are saved to SharedPreferences.

10. Technologies Used
- MobX: State management for reactive UI updates.
- SharedPreferences: Persistent storage of meal plans across app sessions.
- Flutter: Framework for building cross-platform apps.
- Json Parsing: Json Parsing for displaying the menu.


10. Conclusion:
This app serves as an efficient solution for managing meal plans with persistent storage and reactive state management. MobX is ideal for this small-scale app due to its simplicity and reactivity. SharedPreferences ensures that meal plans are stored and retrieved seamlessly between app sessions, providing a consistent user experience.
