<c:set var="title" value="${title}" />
<%@ include file="../common/header.jsp" %>

<div style="margin-bottom: 3rem; text-align: center;">
    <h1>City Health & Karma Leaderboard</h1>
    <p style="color: var(--text-muted);">Real-time transparency on ward performance and top contributors</p>
</div>

<div class="dashboard-grid">
    <div>
        <h2 style="margin-bottom: 1.5rem;"><i class="fa-solid fa-medal" style="color: var(--accent);"></i> Top Ward Scores</h2>
        <div class="stat-card" style="padding: 0;">
            <table style="width: 100%; border-collapse: collapse;">
                <c:forEach var="ward" items="${wards}" varStatus="status">
                    <tr style="border-bottom: 1px solid #f1f5f9;">
                        <td style="padding: 1rem; width: 50px; font-weight: 800; color: var(--text-muted);">#${status.count}</td>
                        <td style="padding: 1rem; font-weight: 600;">${ward.name}</td>
                        <td style="padding: 1rem; text-align: right;">
                            <span class="badge" style="font-size: 1rem; padding: 0.5rem 1rem; 
                                background: ${ward.healthScore >= 80 ? '#dcfce7' : (ward.healthScore >= 50 ? '#fef9c3' : '#fee2e2')};
                                color: ${ward.healthScore >= 80 ? '#15803d' : (ward.healthScore >= 50 ? '#a16207' : '#b91c1c')};">
                                ${ward.healthScore} / 100
                            </span>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>

    <div>
        <h2 style="margin-bottom: 1.5rem;"><i class="fa-solid fa-users" style="color: var(--primary);"></i> Ward Heroes</h2>
        <div class="stat-card" style="padding: 0;">
            <table style="width: 100%; border-collapse: collapse;">
                <c:forEach var="cit" items="${topCitizens}" varStatus="status">
                    <tr style="border-bottom: 1px solid #f1f5f9;">
                        <td style="padding: 1rem; width: 50px; font-weight: 800; color: var(--text-muted);">#${status.count}</td>
                        <td style="padding: 1rem;">
                            <div style="font-weight: 600;">${cit.username}</div>
                            <div style="font-size: 0.75rem; color: var(--text-muted);">${cit.ward.name}</div>
                        </td>
                        <td style="padding: 1rem; text-align: right; font-weight: 800; color: var(--primary);">
                            ${cit.karmaPoints} pts
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty topCitizens}">
                    <tr>
                        <td style="padding: 4rem; text-align: center; color: var(--text-muted);">
                            No heroes yet. Start reporting to climb!
                        </td>
                    </tr>
                </c:if>
            </table>
        </div>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>
