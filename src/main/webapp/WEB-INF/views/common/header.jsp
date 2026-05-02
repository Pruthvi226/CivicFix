<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${title} | CivicFix+ Smart City</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/style.css'/>">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { font-family: 'Plus Jakarta Sans', sans-serif; }
    </style>
</head>
<body>
    <nav>
        <div class="container" style="display: flex; justify-content: space-between; align-items: center; padding: 0;">
            <a href="<c:url value='/'/>" class="logo">
                <i class="fa-solid fa-building-columns" style="color: var(--secondary);"></i>
                <span style="letter-spacing: -0.04em;">Civic<span style="color: var(--secondary);">Fix+</span></span>
            </a>
            <div class="nav-links">
                <a href="<c:url value='/leaderboard'/>">City Health</a>
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <c:if test="${sessionScope.user.role == 'CITIZEN'}">
                            <a href="<c:url value='/citizen/dashboard'/>">Dashboard</a>
                            <a href="<c:url value='/citizen/complaint/new'/>" class="btn btn-primary">Report Issue</a>
                        </c:if>
                        <c:if test="${sessionScope.user.role == 'WORKER'}">
                            <a href="<c:url value='/worker/schedule'/>">My Tasks</a>
                        </c:if>
                        <c:if test="${sessionScope.user.role == 'OFFICIAL'}">
                            <a href="<c:url value='/official/dashboard'/>">Command Center</a>
                        </c:if>
                        <a href="<c:url value='/logout'/>" style="color: var(--error);"><i class="fa-solid fa-power-off"></i></a>
                    </c:when>
                    <c:otherwise>
                        <a href="<c:url value='/login'/>">Sign In</a>
                        <a href="<c:url value='/register'/>" class="btn btn-primary">Join Community</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </nav>
    <main class="container">
