# Barber Booking App 💈 

A comprehensive **Barber Booking Application** designed to provide a seamless booking experience for users and effective management tools for barbershops. The app is built using modern tools and technologies to ensure efficiency, scalability, and a user-friendly interface.

---

## Features 🚀 

- 💇‍♂️ Discover Barbers: Explore nearby barbers based on your location.
- 📅 Appointment Booking: Book appointments for specific dates and times.
- 🛠️ Service Management: View detailed service lists provided by barbers (e.g., haircut, shaving).
- 🌟 Favorites: Save your favorite barbers for quick access.
- 🔐 Authentication: Secure login and registration with Firebase Auth.
- 📍 Location Integration: Find the nearest barbers based on your current location.
- 🔔 Notifications: Get reminders for your upcoming appointments.
- 🎨 Custom UI: A sleek and user-friendly interface for all users.

---
##  🛠️ Technologies Used
- Flutter: For cross-platform application development.
- Firebase Auth: For secure user authentication.
- Firebase Firestore: For storing user-specific data like favorites and past appointments.
- MongoDB: For managing barbers and barbershop data.
- Node.js + Express: Backend API development.
- Bloc: State management for a structured app architecture.
- Google Maps API: For location-based search and navigation.
- Lottie: For smooth animations and a polished user experience.

---
## 📜 API Endpoints

User APIs
- POST /api/users/register - User registration.
- POST /api/users/login - User login.
- POST /api/users/logout - User logout.
- GET /api/users/profile - Get user profile.

Barber APIs
- GET /api/barbers - List all barbers.
- GET /api/barbers/:id - Get details of a specific barber.
- GET /api/barbers/nearby - Find nearby barbers.

Appointment APIs
- POST /api/appointments - Create a new appointment.
- GET /api/appointments/:userId - Get all appointments for a user.

---
## 🎥 Screenshots
<img src="https://github.com/user-attachments/assets/9bca5b82-846f-42c6-b1f2-22c28d54848c" alt="Home Screen" width="200"/> 
<img src="https://github.com/user-attachments/assets/b6829e00-df8c-4e22-97e4-3ce430edb85b" alt="Booking Screen" width="200"/>  <img src="https://github.com/user-attachments/assets/e98ddc64-8bc3-4820-ab6c-8e658f06a7e0" alt="Profile Screen" width="200"/>  <img src="https://github.com/user-attachments/assets/87e66eff-6a09-4684-91b7-36bd9e9d3534" alt="Notification Screen" width="200"/>  <img src="https://github.com/user-attachments/assets/aa9fe83b-84ff-45ce-b228-06c440f00e33" alt="Barber Details Screen" width="200"/> <img src="https://github.com/user-attachments/assets/4fe1bb58-f489-465b-aabb-e911a7b4e541" alt="Location Search Screen" width="200"/> <img src="https://github.com/user-attachments/assets/926cd406-eef7-4551-a420-c04a1048cd85" alt="Favorites Screen" width="200"/> 
---

## 🤝 Contributing
Want to contribute?

- Fork this repository.
- Create a new branch (git checkout -b feature/NewFeature).
- Commit your changes (git commit -m 'Add NewFeature').
- Push to the branch (git push origin feature/NewFeature).
- Open a pull request.
