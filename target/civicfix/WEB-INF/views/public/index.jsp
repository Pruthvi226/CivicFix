<%@ include file="../common/taglibs.jsp" %>
<c:set var="title" value="${title}" />
<%@ include file="../common/header.jsp" %>

<div style="padding: 5rem 0; border-bottom: 1px solid var(--border);">
    <div style="max-width: 800px;">
        <span style="background: #ecfdf5; color: #059669; padding: 0.5rem 1rem; border-radius: 999px; font-size: 0.875rem; font-weight: 700; margin-bottom: 1.5rem; display: inline-block;">
            <i class="fa-solid fa-sparkles"></i> AI-Powered Governance
        </span>
        <h1 style="font-size: 4rem; font-weight: 800; line-height: 1.1; margin-bottom: 1.5rem; color: var(--primary); letter-spacing: -0.04em;">
            Building a <span style="color: var(--secondary);">Smarter</span>,<br> Better City Together.
        </h1>
        <p style="font-size: 1.25rem; color: var(--text-muted); margin-bottom: 2.5rem; line-height: 1.6;">
            CivicFix+ bridges the gap between citizens and officials. Report issues in seconds, 
            track resolutions in real-time, and earn rewards for your contribution.
        </p>
        <div style="display: flex; gap: 1rem;">
            <a href="<c:url value='/citizen/complaint/new'/>" class="btn btn-primary" style="padding: 1rem 2rem; font-size: 1rem;">
                Report an Issue
            </a>
            <a href="<c:url value='/register'/>" class="btn btn-outline" style="padding: 1rem 2rem; font-size: 1rem;">
                Join the Mission
            </a>
        </div>
    </div>
</div>

<div style="padding: 5rem 0;">
    <h2 style="text-align: center; margin-bottom: 3rem; font-size: 2rem; font-weight: 800;">How CivicFix+ Works</h2>
    <div class="dashboard-grid">
        <div class="stat-card">
            <div style="background: #f1f5f9; width: 3rem; height: 3rem; border-radius: 0.75rem; display: flex; align-items: center; justify-content: center; margin-bottom: 1.5rem;">
                <i class="fa-solid fa-camera" style="font-size: 1.5rem; color: var(--primary);"></i>
            </div>
            <h3>1. Snap & Report</h3>
            <p style="color: var(--text-muted); margin-top: 0.5rem;">Describe the issue. Our AI instantly detects category and severity to route it to the right department.</p>
        </div>
        <div class="stat-card">
            <div style="background: #f1f5f9; width: 3rem; height: 3rem; border-radius: 0.75rem; display: flex; align-items: center; justify-content: center; margin-bottom: 1.5rem;">
                <i class="fa-solid fa-route" style="font-size: 1.5rem; color: var(--secondary);"></i>
            </div>
            <h3>2. Transparent Tracking</h3>
            <p style="color: var(--text-muted); margin-top: 0.5rem;">Watch your report move from 'Assigned' to 'Resolved' with photo proof from field workers.</p>
        </div>
        <div class="stat-card">
            <div style="background: #f1f5f9; width: 3rem; height: 3rem; border-radius: 0.75rem; display: flex; align-items: center; justify-content: center; margin-bottom: 1.5rem;">
                <i class="fa-solid fa-medal" style="font-size: 1.5rem; color: var(--accent);"></i>
            </div>
            <h3>3. Earn Karma</h3>
            <p style="color: var(--text-muted); margin-top: 0.5rem;">Verify resolutions and upvote others to earn Karma points and city-wide recognition.</p>
        </div>
    </div>
</div>

<div style="background: var(--primary); color: white; padding: 4rem; border-radius: 1.5rem; margin-bottom: 5rem; display: flex; justify-content: space-around; text-align: center;">
    <div>
        <div style="font-size: 2.5rem; font-weight: 800;">98%</div>
        <div style="opacity: 0.8; font-size: 0.875rem; text-transform: uppercase; margin-top: 0.5rem;">Resolution Rate</div>
    </div>
    <div>
        <div style="font-size: 2.5rem; font-weight: 800;">2.4k</div>
        <div style="opacity: 0.8; font-size: 0.875rem; text-transform: uppercase; margin-top: 0.5rem;">Active Citizens</div>
    </div>
    <div>
        <div style="font-size: 2.5rem; font-weight: 800;">45m</div>
        <div style="opacity: 0.8; font-size: 0.875rem; text-transform: uppercase; margin-top: 0.5rem;">Avg Response Time</div>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>
