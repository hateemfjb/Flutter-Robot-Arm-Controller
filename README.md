# Flutter Robot Arm Controller 

## 📌 Description

This mobile application was developed using Flutter to control a 4-DOF robotic arm. The user can adjust four motor values using sliders, save the current pose (motor positions) into a MySQL database, view all saved poses in a table, and execute or delete them. The backend is built using PHP, and the data is stored in MySQL using XAMPP.

---
![app_interface_screenshot](https://github.com/user-attachments/assets/6cd014ff-0c0e-41c2-a781-dbe7b0b7735b)


---
## 🛠️ Technologies Used

| Technology | Usage                      |
|------------|----------------------------|
| Flutter    | Mobile App Development     |
| PHP        | Backend Server Scripts     |
| MySQL      | Database                   |
| XAMPP      | Localhost Server           |

---

## 📂 File Structure

| File/Folder             | Description                                |
|-------------------------|--------------------------------------------|
| flutter_robotapp/     | Main Flutter project                       |
| └── lib/main.dart     | Main app UI & logic                        |
| └── pubspec.yaml      | Flutter dependencies & assets              |
| └── assets/robot_arm.png | Robot arm image used in UI             |
| robot_api/            | Folder containing PHP scripts              |
| └── save_pose.php     | Saves a pose to the database               |
| └── get_run_pose.php  | Returns all saved poses in JSON format     |
| └── update_status.php | Updates the run status of a pose           |
| └── delete_pose.php   | Deletes a pose by ID                       |
| app_interface_screenshot.jpg   | Images showing the application interface   |
| README.md             | Full project documentation (this file)     |

---

## 🧩 Database Structure

- Database Name: robot_arm_db
- Table Name: robot_status

| Column Name | Type        | Description                     |
|-------------|-------------|---------------------------------|
| id        | INT         | Auto-increment primary key      |
| motor1    | INT         | Motor 1 position (0-180)        |
| motor2    | INT         | Motor 2 position (0-180)        |
| motor3    | INT         | Motor 3 position (0-180)        |
| motor4    | INT         | Motor 4 position (0-180)        |
| `run_status`| INT     | 0 (default), 1 (selected to run)|
| `created_at`| TIMESTAMP   | Time of saving the pose         |

```sql
CREATE TABLE robot_status (
  id INT AUTO_INCREMENT PRIMARY KEY,
  motor1 INT NOT NULL,
  motor2 INT NOT NULL,
  motor3 INT NOT NULL,
  motor4 INT NOT NULL,
  run_status INT NOT NULL DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```
## 🚀 How to Run the Project

### Flutter Side:1. Open terminal and navigate to:
   cd C:\Users\rifan.MSI\flutter_robotapp

2. Get dependencies:
   flutter pub get

3. Make sure image asset robot_arm.png is located at:
   flutter_robotapp/assets/robot_arm.png

4. Run app on emulator or connected phone:
   flutter run

---

### Backend Side (PHP + MySQL):1. Open XAMPP and start Apache and MySQL.

2. Place the folder robot_api/ inside:
   C:\xampp\htdocs\

3. Open phpMyAdmin and create the database:
   CREATE DATABASE robot_arm_db;

4. Run the table creation SQL mentioned above.

---

## ✅ App Features

- 4 sliders to control motors (starts at 90)
- Save button to store current motor values in the database
- Run button to activate a pose (changes its run_status)
- Reset button resets all sliders to 90
- Table shows all saved poses with:
  - Play Button ▶️ to activate
  - Delete Button 🗑️ to remove

---

## 📸 Output Preview (Interface)

Include screenshots like:
- Full screen of app
- Table with saved poses
- Sliders and control buttons

---

## ⚠️ Notes

- The ID field auto-increments, but is not shown in UI.
- pose_name field was removed based on latest requirement.
- App supports only local testing via XAMPP.
