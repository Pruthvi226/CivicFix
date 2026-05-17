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
        <a href="<c:url value='/official/audit'/>" class="btn btn-outline" style="padding: 0.75rem 1.5rem; border-color: var(--primary); color: var(--primary);">
            <i class="fa-solid fa-gauge-high"></i> City Audit
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

<!-- Simple Search Section -->
<div class="glass-card" style="margin-bottom: 2rem; padding: 1.5rem;">
    <form action="<c:url value='/official/search'/>" method="get" style="display: flex; gap: 1rem;">
        <div style="flex: 1; position: relative;">
            <i class="fa-solid fa-magnifying-glass" style="position: absolute; left: 1rem; top: 50%; transform: translateY(-50%); color: var(--text-muted);"></i>
            <input type="text" name="query" placeholder="Search by ID, Description or Address..." 
                   style="width: 100%; padding: 0.75rem 1rem 0.75rem 2.5rem; border-radius: 0.75rem; border: 1px solid var(--border);"
                   value="${param.query}">
        </div>
        <button type="submit" class="btn btn-primary" style="padding: 0.75rem 2rem;">Search</button>
        <button type="button" class="btn btn-outline" style="padding: 0.75rem 2rem;" onclick="document.getElementById('advancedSearch').style.display='block'">Advanced</button>
        <c:if test="${not empty param.query || not empty param.status}">
            <a href="<c:url value='/official/dashboard'/>" class="btn btn-outline" style="padding: 0.75rem 1rem;">Clear</a>
        </c:if>
    </form>
</div>

<!-- Advanced Search Section (Hidden by default) -->
<div id="advancedSearch" class="glass-card" style="margin-bottom: 2rem; padding: 1.5rem; display: none; background-color: #f8fafc; border: 1px solid var(--border);">
    <h3 style="margin-top: 0; color: var(--primary);">Advanced Search (Criteria API)</h3>
    <form action="<c:url value='/official/advancedSearch'/>" method="get" style="display: grid; grid-template-columns: 1fr 1fr 1fr 1fr auto; gap: 1rem; align-items: end;">
        <div>
            <label style="font-size: 0.75rem; font-weight: 700; color: var(--text-muted);">Status</label>
            <select name="status" style="width: 100%; padding: 0.75rem; border-radius: 0.5rem; border: 1px solid var(--border);">
                <option value="">Any</option>
                <option value="OPEN">Open</option>
                <option value="ASSIGNED">Assigned</option>
                <option value="RESOLVED">Resolved</option>
                <option value="VERIFIED">Verified</option>
            </select>
        </div>
        <div>
            <label style="font-size: 0.75rem; font-weight: 700; color: var(--text-muted);">Category</label>
            <select name="category" style="width: 100%; padding: 0.75rem; border-radius: 0.5rem; border: 1px solid var(--border);">
                <option value="">Any</option>
                <option value="POTHOLE">Pothole</option>
                <option value="STREETLIGHT">Street Light</option>
                <option value="DRAIN">Drain / Sewage</option>
                <option value="GARBAGE">Garbage</option>
                <option value="OTHER">Other</option>
            </select>
        </div>
        <div>
            <label style="font-size: 0.75rem; font-weight: 700; color: var(--text-muted);">Ward</label>
            <select name="wardId" style="width: 100%; padding: 0.75rem; border-radius: 0.5rem; border: 1px solid var(--border);">
                <option value="0">Any</option>
                <c:forEach var="w" items="${wards}">
                    <option value="${w.id}">${w.name}</option>
                </c:forEach>
            </select>
        </div>
        <div>
            <label style="font-size: 0.75rem; font-weight: 700; color: var(--text-muted);">Severity</label>
            <select name="severity" style="width: 100%; padding: 0.75rem; border-radius: 0.5rem; border: 1px solid var(--border);">
                <option value="">Any</option>
                <option value="LOW">Low</option>
                <option value="MEDIUM">Medium</option>
                <option value="HIGH">High</option>
                <option value="CRITICAL">Critical</option>
            </select>
        </div>
        <div style="display: flex; gap: 0.5rem;">
            <button type="submit" class="btn btn-secondary" style="padding: 0.75rem 1.5rem;">Filter</button>
            <button type="button" class="btn btn-outline" style="padding: 0.75rem 1rem;" onclick="document.getElementById('advancedSearch').style.display='none'">Close</button>
        </div>
    </form>
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
                <th>Priority</th>
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
                    <td>${not empty comp.ward ? comp.ward.name : 'Unknown'}</td>
                    <td>
                        <c:if test="${not empty comp.severity}">
                            <span class="badge badge-${fn:toLowerCase(comp.severity.toString())}">
                                ${comp.severity}
                            </span>
                        </c:if>
                        <c:if test="${empty comp.severity}">
                            <span class="badge" style="background: #e2e8f0; color: #475569;">UNKNOWN</span>
                        </c:if>
                    </td>
                    <td>
                        <div style="display: flex; align-items: center; gap: 0.5rem;">
                            <div class="progress-container" style="flex: 1; height: 0.5rem; width: 60px;">
                                <div class="progress-bar ${comp.priorityScore > 75 ? 'bg-error' : (comp.priorityScore > 40 ? 'bg-accent' : 'bg-secondary')}" data-width="${comp.priorityScore}"></div>
                            </div>
                             <span class="text-800 ${comp.priorityScore > 75 ? 'text-error' : ''}" style="font-size: 0.75rem;">
                                ${comp.priorityScore}
                            </span>
                        </div>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${not empty comp.assignedWorker}">
                                <div style="display: flex; align-items: center; gap: 0.5rem;">
                                    <div style="width: 1.5rem; height: 1.5rem; background: #e0f2fe; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 0.625rem; font-weight: 800; color: #0369a1;">
                                        ${fn:toUpperCase(fn:substring(comp.assignedWorker.username, 0, 1))}
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
                                        <c:if test="${not empty w.username}">
                                            <option value="${w.id}">${w.username}</option>
                                        </c:if>
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

<script>
    document.addEventListener("DOMContentLoaded", function() {
        document.querySelectorAll('[data-width]').forEach(function(el) {
            el.style.width = el.getAttribute('data-width') + '%';
        });
    });
</script>
