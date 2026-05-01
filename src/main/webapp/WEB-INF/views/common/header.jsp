<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${title} | CivicFix+</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/style.css'/>">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <nav>
        <a href="<c:url value='/'/>" class="logo">
            <i class="fa-solid fa-city"></i> CivicFix+
        </a>
        <div class="nav-links">
            <a href="<c:url value='/leaderboard'/>">Leaderboard</a>
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <c:if test="${sessionScope.user.role == 'CITIZEN'}">
                        <a href="<c:url value='/citizen/dashboard'/>">My Reports</a>
                        <a href="<c:url value='/citizen/complaint/new'/>" class="btn btn-primary" style="padding: 0.5rem 1rem; width: auto;">Report Issue</a>
                    </c:if>
                    <c:if test="${sessionScope.user.role == 'WORKER'}">
                        <a href="<c:url value='/worker/schedule'/>">My Schedule</a>
                    </c:if>
                    <c:if test="${sessionScope.user.role == 'OFFICIAL'}">
                        <a href="<c:url value='/official/dashboard'/>">Official Panel</a>
                    </c:if>
                    <a href="<c:url value='/logout'/>"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
                </c:when>
                <c:otherwise>
                    <a href="<c:url value='/login'/>">Login</a>
                    <a href="<c:url value='/register'/>" class="btn btn-primary" style="padding: 0.5rem 1rem; width: auto;">Join Now</a>
                </c:otherwise>
            </c:choose>
        </div>
    </nav>
    <main class="container">
