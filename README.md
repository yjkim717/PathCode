# PathCode Learning System

A comprehensive learning management system designed to help users improve their coding skills through personalized recommendations, structured learning paths, and progress tracking.

## 🌟 Features

### User Management
- Create, view, update, and delete user profiles
- Track user progress and performance
- Manage user permissions and access levels

### Dashboard Management
- View comprehensive learning statistics
- Track user performance metrics
- Monitor progress across different problem categories
- Visualize learning trends and patterns

### Learning Paths
- Create customized learning paths
- Track progress through different stages
- Adapt paths based on user performance
- Support for multiple difficulty levels

### Recommendations
- Personalized problem recommendations
- Confidence score system (0-100%)
- Visual progress indicators
- Problem difficulty matching
- Performance-based suggestions

### System Features
- Responsive Bootstrap UI
- Dark theme with modern design
- Real-time updates
- Secure data handling
- Automated database initialization

## 🚀 Getting Started

### Prerequisites
- Java Development Kit (JDK) 17 or higher
- Maven 3.6 or higher
- MySQL 8.0 or higher
- Tomcat 9.0 (or Jetty for development)

### Database Setup
1. Create a MySQL database:
```sql
CREATE DATABASE personalized_learning_sys;
```

2. Configure database connection in `src/main/java/com/pathcode/util/DBConnectionUtil.java`:
```java
private static final String URL = "jdbc:mysql://localhost:3306/personalized_learning_sys";
private static final String USERNAME = "your_username";
private static final String PASSWORD = "your_password";
```

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/PathCode.git
cd PathCode
```

2. Build the project:
```bash
mvn clean package
```

3. Run the application:
```bash
mvn tomcat7:run
# or for development
mvn jetty:run
```

4. Access the application:
```
http://localhost:8080/
```

## 🏗️ Project Structure

```
PathCode/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/pathcode/
│   │   │       ├── controller/    # Servlet controllers
│   │   │       ├── dao/          # Data Access Objects
│   │   │       ├── model/        # Entity classes
│   │   │       ├── service/      # Business logic
│   │   │       └── util/         # Utilities
│   │   ├── resources/           # Configuration files
│   │   └── webapp/
│   │       ├── WEB-INF/
│   │       │   ├── views/       # JSP files
│   │       │   └── templates/   # Reusable components
│   │       ├── css/            # Stylesheets
│   │       └── js/             # JavaScript files
└── pom.xml                     # Maven configuration
```

## 🔧 Key Components

### Models
- User
- Problem
- Recommendation
- LearningPath
- Dashboard
- UserProgress
- UserHistory

### Database Schema
- Automated table creation
- Schema migration support
- Default data population
- Foreign key relationships

### UI Components
- Modern dark theme
- Responsive design
- Interactive dashboards
- Progress visualization
- Form validation
- Modal confirmations

## 📊 Features in Detail

### Recommendation System
- Confidence scoring (0-100%)
- Color-coded progress bars
  - Green: ≥80%
  - Yellow: 60-79%
  - Red: <60%
- Problem difficulty matching
- User performance tracking

### Learning Path Management
- Stage-based progression
- Difficulty adaptation
- Progress tracking
- Performance metrics

### Dashboard Analytics
- Success rate tracking
- Problem completion stats
- Time-based analytics
- Category performance

## 🛠️ Development Tools

### Build Tools
- Maven for dependency management
- Tomcat/Jetty for deployment
- JUnit for testing

### Frontend Technologies
- JSP for view templates
- Bootstrap for responsive design
- jQuery for DOM manipulation
- Font Awesome for icons

### Backend Technologies
- Java Servlets
- JDBC for database access
- MySQL for data storage

## 📝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🤝 Acknowledgments

- Bootstrap for the UI framework
- Font Awesome for icons
- MySQL community
- Java community

## 📞 Contact

Your Name - [@yourusername](https://twitter.com/yourusername)

Project Link: [https://github.com/yourusername/PathCode](https://github.com/yourusername/PathCode)

# PathCode Learning System - Setup Guide

This project is set up as a Dynamic Web Project for Eclipse. Follow these steps to properly configure and run the application.

## Prerequisites
- Eclipse IDE for Java EE Developers
- Apache Tomcat 9.x
- MySQL 8.x

## Project Setup

### 1. Configure Tomcat in Eclipse
1. In Eclipse, go to Window → Preferences → Server → Runtime Environments
2. Click Add, select Apache Tomcat v9.0 and configure with your Tomcat installation directory
3. Click Finish

### 2. Add Servlet API to Project
1. Right-click on the project → Properties → Targeted Runtimes
2. Check the Apache Tomcat v9.0 server
3. Click Apply and Close

### 3. Project Dependencies
The project requires the following JAR files in the `src/main/webapp/WEB-INF/lib` directory:
- mysql-connector-j-9.1.0.jar (already included)
- jstl-1.2.jar or the taglibs jars (already included)

### 4. Database Setup
1. Create a MySQL database named `personalized_learning_sys`
2. Update database credentials if needed in `com.pathcode.util.DBConnectionUtil.java`

## Deployment

### 1. Deploy to Tomcat
1. Right-click on the project → Run As → Run on Server
2. Select the configured Tomcat server and click Finish

### 2. Access the Application
Open your browser and navigate to: http://localhost:8080/PathCodeProject/

## Troubleshooting 404 Errors

If you encounter 404 errors when accessing the application:

1. Ensure the context path is correctly set in `src/main/webapp/META-INF/context.xml`
2. Check the servlet mappings in `src/main/webapp/WEB-INF/web.xml`
3. Make sure all necessary JAR files are in the WEB-INF/lib directory
4. Verify that the Tomcat runtime is properly associated with the project
5. Clean and build the project (Project → Clean...)
6. Restart the Tomcat server completely

## Specific 404 Error for User List

If you're seeing a 404 error specifically for `/PathCodeProject/user/list`:

1. Make sure the `UserController` class is properly mapped in web.xml
2. Ensure all required servlet-api dependencies are available to the project
3. Check that the JSP files exist in the correct locations (WEB-INF/views/user/)
4. Restart Tomcat and try accessing with the correct URL: http://localhost:8080/PathCodeProject/user/list 

