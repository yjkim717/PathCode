<%@ page import="java.util.Map" %>
<html>
<head>
    <title>Dashboard</title>
</head>
<body>
<h2>User Dashboard</h2>

<%
    Map<String, Object> dashboardData = (Map<String, Object>) request.getAttribute("dashboardData");
    if (dashboardData != null) {
%>
<p>Total Problems Attempted: <%= dashboardData.get("Total_Problems_Attempted") %></p>
<p>Total Problems Solved: <%= dashboardData.get("Total_Problems_Solved") %></p>
<p>Success Rate: <%= dashboardData.get("Success_Rate") %>%</p>
<p>Current Streak: <%= dashboardData.get("Current_Streak") %> days</p>
<% } else { %>
<p>No data available.</p>
<% } %>
</body>
</html>
