<c:set var="title" value="${title}" />
<%@ include file="header.jsp" %>

<div style="text-align: center; padding: 4rem 0;">
    <h1 style="font-size: 3.5rem; font-weight: 800; margin-bottom: 1.5rem; background: linear-gradient(90deg, var(--primary), var(--accent)); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">
        Fix Your City, <br> One Report at a Time.
    </h1>
    <p style="font-size: 1.25rem; color: var(--text-muted); max-width: 700px; margin: 0 auto 2.5rem;">
        CivicFix+ uses AI to automatically classify your complaints and alerts the right officials instantly. 
        Earn Karma points for building a better neighborhood.
    </p>
    <div style="display: flex; justify-content: center; gap: 1rem;">
        <a href="<c:url value='/citizen/complaint/new'/>" class="btn btn-primary" style="width: auto; padding: 1rem 2.5rem; font-size: 1.125rem;">
            Report an Issue
        </a>
        <a href="<c:url value='/leaderboard'/>" class="btn" style="width: auto; padding: 1rem 2.5rem; font-size: 1.125rem; background: white; border: 1px solid #e2e8f0;">
            View Leaderboard
        </a>
    </div>
</div>

<div class="dashboard-grid">
    <div class="stat-card">
        <i class="fa-solid fa-robot" style="font-size: 2rem; color: var(--primary); margin-bottom: 1rem;"></i>
        <h3>AI Classification</h3>
        <p style="color: var(--text-muted); margin-top: 0.5rem;">Our rule-based NLP instantly detects category and severity as you type.</p>
    </div>
    <div class="stat-card">
        <i class="fa-solid fa-radar" style="font-size: 2rem; color: var(--accent); margin-bottom: 1rem;"></i>
        <h3>Duplicate Radar</h3>
        <p style="color: var(--text-muted); margin-top: 0.5rem;">Prevent redundant reports with our GPS-based proximity tracking.</p>
    </div>
    <div class="stat-card">
        <i class="fa-solid fa-trophy" style="font-size: 2rem; color: var(--success); margin-bottom: 1rem;"></i>
        <h3>Karma System</h3>
        <p style="color: var(--text-muted); margin-top: 0.5rem;">Get rewarded for reporting, upvoting, and verifying resolutions.</p>
    </div>
</div>

<%@ include file="footer.jsp" %>
