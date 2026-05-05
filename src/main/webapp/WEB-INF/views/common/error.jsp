<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error - CivicFix+</title>
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f8f9fa;
            color: #333;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            text-align: center;
        }
        .error-container {
            background: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            max-width: 500px;
            width: 90%;
        }
        h1 { color: #e74c3c; font-size: 2.5rem; margin-bottom: 10px; }
        p { font-size: 1.1rem; color: #666; margin-bottom: 25px; }
        .btn {
            background-color: #3498db;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 6px;
            transition: background 0.3s;
        }
        .btn:hover { background-color: #2980b9; }
    </style>
</head>
<body>
    <div class="error-container">
        <h1>Oops!</h1>
        <p>${errorMsg != null ? errorMsg : 'Something went wrong while processing your request.'}</p>
        <a href="${pageContext.request.contextPath}/" class="btn">Return to Home</a>
    </div>
</body>
</html>
