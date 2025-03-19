<%@ page import="java.util.List" %>
<html>
<head>
    <title>Problems</title>
</head>
<body>
<h2>Problem List</h2>

<!-- Display Problem List -->
<table border="1">
    <tr><th>ID</th><th>Title</th><th>Difficulty</th><th>Actions</th></tr>
    <%
        List<String> problems = (List<String>) request.getAttribute("problems");
        if (problems != null) {
            for (String problem : problems) {
                String[] problemInfo = problem.split(": ");
    %>
    <tr>
        <td><%= problemInfo[0] %></td>
        <td><%= problemInfo[1] %></td>
        <td><%= problemInfo[2] %></td>
        <td>
            <form action="problems" method="post">
                <input type="hidden" name="problemId" value="<%= problemInfo[0] %>">
                <input type="hidden" name="action" value="delete">
                <input type="submit" value="Delete">
            </form>
        </td>
    </tr>
    <% } } %>
</table>

<!-- Add New Problem Form -->
<h2>Add New Problem</h2>
<form action="problems" method="post">
    <input type="hidden" name="action" value="create">
    Title: <input type="text" name="title"><br>
    Difficulty: <input type="text" name="difficulty"><br>
    <input type="submit" value="Add Problem">
</form>
</body>
</html>
