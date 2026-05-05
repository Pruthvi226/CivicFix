<%@ include file="../common/taglibs.jsp" %>
<c:set var="title" value="${title}" />
<%@ include file="../common/header.jsp" %>

<div style="display: flex; justify-content: space-between; align-items: flex-end; margin-bottom: 3rem; padding-bottom: 2rem; border-bottom: 1px solid var(--border);">
    <div>
        <h1 style="font-size: 2rem; font-weight: 800; color: var(--primary); letter-spacing: -0.04em;">My Civic Reports</h1>
        <p style="color: var(--text-muted);">Track and verify your contributions to the city</p>
    </div>
    <div style="display: flex; gap: 1.5rem; align-items: center;">
        <div style="text-align: right;">
            <div style="font-size: 0.75rem; font-weight: 700; color: var(--text-muted); text-transform: uppercase; letter-spacing: 0.05em;">Karma Balance</div>
            <div style="font-size: 1.75rem; font-weight: 800; color: var(--secondary); margin-bottom: 0.25rem;">
                <i class="fa-solid fa-star-half-stroke"></i> ${sessionScope.user.karmaPoints}
            </div>
            <a href="<c:url value='/citizen/perks'/>" style="font-size: 0.75rem; font-weight: 700; color: var(--accent); text-decoration: none; display: flex; align-items: center; justify-content: flex-end; gap: 0.25rem;">
                <i class="fa-solid fa-cart-shopping"></i> Marketplace
            </a>
            <div style="margin-top: 1rem; display: flex; gap: 0.75rem; justify-content: flex-end;">
                <a href="<c:url value='/citizen/karma-history'/>" class="btn btn-outline" style="font-size: 0.75rem; padding: 0.5rem 1rem;">
                    <i class="fa-solid fa-history"></i> Karma Ledger
                </a>
                <a href="<c:url value='/citizen/complaint/new'/>" class="btn btn-primary" style="font-size: 0.75rem; padding: 0.5rem 1rem;">
                    <i class="fa-solid fa-plus"></i> Report Issue
                </a>
            </div>
        </div>
    </div>
</div>

<c:if test="${not empty param.success}">
    <div class="success-msg" style="margin-bottom: 2rem;">
        <i class="fa-solid fa-circle-check"></i> ${param.success}
    </div>
</c:if>

<!-- Notifications Panel -->
<c:if test="${not empty notifications}">
    <div style="margin-bottom: 2rem; background: linear-gradient(135deg, #eff6ff, #dbeafe); border: 1px solid #bfdbfe; border-radius: 1rem; padding: 1.25rem 1.5rem;">
        <div style="display: flex; align-items: center; gap: 0.75rem; margin-bottom: 1rem;">
            <i class="fa-solid fa-bell" style="color: #1d4ed8; font-size: 1.25rem;"></i>
            <h3 style="font-size: 1rem; font-weight: 700; margin: 0; color: #1e3a8a;">
                You have ${notificationCount} new notification<c:if test="${notificationCount > 1}">s</c:if>
            </h3>
        </div>
        <c:forEach var="notif" items="${notifications}">
            <div style="display: flex; gap: 0.75rem; align-items: flex-start; padding: 0.75rem; background: white; border-radius: 0.5rem; margin-bottom: 0.5rem; border-left: 3px solid #3b82f6;">
                <i class="fa-solid fa-circle-info" style="color: #3b82f6; margin-top: 2px;"></i>
                <span style="font-size: 0.9rem; color: #1e3a8a;">${notif.message}</span>
            </div>
        </c:forEach>
    </div>
</c:if>

<div class="stat-card" style="padding: 0; overflow: hidden;">
    <table>
        <thead>
            <tr>
                <th>Reference</th>
                <th>Issue Type</th>
                <th>Description</th>
                <th>Current Status</th>
                <th>Timeline</th>
                <th>Evidence</th>
                <th style="text-align: right;">Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="comp" items="${complaints}">
                <tr>
                    <td style="font-weight: 700; color: var(--primary);">#CF-${comp.id}</td>
                    <td>
                        <span class="badge" style="background: #f1f5f9; color: var(--text-main);">${comp.category}</span>
                    </td>
                    <td style="max-width: 300px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; color: var(--text-muted);">
                        ${comp.description}
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${comp.status == 'OPEN'}">
                                <span class="badge" style="background: #fffbeb; color: #92400e;">Pending AI</span>
                            </c:when>
                            <c:when test="${comp.status == 'ASSIGNED'}">
                                <span class="badge" style="background: #eff6ff; color: #1d4ed8;">On Route</span>
                            </c:when>
                            <c:when test="${comp.status == 'RESOLVED'}">
                                <span class="badge" style="background: #f0fdf4; color: #166534;">Resolved</span>
                            </c:when>
                            <c:when test="${comp.status == 'VERIFIED'}">
                                <span class="badge" style="background: #fdf2f8; color: #9d174d;">Verified</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge" style="background: #f1f5f9; color: var(--text-muted);">${comp.status}</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td style="color: var(--text-muted); font-size: 0.875rem;">
                        <i class="fa-regular fa-clock"></i> ${comp.reportedAt}
                    </td>
                    <td>
                        <c:if test="${not empty comp.evidenceFilePath}">
                            <a href="<c:url value='/files/evidence/${fn:substringAfter(comp.evidenceFilePath, \"/uploads/\")}'/>" target="_blank" title="View Evidence" style="color: var(--primary);">
                                <i class="fa-solid fa-file-image"></i>
                            </a>
                        </c:if>
                        <c:if test="${not empty comp.resolutionPhotoUrl}">
                            <a href="<c:url value='/files/evidence/${fn:substringAfter(comp.resolutionPhotoUrl, \"/uploads/\")}'/>" target="_blank" title="View Resolution Proof" style="color: #16a34a; margin-left: 0.5rem;">
                                <i class="fa-solid fa-check-circle"></i>
                            </a>
                        </c:if>
                    </td>
                    <td style="text-align: right;">
                        <c:if test="${comp.status == 'RESOLVED'}">
                            <a href="<c:url value='/citizen/complaint/${comp.id}/verify'/>" class="btn btn-secondary" style="padding: 0.4rem 0.8rem; font-size: 0.75rem;">
                                Verify Fix
                            </a>
                        </c:if>
                        <c:if test="${comp.status != 'RESOLVED'}">
                            <button class="btn btn-outline" style="padding: 0.4rem 0.8rem; font-size: 0.75rem; opacity: 0.5; cursor: not-allowed;">
                                Details
                            </button>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty complaints}">
                <tr>
                    <td colspan="7" style="padding: 6rem; text-align: center; color: var(--text-muted);">
                        <i class="fa-regular fa-folder-open" style="font-size: 3.5rem; display: block; margin-bottom: 1.5rem; opacity: 0.3;"></i>
                        <div style="font-weight: 600; font-size: 1.125rem;">No reports found</div>
                        <p style="margin-top: 0.5rem;">Issues you report will appear here.</p>
                    </td>
                </tr>
            </c:if>
        </tbody>
    </table>
</div>

<%@ include file="../common/footer.jsp" %>
