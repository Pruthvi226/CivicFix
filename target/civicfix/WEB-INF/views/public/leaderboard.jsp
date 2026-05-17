<%@ include file="../common/taglibs.jsp" %>
<c:set var="title" value="${title}" />
<%@ include file="../common/header.jsp" %>

<div style="padding: 3rem 0; text-align: center; border-bottom: 1px solid var(--border); margin-bottom: 4rem;">
    <h1 style="font-size: 2.5rem; font-weight: 800; color: var(--primary); letter-spacing: -0.04em;">City Pulse Dashboard</h1>
    <p style="color: var(--text-muted); font-size: 1.125rem;">Real-time transparency on ward performance and community contributions.</p>
</div>

<div class="dashboard-grid" style="gap: 4rem;">
    <div>
        <div style="display: flex; align-items: center; justify-content: space-between; margin-bottom: 2rem;">
            <h2 style="font-size: 1.5rem; font-weight: 800;"><i class="fa-solid fa-chart-line" style="color: var(--secondary);"></i> Ward Health Index</h2>
            <span style="font-size: 0.875rem; color: var(--text-muted);">Updated 5m ago</span>
        </div>
        
        <div style="display: flex; flex-direction: column; gap: 2rem;">
            <c:forEach var="ward" items="${wards}">
                <div>
                    <div style="display: flex; justify-content: space-between; margin-bottom: 0.5rem; align-items: flex-end;">
                        <a href="<c:url value='/ward/${ward.id}'/>" style="font-weight: 700; font-size: 1.125rem; color: inherit; text-decoration: none; border-bottom: 2px solid transparent; transition: border-color 0.2s;" onmouseover="this.style.borderColor='var(--secondary)'" onmouseout="this.style.borderColor='transparent'">
                            ${ward.name}
                        </a>
                        <span class="text-800 ${ward.healthScore >= 80 ? 'text-secondary' : (ward.healthScore >= 50 ? 'text-accent' : 'text-error')}">
                            ${ward.healthScore}%
                        </span>
                    </div>
                    <div class="progress-container" style="height: 0.75rem;">
                        <div class="progress-bar ${ward.healthScore >= 80 ? 'bg-secondary' : (ward.healthScore >= 50 ? 'bg-accent' : 'bg-error')}" 
                             data-width="${ward.healthScore}">
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

    <div>
        <div style="display: flex; align-items: center; justify-content: space-between; margin-bottom: 2rem;">
            <h2 style="font-size: 1.5rem; font-weight: 800;"><i class="fa-solid fa-crown" style="color: var(--accent);"></i> Community Heroes</h2>
            <a href="#" style="font-size: 0.875rem; color: var(--secondary); font-weight: 600; text-decoration: none;">View All</a>
        </div>

        <div class="stat-card" style="padding: 0; overflow: hidden;">
            <table>
                <thead>
                    <tr>
                        <th>Rank</th>
                        <th>Citizen</th>
                        <th>Ward</th>
                        <th style="text-align: right;">Karma</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="cit" items="${topCitizens}" varStatus="status">
                        <tr>
                            <td style="font-weight: 800; color: var(--text-muted);">#${status.count}</td>
                            <td>
                                <div style="display: flex; align-items: center; gap: 0.75rem;">
                                    <div style="width: 2rem; height: 2rem; background: #f1f5f9; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: 800; font-size: 0.75rem; color: var(--primary);">
                                        ${cit.username.substring(0,1).toUpperCase()}
                                    </div>
                                    <span style="font-weight: 600;">${cit.username}</span>
                                </div>
                            </td>
                            <td style="font-size: 0.875rem; color: var(--text-muted);">${cit.ward.name}</td>
                            <td style="text-align: right; font-weight: 800; color: var(--primary);">${cit.karmaPoints}</td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty topCitizens}">
                        <tr>
                            <td colspan="4" style="padding: 4rem; text-align: center; color: var(--text-muted);">
                                No heroes yet. Be the first to report!
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        document.querySelectorAll('[data-width]').forEach(function(el) {
            el.style.width = el.getAttribute('data-width') + '%';
        });
    });
</script>
