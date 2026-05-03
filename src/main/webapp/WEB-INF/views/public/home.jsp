<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${title} | CivicFix</title>
    <!-- Bootstrap 5 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { padding-top: 50px; background-color: #f8f9fa; }
        .hero { padding: 80px 0; text-align: center; background-color: #ffffff; border-bottom: 1px solid #e9ecef; }
    </style>
</head>
<body>

    <div class="container hero">
        <h1 class="display-4 fw-bold text-primary">CivicFix</h1>
        <p class="lead text-muted mb-4">Empowering citizens to build smarter, safer communities.</p>
        
        <div class="d-grid gap-3 d-sm-flex justify-content-sm-center">
            <a href="${pageContext.request.contextPath}/login" class="btn btn-primary btn-lg px-4 gap-3">Login</a>
            <a href="${pageContext.request.contextPath}/register" class="btn btn-outline-secondary btn-lg px-4">Register</a>
        </div>
    </div>

    <div class="container mt-5 text-center">
        <h3 class="mb-3">Transparency & Accountability</h3>
        <p>View real-time metrics on how your local ward is performing.</p>
        <a href="${pageContext.request.contextPath}/public/transparency" class="btn btn-info text-white">Public Transparency Board</a>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
