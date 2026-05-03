<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>CivicFix+ | ${ward.name} Details</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/style.css'/>">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .ward-header {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            padding: 4rem 2rem;
            border-radius: 0 0 2rem 2rem;
            text-align: center;
            margin-bottom: 2rem;
        }
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }
        .stat-card {
            background: white;
            padding: 1.5rem;
            border-radius: 1rem;
            box-shadow: var(--shadow-sm);
            text-align: center;
        }
        .stat-value {
            font-size: 2rem;
            font-weight: 800;
            color: var(--primary-color);
            display: block;
        }
        .stat-label {
            color: var(--text-muted);
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.05rem;
        }
    </style>
</head>
<body>
    <jsp:include page="../common/header.jsp"/>

    <div class="ward-header">
        <div class="container">
            <h1 style="font-size: 3rem; margin-bottom: 1rem;">${ward.name}</h1>
            <p style="font-size: 1.2rem; opacity: 0.9;">Ward Performance & Community Health Metrics</p>
        </div>
    </div>

    <div class="container">
        <div class="stats-grid">
            <div class="stat-card">
                <span class="stat-value">${ward.healthScore}%</span>
                <span class="stat-label">Health Score</span>
            </div>
            <div class="stat-card">
                <span class="stat-value">${complaints.size()}</span>
                <span class="stat-label">Total Issues Reported</span>
            </div>
            <div class="stat-card">
                <span class="stat-value">
                    <c:set var="resolved" value="0"/>
                    <c:forEach var="c" items="${complaints}">
                        <c:if test="${c.status == 'RESOLVED' || c.status == 'VERIFIED'}">
                            <c:set var="resolved" value="${resolved + 1}"/>
                        </c:if>
                    </c:forEach>
                    ${resolved}
                </span>
                <span class="stat-label">Issues Resolved</span>
            </div>
            <div class="stat-card">
                <span class="stat-value">${ward.population}</span>
                <span class="stat-label">Population</span>
            </div>
        </div>

        <section class="glass-card">
            <h2 class="section-title"><i class="fas fa-list-ul"></i> Recent Activity in ${ward.name}</h2>
            <div class="table-container">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Category</th>
                            <th>Description</th>
                            <th>Status</th>
                            <th>Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="c" items="${complaints}">
                            <tr>
                                <td><span class="badge badge-${c.category.toString().toLowerCase()}">${c.category}</span></td>
                                <td>${c.description}</td>
                                <td><span class="status-pill status-${c.status.toString().toLowerCase()}">${c.status}</span></td>
                                <td>${c.reportedAt}</td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty complaints}">
                            <tr>
                                <td colspan="4" style="text-align: center; padding: 2rem;">No recent issues reported in this ward. Great job!</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </section>
        
        <div style="margin-top: 2rem; text-align: center;">
            <a href="<c:url value='/leaderboard'/>" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i> Back to Leaderboard
            </a>
        </div>
    </div>

    <footer style="margin-top: 4rem; padding: 2rem; text-align: center; color: var(--text-muted);">
        &copy; 2026 CivicFix+ Urban Resilience Initiative
    </footer>
</body>
</html>
