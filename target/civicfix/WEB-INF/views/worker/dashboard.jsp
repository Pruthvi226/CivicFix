<%@ include file="../common/taglibs.jsp" %>
<c:set var="title" value="${title}" />
<%@ include file="../common/header.jsp" %>

<div style="margin-bottom: 3rem;">
    <h1 style="font-size: 2.5rem; font-weight: 800; color: var(--primary); letter-spacing: -0.04em;">Worker Dashboard</h1>
    <p style="color: var(--text-muted); font-size: 1.125rem;">Overview of your assigned tasks and performance metrics.</p>
</div>

<!-- Stats Grid -->
<div class="dashboard-grid" style="margin-bottom: 3rem;">
    <div class="stat-card" style="border-left: 4px solid var(--secondary);">
        <div class="stat-label">Active Tasks</div>
        <div class="stat-value" style="font-size: 2.5rem;">${activeCount}</div>
        <div style="font-size: 0.875rem; color: var(--text-muted);">Assigned to you</div>
    </div>
    <div class="stat-card" style="border-left: 4px solid #16a34a;">
        <div class="stat-label">Resolved Issues</div>
        <div class="stat-value" style="font-size: 2.5rem;">${resolvedCount}</div>
        <div style="font-size: 0.875rem; color: var(--text-muted);">Awaiting verification</div>
    </div>
    <div class="stat-card" style="border-left: 4px solid var(--accent);">
        <div class="stat-label">Verified Completion</div>
        <div class="stat-value" style="font-size: 2.5rem;">${verifiedCount}</div>
        <div style="font-size: 0.875rem; color: var(--text-muted);">Success rate: <c:choose><c:when test="${totalCount > 0}">${(verifiedCount * 100 / totalCount)}%</c:when><c:otherwise>0%</c:otherwise></c:choose></div>
    </div>
</div>

<div style="display: grid; grid-template-columns: 2fr 1fr; gap: 2rem;">
    <!-- Action Center -->
    <div class="glass-card" style="padding: 2rem;">
        <h3 style="margin-bottom: 1.5rem; font-weight: 800;"><i class="fa-solid fa-screwdriver-wrench" style="color: var(--primary);"></i> Quick Actions</h3>
        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1.5rem;">
            <a href="<c:url value='/worker/schedule'/>" class="stat-card" style="text-decoration: none; display: flex; align-items: center; gap: 1rem; transition: transform 0.2s;">
                <div style="background: #eff6ff; width: 3rem; height: 3rem; border-radius: 0.75rem; display: flex; align-items: center; justify-content: center;">
                    <i class="fa-solid fa-calendar-day" style="font-size: 1.5rem; color: #1d4ed8;"></i>
                </div>
                <div>
                    <div style="font-weight: 700; color: var(--text-main);">View Schedule</div>
                    <div style="font-size: 0.75rem; color: var(--text-muted);">Your daily task map</div>
                </div>
            </a>
            <a href="<c:url value='/worker/history'/>" class="stat-card" style="text-decoration: none; display: flex; align-items: center; gap: 1rem; transition: transform 0.2s;">
                <div style="background: #f0fdf4; width: 3rem; height: 3rem; border-radius: 0.75rem; display: flex; align-items: center; justify-content: center;">
                    <i class="fa-solid fa-clock-rotate-left" style="font-size: 1.5rem; color: #16a34a;"></i>
                </div>
                <div>
                    <div style="font-weight: 700; color: var(--text-main);">Work History</div>
                    <div style="font-size: 0.75rem; color: var(--text-muted);">Review past resolutions</div>
                </div>
            </a>
        </div>
    </div>

    <!-- Notifications -->
    <div class="glass-card" style="padding: 2rem;">
        <h3 style="margin-bottom: 1.5rem; font-weight: 800;"><i class="fa-solid fa-bell" style="color: var(--accent);"></i> Alerts</h3>
        <c:choose>
            <c:when test="${not empty notifications}">
                <c:forEach var="notif" items="${notifications}">
                    <div style="padding: 0.75rem; border-bottom: 1px solid var(--border); font-size: 0.875rem;">
                        <i class="fa-solid fa-circle-info" style="color: var(--secondary); margin-right: 0.5rem;"></i>
                        ${notif.message}
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <p style="color: var(--text-muted); font-size: 0.875rem; font-style: italic;">No new alerts.</p>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>
