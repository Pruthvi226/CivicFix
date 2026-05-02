<%@ include file="../common/taglibs.jsp" %>
<c:set var="title" value="${title}" />
<%@ include file="../common/header.jsp" %>

<div style="margin-bottom: 2rem;">
    <h1 style="font-size: 2.25rem; font-weight: 800; color: var(--primary); letter-spacing: -0.04em;">AI Predictive Heatmap</h1>
    <p style="color: var(--text-muted);">Real-time ward health assessment based on active reports and historical resolution speed.</p>
</div>

<div class="stat-card" style="padding: 0; overflow: hidden;">
    <div style="padding: 1.5rem; border-bottom: 1px solid var(--border); background: #f8fafc; display: flex; justify-content: space-between; align-items: center;">
        <h3 style="font-size: 1rem; margin: 0;"><i class="fa-solid fa-map-location-dot" style="margin-right: 0.5rem;"></i> Ward Health Overview</h3>
        <div style="display: flex; gap: 1rem; font-size: 0.75rem; font-weight: 600;">
            <span style="display: flex; align-items: center; gap: 0.25rem;"><span style="width: 12px; height: 12px; background: #10b981; border-radius: 2px;"></span> Healthy (80+)</span>
            <span style="display: flex; align-items: center; gap: 0.25rem;"><span style="width: 12px; height: 12px; background: #f59e0b; border-radius: 2px;"></span> Caution (50-80)</span>
            <span style="display: flex; align-items: center; gap: 0.25rem;"><span style="width: 12px; height: 12px; background: #ef4444; border-radius: 2px;"></span> At Risk (<50)</span>
        </div>
    </div>
    
    <div class="heatmap-grid fade-in">
        <c:forEach var="ward" items="${wards}">
            <c:set var="color" value="#10b981" />
            <c:set var="bg" value="#f0fdf4" />
            <c:if test="${ward.healthScore < 80}"><c:set var="color" value="#f59e0b" /><c:set var="bg" value="#fffbeb" /></c:if>
            <c:if test="${ward.healthScore < 50}"><c:set var="color" value="#ef4444" /><c:set var="bg" value="#fef2f2" /></c:if>
            
            <div class="heatmap-cell" style="background: ${bg}; border: 2px solid ${color}44;">
                <div style="font-size: 0.75rem; font-weight: 700; color: var(--text-muted); text-transform: uppercase; margin-bottom: 0.5rem;">${ward.name}</div>
                <div style="font-size: 1.5rem; font-weight: 800; color: ${color};">${ward.healthScore}%</div>
                <div style="font-size: 0.65rem; font-weight: 600; margin-top: 0.5rem; opacity: 0.8;">
                    <c:choose>
                        <c:when test="${ward.healthScore < 50}">IMMINENT RISK</c:when>
                        <c:when test="${ward.healthScore < 80}">MODERATE FLAG</c:when>
                        <c:otherwise>STABLE</c:otherwise>
                    </c:choose>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<div style="margin-top: 2rem; display: grid; grid-template-columns: 1fr 1fr; gap: 1.5rem;">
    <div class="stat-card">
        <h3 style="font-size: 1rem; margin-bottom: 1rem;"><i class="fa-solid fa-robot" style="color: var(--secondary);"></i> Predictive Insights</h3>
        <p style="font-size: 0.875rem; color: var(--text-muted);">
            Based on current complaint density, <strong>South Ward</strong> is predicted to drop by 4% in the next 48 hours unless resolution speed is increased.
        </p>
    </div>
    <div class="stat-card">
        <h3 style="font-size: 1rem; margin-bottom: 1rem;"><i class="fa-solid fa-chart-line" style="color: var(--accent);"></i> Optimization Recommendation</h3>
        <p style="font-size: 0.875rem; color: var(--text-muted);">
            Reassigning 2 workers from North Ward to South Ward would normalize health scores within 24 hours.
        </p>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>
