<%@ include file="../common/taglibs.jsp" %>
<c:set var="title" value="${title}" />
<%@ include file="../common/header.jsp" %>

<div style="margin-bottom: 3rem;">
    <h1 style="font-size: 2.5rem; font-weight: 800; color: var(--primary); letter-spacing: -0.04em;">Field Work Schedule</h1>
    <p style="color: var(--text-muted); font-size: 1.125rem;">Assigned maintenance tasks for today.</p>
</div>

<c:if test="${not empty param.success}">
    <div class="success-msg" style="margin-bottom: 2rem;">
        <i class="fa-solid fa-circle-check"></i> ${param.success}
    </div>
</c:if>

<!-- Map Section -->
<div style="margin-bottom: 2rem; border-radius: 1rem; overflow: hidden; box-shadow: 0 4px 20px rgba(0,0,0,0.1);">
    <div id="taskMap" style="width: 100%; height: 400px;"></div>
</div>

<div class="dashboard-grid">
    <c:forEach var="task" items="${tasks}">
        <div class="stat-card" style="display: flex; flex-direction: column; gap: 1.25rem;">
            <div style="display: flex; justify-content: space-between; align-items: flex-start;">
                <span class="badge" style="background: #eff6ff; color: #1d4ed8;">#CF-${task.id}</span>
                <span class="badge" style="background: ${task.severity == 'CRITICAL' ? '#fee2e2' : '#f1f5f9'}; color: ${task.severity == 'CRITICAL' ? '#ef4444' : 'var(--text-main)'};">
                    ${task.severity}
                </span>
            </div>
            
            <div>
                <h3 style="font-size: 1.125rem; margin-bottom: 0.5rem;">${task.category}</h3>
                <p style="color: var(--text-muted); font-size: 0.875rem; line-height: 1.5;">${task.description}</p>
            </div>

            <div style="background: #f8fafc; padding: 1rem; border-radius: 0.5rem; font-size: 0.8125rem;">
                <div style="margin-bottom: 0.5rem;"><i class="fa-solid fa-location-dot" style="color: var(--secondary);"></i> ${task.address}</div>
                <div><i class="fa-solid fa-map" style="color: var(--secondary);"></i> ${task.latitude}, ${task.longitude}</div>
            </div>

            <form action="<c:url value='/worker/complaint/${task.id}/resolve'/>" method="post" style="margin-top: auto;">
                <div class="form-group" style="margin-bottom: 1rem;">
                    <label style="font-size: 0.75rem;">Resolution Photo URL (Proof)</label>
                    <input type="text" name="photo" placeholder="https://image-hosting.com/fix-123.jpg" required>
                </div>
                <button type="submit" class="btn btn-secondary" style="width: 100%;">
                    <i class="fa-solid fa-check-double"></i> Mark as Resolved
                </button>
            </form>
        </div>
    </c:forEach>

    <c:if test="${empty tasks}">
        <div class="stat-card" style="grid-column: 1 / -1; padding: 5rem; text-align: center; color: var(--text-muted);">
            <i class="fa-solid fa-clipboard-check" style="font-size: 4rem; opacity: 0.2; margin-bottom: 1.5rem;"></i>
            <h2 style="color: var(--text-main);">No tasks assigned</h2>
            <p>You're all caught up! New tasks will appear here when assigned by officials.</p>
        </div>
    </c:if>
</div>

<!-- Leaflet.js -->
<link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css"/>
<script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        const taskData = ${mapDataJson};

        // Default center on India
        let defaultLat = 20.5937, defaultLng = 78.9629, defaultZoom = 5;
        if (taskData.length > 0) {
            defaultLat = taskData[0].lat;
            defaultLng = taskData[0].lng;
            defaultZoom = 13;
        }

        const map = L.map('taskMap').setView([defaultLat, defaultLng], defaultZoom);

        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            attribution: '© OpenStreetMap contributors'
        }).addTo(map);

        taskData.forEach(function(task) {
            const marker = L.marker([task.lat, task.lng]).addTo(map);
            marker.bindPopup(
                '<strong>#CF-' + task.id + ' — ' + task.category + '</strong><br>' + task.address
            );
        });
    });
</script>

<%@ include file="../common/footer.jsp" %>
