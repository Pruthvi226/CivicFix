<%@ include file="../common/taglibs.jsp" %>
<%@ include file="../common/header.jsp" %>

<div class="container" style="padding-top: 4rem;">
    <div style="margin-bottom: 3rem; display: flex; justify-content: space-between; align-items: center;">
        <div>
            <h1 style="font-size: 2.5rem; font-weight: 800; letter-spacing: -0.04em;">City Performance Audit</h1>
            <p style="color: var(--text-muted); font-size: 1.125rem;">Comprehensive analysis of urban resilience and operational efficiency.</p>
        </div>
        <a href="<c:url value='/official/dashboard'/>" class="btn btn-secondary">
            <i class="fa-solid fa-arrow-left"></i> Back to Dashboard
        </a>
    </div>

    <!-- Summary Widgets -->
    <div class="dashboard-grid" style="margin-bottom: 3rem;">
        <div class="stat-card" style="border-left: 4px solid var(--primary);">
            <div class="stat-label">System-Wide Complaints</div>
            <div class="stat-value" style="font-size: 2.5rem;">${totalComplaints}</div>
            <div style="font-size: 0.875rem; color: #16a34a; font-weight: 600;">+12% from last month</div>
        </div>
        <div class="stat-card" style="border-left: 4px solid var(--secondary);">
            <div class="stat-label">Resolution Efficiency</div>
            <div class="stat-value" style="font-size: 2.5rem;">
                <c:choose>
                    <c:when test="${totalComplaints > 0}">${(resolvedCount * 100 / totalComplaints)}%</c:when>
                    <c:otherwise>0%</c:otherwise>
                </c:choose>
            </div>
            <div style="font-size: 0.875rem; color: var(--text-muted);">Verified resolutions</div>
        </div>
        <div class="stat-card" style="border-left: 4px solid var(--accent);">
            <div class="stat-label">Active Jurisdictions</div>
            <div class="stat-value" style="font-size: 2.5rem;">${wards.size()}</div>
            <div style="font-size: 0.875rem; color: var(--text-muted);">Wards under oversight</div>
        </div>
    </div>

    <div class="dashboard-grid">
        <!-- Ward Health Distribution -->
        <section class="glass-card" style="padding: 2rem;">
            <h3 style="margin-bottom: 2rem; font-weight: 800;"><i class="fa-solid fa-chart-pie" style="color: var(--primary);"></i> Ward Health Distribution</h3>
            <canvas id="wardHealthChart" height="250"></canvas>
        </section>

        <!-- Resolution Speed (Mock data for demo purposes) -->
        <section class="glass-card" style="padding: 2rem;">
            <h3 style="margin-bottom: 2rem; font-weight: 800;"><i class="fa-solid fa-bolt" style="color: var(--accent);"></i> Avg. Resolution Speed (Days)</h3>
            <canvas id="resolutionSpeedChart" height="250"></canvas>
        </section>
    </div>

    <!-- Data Table Section -->
    <section class="glass-card" style="margin-top: 3rem; padding: 2rem;">
        <h3 style="margin-bottom: 2rem; font-weight: 800;"><i class="fa-solid fa-microchip" style="color: var(--secondary);"></i> Granular Ward Performance</h3>
        <div class="table-container">
            <table class="data-table">
                <thead>
                    <tr>
                        <th>Ward Name</th>
                        <th>Current Score</th>
                        <th>Operational Status</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="ward" items="${wards}">
                        <tr>
                            <td style="font-weight: 700;">${ward.name}</td>
                            <td>
                                <div style="display: flex; align-items: center; gap: 0.5rem;">
                                    <div class="progress-container" style="flex: 1; height: 0.5rem; width: 100px;">
                                        <div class="progress-bar ${ward.healthScore > 75 ? 'bg-secondary' : 'bg-accent'}" data-width="${ward.healthScore}"></div>
                                    </div>
                                    <span style="font-weight: 800;">${ward.healthScore}%</span>
                                </div>
                            </td>
                            <td>
                                <span class="badge" style="background: #f0fdf4; color: #166534;">OPTIMIZED</span>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </section>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Ward Health Chart
        const wardLabels = [<c:forEach var="w" items="${wards}" varStatus="s">'${w.name}'${!s.last ? ',' : ''}</c:forEach>];
        const wardScores = [<c:forEach var="w" items="${wards}" varStatus="s">${w.healthScore}${!s.last ? ',' : ''}</c:forEach>];

        new Chart(document.getElementById('wardHealthChart'), {
            type: 'bar',
            data: {
                labels: wardLabels,
                datasets: [{
                    label: 'Health Score %',
                    data: wardScores,
                    backgroundColor: 'rgba(99, 102, 241, 0.6)',
                    borderColor: '#6366f1',
                    borderWidth: 2,
                    borderRadius: 8
                }]
            },
            options: {
                responsive: true,
                plugins: { legend: { display: false } },
                scales: { y: { beginAtZero: true, max: 100 } }
            }
        });

        // Resolution Speed Chart (Randomized for variety in demo)
        new Chart(document.getElementById('resolutionSpeedChart'), {
            type: 'line',
            data: {
                labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
                datasets: [{
                    label: 'Avg. Days to Resolve',
                    data: [4.2, 3.8, 4.5, 3.2, 2.9, 3.1],
                    borderColor: '#f59e0b',
                    tension: 0.4,
                    fill: true,
                    backgroundColor: 'rgba(245, 158, 11, 0.1)'
                }]
            },
            options: {
                responsive: true,
                plugins: { legend: { display: false } }
            }
        });
    });
</script>

<%@ include file="../common/footer.jsp" %>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        document.querySelectorAll('[data-width]').forEach(function(el) {
            el.style.width = el.getAttribute('data-width') + '%';
        });
    });
</script>
