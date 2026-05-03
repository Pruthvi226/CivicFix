<%@ include file="../common/taglibs.jsp" %>
<%@ include file="../common/header.jsp" %>

<div class="container" style="padding-top: 4rem;">
    <div style="margin-bottom: 3rem;">
        <h1 style="font-size: 2.5rem; font-weight: 800; letter-spacing: -0.04em;">Your Resolution History</h1>
        <p style="color: var(--text-muted);">A record of all tasks you've completed for the city.</p>
    </div>

    <div class="glass-card">
        <div class="table-container">
            <table class="data-table">
                <thead>
                    <tr>
                        <th>Issue ID</th>
                        <th>Category</th>
                        <th>Description</th>
                        <th>Resolved At</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="job" items="${history}">
                        <tr>
                            <td style="font-family: monospace; font-weight: 700;">#CF-${job.id}</td>
                            <td><span class="badge badge-${job.category.toString().toLowerCase()}">${job.category}</span></td>
                            <td>${job.description}</td>
                            <td><fmt:formatDate value="${job.resolvedAt}" pattern="dd MMM, yyyy HH:mm"/></td>
                            <td>
                                <span class="status-pill status-${job.status.toString().toLowerCase()}">
                                    <i class="fas fa-check-circle"></i> ${job.status}
                                </span>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty history}">
                        <tr>
                            <td colspan="5" style="padding: 4rem; text-align: center; color: var(--text-muted);">
                                <i class="fas fa-tools" style="font-size: 3rem; margin-bottom: 1rem; display: block; opacity: 0.2;"></i>
                                No completed tasks found yet. Time to hit the field!
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>

    <div style="margin-top: 2rem;">
        <a href="<c:url value='/worker/schedule'/>" class="btn btn-secondary">
            <i class="fas fa-arrow-left"></i> Back to Active Schedule
        </a>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>
