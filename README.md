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

🤝 Contributing
Want to contribute?

Fork this repository.
Create a new branch (git checkout -b feature/NewFeature).
Commit your changes (git commit -m 'Add NewFeature').
Push to the branch (git push origin feature/NewFeature).
Open a pull request.
