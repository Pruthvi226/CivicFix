<c:set var="title" value="${title}" />
<%@ include file="../common/header.jsp" %>

<div style="max-width: 800px; margin: 0 auto;">
    <h1>Report an Infrastructure Issue</h1>
    <p style="color: var(--text-muted); margin-bottom: 2rem;">Help us identify problems. Our AI will automatically classify your report.</p>

    <div class="dashboard-grid">
        <div style="grid-column: span 2;">
            <form action="<c:url value='/citizen/complaint/submit'/>" method="post" id="complaintForm">
                <div class="stat-card">
                    <div class="form-group">
                        <label for="description">Describe the issue in plain language</label>
                        <textarea id="description" name="description" rows="4" 
                            placeholder="e.g. There is a deep pothole near the main market signal causing traffic..." required></textarea>
                        <div id="ai-status" style="font-size: 0.75rem; margin-top: 0.5rem; color: var(--primary); display: none;">
                            <i class="fa-solid fa-robot"></i> AI is analyzing...
                        </div>
                    </div>

                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem;">
                        <div class="form-group">
                            <label for="category">Detected Category</label>
                            <select id="category" name="category" required>
                                <option value="POTHOLE">Pothole</option>
                                <option value="DRAIN">Drain / Sewage</option>
                                <option value="STREETLIGHT">Streetlight</option>
                                <option value="GARBAGE">Garbage</option>
                                <option value="OTHER">Other</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="severity">Estimated Severity</label>
                            <select id="severity" name="severity" required>
                                <option value="LOW">Low</option>
                                <option value="MEDIUM">Medium</option>
                                <option value="HIGH">High</option>
                                <option value="CRITICAL">Critical</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="ward">Ward / Locality</label>
                        <select id="ward" name="ward.id" required>
                            <option value="">Select Ward</option>
                            <c:forEach var="ward" items="${wards}">
                                <option value="${ward.id}">${ward.name}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="form-group">
                        <label>Location (GPS)</label>
                        <div style="display: flex; gap: 1rem;">
                            <input type="text" id="latitude" name="latitude" placeholder="Latitude" readonly required>
                            <input type="text" id="longitude" name="longitude" placeholder="Longitude" readonly required>
                            <button type="button" class="btn" onclick="getLocation()" style="width: auto; background: #f1f5f9; color: var(--text-main);">
                                <i class="fa-solid fa-location-crosshairs"></i> Get Location
                            </button>
                        </div>
                        <p style="font-size: 0.75rem; color: var(--text-muted); margin-top: 0.5rem;">
                            We need your exact location to check for duplicates and alert field workers.
                        </p>
                    </div>

                    <div class="form-group">
                        <label for="address">Full Address / Landmark</label>
                        <input type="text" id="address" name="address" placeholder="e.g. Near HDFC Bank ATM, 5th Cross" required>
                    </div>

                    <input type="hidden" id="estimatedFixTime" name="estimatedFixTime" value="72">

                    <button type="submit" class="btn btn-primary" style="margin-top: 1rem;">
                        <i class="fa-solid fa-paper-plane"></i> Submit Report
                    </button>
                </div>
            </form>
        </div>

        <div>
            <div class="stat-card" style="position: sticky; top: 100px;">
                <h3 style="font-size: 1rem; margin-bottom: 1rem;">Smart Fix AI Insight</h3>
                <div id="ai-insight" style="font-size: 0.875rem; color: var(--text-muted);">
                    Start typing your complaint to see AI classification in real-time.
                </div>
                <div id="duplicate-warning" class="error-msg" style="display: none; margin-top: 1rem; background: #fffbeb; color: #92400e; border-color: #fef3c7;">
                    <i class="fa-solid fa-triangle-exclamation"></i> 
                    <strong>Duplicate Radar:</strong> Similar issues reported nearby. Check before submitting!
                </div>
            </div>
        </div>
    </div>
</div>

<script>
let typingTimer;
const descriptionInput = document.getElementById('description');

descriptionInput.addEventListener('input', () => {
    clearTimeout(typingTimer);
    document.getElementById('ai-status').style.display = 'block';
    typingTimer = setTimeout(classifyComplaint, 800);
});

async function classifyComplaint() {
    const text = descriptionInput.value;
    if (text.length < 10) {
        document.getElementById('ai-status').style.display = 'none';
        return;
    }

    try {
        const response = await fetch('<c:url value="/citizen/api/classify"/>', {
            method: 'POST',
            body: text,
            headers: { 'Content-Type': 'text/plain' }
        });
        const data = await response.json();

        document.getElementById('category').value = data.category;
        document.getElementById('severity').value = data.severity;
        document.getElementById('estimatedFixTime').value = data.estimatedFixTime;
        
        const insight = document.getElementById('ai-insight');
        insight.innerHTML = `
            <div style="margin-top: 1rem; padding: 1rem; background: #f0fdf4; border-radius: 0.5rem; color: #166534;">
                <strong>Detected:</strong> ${data.category}<br>
                <strong>Severity:</strong> ${data.severity}<br>
                <strong>Est. Fix Time:</strong> ${data.estimatedFixTime} hours
            </div>
        `;
    } catch (e) {
        console.error("AI Classification failed", e);
    } finally {
        document.getElementById('ai-status').style.display = 'none';
    }
}

function getLocation() {
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition((pos) => {
            document.getElementById('latitude').value = pos.coords.latitude.toFixed(8);
            document.getElementById('longitude').value = pos.coords.longitude.toFixed(8);
            checkDuplicates(pos.coords.latitude, pos.coords.longitude);
        });
    } else {
        alert("Geolocation is not supported by this browser.");
    }
}

async function checkDuplicates(lat, lon) {
    const category = document.getElementById('category').value;
    if (!category) return;

    try {
        const response = await fetch('<c:url value="/citizen/api/check-duplicates"/>', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ latitude: lat, longitude: lon, category: category })
        });
        const duplicates = await response.json();
        
        const warning = document.getElementById('duplicate-warning');
        if (duplicates.length > 0) {
            warning.style.display = 'block';
            warning.innerHTML = `
                <i class="fa-solid fa-triangle-exclamation"></i> 
                <strong>Duplicate Radar:</strong> ${duplicates.length} similar issues reported within 100m in the last 30 days. 
                <a href="#" style="color: inherit; text-decoration: underline;">View existing reports</a> instead of re-reporting.
            `;
        } else {
            warning.style.display = 'none';
        }
    } catch (e) {
        console.error("Duplicate check failed", e);
    }
}
</script>

<%@ include file="../common/footer.jsp" %>
