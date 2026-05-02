<c:set var="title" value="${title}" />
<%@ include file="../common/header.jsp" %>

<div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem;">
    <div>
        <h1>My Civic Reports</h1>
        <p style="color: var(--text-muted);">Track and verify your contributions to the city</p>
    </div>
    <div class="stat-card" style="text-align: right; width: auto;">
        <div style="font-size: 0.875rem; color: var(--text-muted);">My Karma Points</div>
        <div style="font-size: 1.5rem; font-weight: 800; color: var(--primary);">
            <i class="fa-solid fa-star"></i> ${sessionScope.user.karmaPoints}
        </div>
    </div>
</div>

<c:if test="${not empty param.success}">
    <div class="success-msg">
        <i class="fa-solid fa-circle-check"></i> ${param.success}
    </div>
</c:if>

<div class="stat-card" style="padding: 0;">
    <table style="width: 100%; border-collapse: collapse;">
        <thead>
            <tr style="background: #f8fafc; text-align: left; border-bottom: 1px solid #e2e8f0;">
                <th style="padding: 1rem;">ID</th>
                <th style="padding: 1rem;">Category</th>
                <th style="padding: 1rem;">Description</th>
                <th style="padding: 1rem;">Status</th>
                <th style="padding: 1rem;">Reported</th>
                <th style="padding: 1rem;">Action</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="comp" items="${complaints}">
                <tr style="border-bottom: 1px solid #f1f5f9;">
                    <td style="padding: 1rem; font-weight: 600;">#CF-${comp.id}</td>
                    <td style="padding: 1rem;">
                        <span class="badge" style="background: #f1f5f9; color: var(--text-main);">${comp.category}</span>
                    </td>
                    <td style="padding: 1rem; max-width: 300px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
                        ${comp.description}
                    </td>
                    <td style="padding: 1rem;">
                        <c:choose>
                            <c:when test="${comp.status == 'OPEN'}">
                                <span class="badge" style="background: #fef9c3; color: #a16207;">Open</span>
                            </c:when>
                            <c:when test="${comp.status == 'ASSIGNED'}">
                                <span class="badge" style="background: #e0f2fe; color: #0369a1;">Assigned</span>
                            </c:when>
                            <c:when test="${comp.status == 'RESOLVED'}">
                                <span class="badge" style="background: #dcfce7; color: #15803d;">Resolved</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge">${comp.status}</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td style="padding: 1rem; color: var(--text-muted); font-size: 0.875rem;">
                        ${comp.reportedAt}
                    </td>
                    <td style="padding: 1rem;">
                        <c:if test="${comp.status == 'RESOLVED'}">
                            <a href="<c:url value='/citizen/complaint/${comp.id}/verify'/>" class="btn btn-primary" style="padding: 0.25rem 0.75rem; width: auto; font-size: 0.75rem;">Verify</a>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty complaints}">
                <tr>
                    <td colspan="6" style="padding: 4rem; text-align: center; color: var(--text-muted);">
                        <i class="fa-regular fa-folder-open" style="font-size: 3rem; display: block; margin-bottom: 1rem;"></i>
                        No complaints reported yet.
                    </td>
                </tr>
            </c:if>
        </tbody>
    </table>
</div>

<%@ include file="../common/footer.jsp" %>
