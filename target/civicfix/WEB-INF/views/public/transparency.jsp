<%@ include file="../common/taglibs.jsp" %>
<c:set var="title" value="${title}" />
<%@ include file="../common/header.jsp" %>

<div style="margin-bottom: 3rem;">
    <h1 style="font-size: 2.5rem; font-weight: 800; color: var(--primary); letter-spacing: -0.04em;">Transparency Portal</h1>
    <p style="color: var(--text-muted); font-size: 1.125rem;">Real-time data on city infrastructure and resolution efficiency.</p>
</div>

<div class="dashboard-grid" style="margin-bottom: 3rem;">
    <div class="stat-card" style="text-align: center;">
        <div style="font-size: 0.875rem; font-weight: 700; color: var(--text-muted); text-transform: uppercase;">Total Reports</div>
        <div style="font-size: 2.5rem; font-weight: 800; color: var(--primary);">${totalComplaints}</div>
    </div>
    <div class="stat-card" style="text-align: center;">
        <div style="font-size: 0.875rem; font-weight: 700; color: var(--text-muted); text-transform: uppercase;">Resolution Rate</div>
        <div style="font-size: 2.5rem; font-weight: 800; color: var(--secondary);">${resolutionRate}%</div>
    </div>
    <div class="stat-card" style="text-align: center;">
        <div style="font-size: 0.875rem; font-weight: 700; color: var(--text-muted); text-transform: uppercase;">Open Issues</div>
        <div style="font-size: 2.5rem; font-weight: 800; color: var(--accent);">${openComplaints}</div>
    </div>
</div>

<div class="dashboard-grid" style="grid-template-columns: repeat(auto-fit, minmax(400px, 1fr)); gap: 2rem;">
    <div class="stat-card">
        <h3 style="margin-bottom: 1.5rem;"><i class="fa-solid fa-chart-pie"></i> Distribution by Status</h3>
        <div style="height: 300px;">
            <canvas id="statusChart"></canvas>
        </div>
    </div>
    <div class="stat-card">
        <h3 style="margin-bottom: 1.5rem;"><i class="fa-solid fa-chart-bar"></i> Distribution by Category</h3>
        <div style="height: 300px;">
            <canvas id="categoryChart"></canvas>
        </div>
    </div>
</div>

<div class="stat-card" style="margin-top: 3rem; background: #f8fafc;">
    <h3 style="margin-bottom: 1rem;"><i class="fa-solid fa-circle-info"></i> About Our Transparency Mission</h3>
    <p style="line-height: 1.6; color: var(--text-main);">
        CivicFix+ believes that trust is built through data. This portal provides an unfiltered view of the issues reported by citizens 
        and the progress made by city workers. All data points are updated in real-time as reports are filed and resolved in the field.
    </p>
</div>

<!-- Data bridge for Chart.js -->
<input type="hidden" id="complaintsData" value='<c:out value="${complaintsJson}" />' />

<!-- Chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        const complaintsJson = document.getElementById('complaintsData').value;
        const rawData = JSON.parse(complaintsJson);
        
        // Process Status Data
        const statusCounts = {};
        rawData.forEach(item => {
            statusCounts[item.status] = (statusCounts[item.status] || 0) + 1;
        });
        
        new Chart(document.getElementById('statusChart'), {
            type: 'doughnut',
            data: {
                labels: Object.keys(statusCounts),
                datasets: [{
                    data: Object.values(statusCounts),
                    backgroundColor: ['#0f172a', '#3b82f6', '#10b981', '#f59e0b', '#ef4444'],
                    borderWidth: 0
                }]
            },
            options: {
                maintainAspectRatio: false,
                plugins: {
                    legend: { position: 'bottom' }
                }
            }
        });

        // Process Category Data
        const categoryCounts = {};
        rawData.forEach(item => {
            categoryCounts[item.category] = (categoryCounts[item.category] || 0) + 1;
        });

        new Chart(document.getElementById('categoryChart'), {
            type: 'bar',
            data: {
                labels: Object.keys(categoryCounts),
                datasets: [{
                    label: 'Complaints',
                    data: Object.values(categoryCounts),
                    backgroundColor: '#3b82f6',
                    borderRadius: 8
                }]
            },
            options: {
                maintainAspectRatio: false,
                plugins: {
                    legend: { display: false }
                },
                scales: {
                    y: { beginAtZero: true, grid: { display: false } },
                    x: { grid: { display: false } }
                }
            }
        });
    });
</script>

<%@ include file="../common/footer.jsp" %>
