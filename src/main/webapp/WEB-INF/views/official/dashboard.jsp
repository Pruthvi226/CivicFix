<%@ include file="../common/taglibs.jsp" %>
<c:set var="title" value="${title}" />
<%@ include file="../common/header.jsp" %>

<div style="margin-bottom: 3rem; display: flex; justify-content: space-between; align-items: flex-end; padding-bottom: 2rem; border-bottom: 1px solid var(--border);">
    <div>
        <h1 style="font-size: 2.5rem; font-weight: 800; color: var(--primary); letter-spacing: -0.04em;">Command Center</h1>
        <p style="color: var(--text-muted); font-size: 1.125rem;">City-wide infrastructure oversight and task management.</p>
    </div>
    <div style="display: flex; gap: 1rem; align-items: center;">
        <a href="<c:url value='/official/heatmap'/>" class="btn btn-outline" style="padding: 0.75rem 1.5rem; border-color: var(--secondary); color: var(--secondary);">
            <i class="fa-solid fa-fire-flame-curved"></i> AI Heatmap
        </a>
        <a href="<c:url value='/official/export'/>" class="btn btn-outline" style="padding: 0.75rem 1.5rem; border-color: #16a34a; color: #16a34a;">
            <i class="fa-solid fa-file-csv"></i> Export CSV
        </a>
        <div class="stat-card" style="padding: 0.75rem 1.5rem; border-color: var(--secondary);">
            <div style="font-size: 0.75rem; font-weight: 700; color: var(--text-muted);">Active Workers</div>
            <div style="font-size: 1.25rem; font-weight: 800; color: var(--secondary);">${workers.size()}</div>
        </div>
        <div class="stat-card" style="padding: 0.75rem 1.5rem; border-color: var(--accent);">
            <div style="font-size: 0.75rem; font-weight: 700; color: var(--text-muted);">Pending Issues</div>
            <div style="font-size: 1.25rem; font-weight: 800; color: var(--accent);">
                ${pendingCount}
            </div>
        </div>
    </div>
</div>

<c:if test="${not empty param.success}">
    <div class="success-msg" style="margin-bottom: 2rem;">
        <i class="fa-solid fa-circle-check"></i> ${param.success}
    </div>
</c:if>

<div class="stat-card" style="padding: 0; overflow: hidden;">
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Issue</th>
                <th>Ward</th>
                <th>Severity</th>
                <th>Assigned To</th>
                <th style="text-align: right;">Action</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="comp" items="${complaints}">
                <tr>
                    <td style="font-weight: 700; color: var(--primary);">#CF-${comp.id}</td>
                    <td>
                        <div style="font-weight: 600;">${comp.category}</div>
                        <div style="font-size: 0.75rem; color: var(--text-muted); max-width: 200px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
                            ${comp.description}
                        </div>
                    </td>
                    <td>${comp.ward.name}</td>
                    <td>
                        <span class="badge" style="
                            background: ${comp.severity == 'CRITICAL' ? '#fee2e2' : (comp.severity == 'HIGH' ? '#ffedd5' : '#f1f5f9')};
                            color: ${comp.severity == 'CRITICAL' ? '#ef4444' : (comp.severity == 'HIGH' ? '#f59e0b' : 'var(--text-main)')};">
                            ${comp.severity}
                        </span>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${not empty comp.assignedWorker}">
                                <div style="display: flex; align-items: center; gap: 0.5rem;">
                                    <div style="width: 1.5rem; height: 1.5rem; background: #e0f2fe; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 0.625rem; font-weight: 800; color: #0369a1;">
                                        ${comp.assignedWorker.username.substring(0,1).toUpperCase()}
                                    </div>
                                    <span style="font-size: 0.875rem;">${comp.assignedWorker.username}</span>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <span style="font-size: 0.875rem; color: var(--text-muted); font-style: italic;">Unassigned</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td style="text-align: right;">
                        <c:if test="${comp.status == 'OPEN' || comp.status == 'REOPENED'}">
                            <form action="<c:url value='/official/complaint/${comp.id}/assign'/>" method="post" style="display: flex; gap: 0.5rem; justify-content: flex-end;">
                                <select name="workerId" required style="padding: 0.4rem; font-size: 0.75rem; width: auto; background: #f8fafc;">
                                    <option value="">Select Worker</option>
                                    <c:forEach var="w" items="${workers}">
                                        <option value="${w.id}">${w.username}</option>
                                    </c:forEach>
                                </select>
                                <button type="submit" class="btn btn-secondary" style="padding: 0.4rem 0.8rem; font-size: 0.75rem;">
                                    Assign
                                </button>
                            </form>
                        </c:if>
                        <c:if test="${comp.status != 'OPEN' && comp.status != 'REOPENED'}">
                            <span class="badge" style="background: #f0fdf4; color: #166534;">${comp.status}</span>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<%@ include file="../common/footer.jsp" %>
