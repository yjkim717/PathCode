<%@ page import="java.util.List" %>
<html>
<head>
    <title>User Management</title>
</head>
<body>
<h2>User List</h2>

<!-- Display User List -->
<table border="1">
    <tr><th>ID</th><th>Username</th><th>Email</th><th>Actions</th></tr>
    <%
        List<String> users = (List<String>) request.getAttribute("users");
        if (users != null) {
            for (String user : users) {
                String[] userInfo = user.split(": ");
    %>
    <tr>
        <td><%= userInfo[0] %></td>
        <td><%= userInfo[1] %></td>
        <td><%= userInfo[2] %></td>
        <td>
            <!-- Delete User Form -->
            <form action="users" method="post" style="display:inline;">
                <input type="hidden" name="userId" value="<%= userInfo[0] %>">
                <input type="hidden" name="action" value="delete">
                <input type="submit" value="Delete">
            </form>

            <!-- Update User Form -->
            <form action="users" method="post" style="display:inline;">
                <input type="hidden" name="userId" value="<%= userInfo[0] %>">
                <input type="hidden" name="action" value="update">
                <input type="text" name="newUsername" placeholder="New Username">
                <input type="text" name="newEmail" placeholder="New Email">
                <input type="submit" value="Update">
            </form>
        </td>
    </tr>
    <% } } %>
</table>

<!-- Add New User Form -->
<h2>Add New User</h2>
<form action="users" method="post">
    <input type="hidden" name="action" value="create">
    Username: <input type="text" name="username"><br>
    Email: <input type="text" name="email"><br>
    <input type="submit" value="Add User">
</form>
</body>
</html>
