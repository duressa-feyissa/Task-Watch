# Bloc Optimal Timer and Todo Application

This project aims to demonstrate the optimal usage of the BLoC (Business Logic Component) pattern in a Flutter application that includes both a todo activity and a timer feature. The focus of optimization lies particularly on the timer functionality to ensure smooth UI updates without unnecessary widget rebuilding.

## Features

- **Todo Activity:** Allows users to create, update, delete, and mark tasks as completed.
- **Timer:** Implements a timer feature that updates the UI every second, without causing unnecessary widget rebuilding.

## Optimization Strategy

The optimization primarily focuses on the timer functionality to prevent excessive widget rebuilding, which can impact app performance and user experience. Here's how the optimization is achieved:

1. **Separation of Concerns:** Divide the application logic into separate layers:
    - Presentation Layer: Contains UI elements and handles user interactions.
    - Business Logic Layer (BLoC): Handles business logic, data processing, and state management.
    - Data Layer: Manages data persistence and retrieval, such as storing todo tasks.

2. **Bloc Placement:** Place the timer bloc above all parent widgets that need to be rebuilt based on timer updates. This ensures that only necessary widgets are rebuilt, preventing unnecessary UI updates.

3. **State Management:** Utilize Flutter's `StreamBuilder` or `BlocBuilder` widgets to efficiently manage UI updates based on the timer's state changes. These widgets rebuild only when the underlying data (timer state) changes, reducing unnecessary widget rebuilding.

4. **Minimize Rebuilds:** Optimize the timer bloc to emit states only when necessary. For example, emit a new state only when the timer value changes, rather than every second. This minimizes UI rebuilds and improves performance.


## Usage

To use this project, follow these steps:

1. Clone the repository to your local machine:
    
        [git clone https://github.com/duressa-feyissa/Task-Watch.git]

2. Navigate to the project directory:
    
        cd bloc_mastering
        

3. Install the dependencies:
    
        flutter pub get
        

4. Run the application:
    
        flutter run
        

5. Explore the todo activity and timer features in the application.

## Contributing

Contributions to this project are welcome! If you have any ideas for optimizations or additional features, feel free to fork the repository, make your changes, and submit a pull request.



