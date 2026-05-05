<%@ include file="../common/taglibs.jsp" %>
<c:set var="title" value="${title}" />
<%@ include file="../common/header.jsp" %>

<div style="max-width: 1000px; margin: 0 auto; padding: 2rem 0;">
    <div style="margin-bottom: 3rem;">
        <h1 style="font-size: 2.5rem; font-weight: 800; color: var(--primary); letter-spacing: -0.04em;">Report an Infrastructure Issue</h1>
        <p style="color: var(--text-muted); font-size: 1.125rem;">Help us identify problems. Our AI will automatically classify and route your report.</p>
    </div>

    <div style="display: grid; grid-template-columns: 1.5fr 1fr; gap: 3rem; align-items: start;">
        <form action="<c:url value='/citizen/complaint/submit'/>" method="post" id="complaintForm" enctype="multipart/form-data">
            <div class="stat-card" style="display: flex; flex-direction: column; gap: 1.5rem;">
                <div class="form-group" style="margin-bottom: 0;">
                    <label for="description">Describe the issue in plain language</label>
                    <textarea id="description" name="description" rows="5" 
                        style="font-size: 1rem; padding: 1rem;"
                        placeholder="e.g. There is a deep pothole near the main market signal causing traffic..." required></textarea>
                    <div id="ai-status" style="font-size: 0.8125rem; margin-top: 0.75rem; color: var(--secondary); display: none; font-weight: 600;">
                        <i class="fa-solid fa-circle-notch fa-spin"></i> AI is analyzing your description...
                    </div>
                </div>

                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1.5rem;">
                    <div class="form-group" style="margin-bottom: 0;">
                        <label for="category">Detected Category</label>
                        <select id="category" name="category" required style="background: #f8fafc;">
                            <option value="POTHOLE">Pothole</option>
                            <option value="DRAIN">Drain / Sewage</option>
                            <option value="STREETLIGHT">Streetlight</option>
                            <option value="GARBAGE">Garbage</option>
                            <option value="OTHER">Other</option>
                        </select>
                    </div>
                    <div class="form-group" style="margin-bottom: 0;">
                        <label for="severity">Estimated Severity</label>
                        <select id="severity" name="severity" required style="background: #f8fafc;">
                            <option value="LOW">Low Priority</option>
                            <option value="MEDIUM">Medium Priority</option>
                            <option value="HIGH">High Priority</option>
                            <option value="CRITICAL">Critical / Urgent</option>
                        </select>
                    </div>
                </div>

                <div class="form-group" style="margin-bottom: 0;">
                    <label for="ward">Ward / Locality</label>
                    <select id="ward" name="ward.id" required>
                        <option value="">Select Ward</option>
                        <c:forEach var="ward" items="${wards}">
                            <option value="${ward.id}">${ward.name}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group" style="margin-bottom: 0;">
                    <label>GPS Location Verification</label>
                    <div style="display: flex; gap: 1rem;">
                        <input type="text" id="latitude" name="latitude" placeholder="Latitude" required style="background: #f1f5f9;">
                        <input type="text" id="longitude" name="longitude" placeholder="Longitude" required style="background: #f1f5f9;">
                        <button type="button" class="btn btn-outline" onclick="getLocation()" style="white-space: nowrap;">
                            <i class="fa-solid fa-location-crosshairs"></i> Get Current
                        </button>
                    </div>
                    <p style="font-size: 0.75rem; color: var(--text-muted); margin-top: 0.5rem;">
                        <i class="fa-solid fa-circle-info"></i> Accurate GPS helps us check for duplicates nearby.
                    </p>
                </div>

                <div class="form-group" style="margin-bottom: 0;">
                    <label for="address">Full Address / Landmark</label>
                    <input type="text" id="address" name="address" placeholder="e.g. Near HDFC Bank ATM, 5th Cross" required>
                </div>

                <div class="form-group" style="margin-bottom: 0;">
                    <label for="evidenceFile">Upload Evidence (Photo / Document)</label>
                    <input type="file" id="evidenceFile" name="evidenceFile" accept=".jpg,.jpeg,.png,.pdf" style="padding: 0.5rem; border: 1px dashed var(--border); border-radius: 0.5rem; width: 100%;">
                    <p style="font-size: 0.75rem; color: var(--text-muted); margin-top: 0.5rem;">Max file size: 10MB. Formats: JPG, PNG, PDF.</p>
                </div>

                <input type="hidden" id="estimatedFixTime" name="estimatedFixTime" value="72">

                <div style="padding-top: 1rem;">
                    <button type="submit" class="btn btn-primary" style="width: 100%; padding: 1rem; font-size: 1rem;">
                        <i class="fa-solid fa-paper-plane"></i> Submit Smart Report
                    </button>
                </div>
            </div>
        </form>

        <div style="display: flex; flex-direction: column; gap: 2rem;">
            <div class="stat-card" style="background: var(--primary); color: white; border: none;">
                <h3 style="font-size: 1.125rem; margin-bottom: 1rem; display: flex; align-items: center; gap: 0.5rem;">
                    <i class="fa-solid fa-robot" style="color: var(--secondary);"></i>
                    Smart Fix AI Insight
                </h3>
                <div id="ai-insight" style="font-size: 0.875rem; opacity: 0.9; line-height: 1.6;">
                    Our AI models are ready. Start typing your complaint to see real-time classification and fix-time estimates.
                </div>
            </div>

            <div id="duplicate-warning" class="stat-card" style="display: none; border-color: var(--accent); background: #fffbeb;">
                <h3 style="font-size: 1rem; color: #92400e; margin-bottom: 0.5rem;">
                    <i class="fa-solid fa-triangle-exclamation"></i> Duplicate Alert
                </h3>
                <div id="duplicate-content" style="font-size: 0.875rem; color: #92400e; line-height: 1.5;">
                </div>
            </div>

            <div class="stat-card">
                <h3 style="font-size: 1rem; margin-bottom: 1rem;">Why Report?</h3>
                <ul style="padding: 0; list-style: none; display: flex; flex-direction: column; gap: 0.75rem; font-size: 0.875rem; color: var(--text-muted);">
                    <li><i class="fa-solid fa-check" style="color: var(--secondary);"></i> Direct alert to Ward Officials</li>
                    <li><i class="fa-solid fa-check" style="color: var(--secondary);"></i> Earn 10 Karma Points per report</li>
                    <li><i class="fa-solid fa-check" style="color: var(--secondary);"></i> Contribute to Ward Health Score</li>
                </ul>
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
            <div style="margin-top: 1rem; padding: 1.25rem; background: rgba(255,255,255,0.1); border-radius: 0.5rem;">
                <div style="margin-bottom: 0.5rem;"><strong>Detected Issue:</strong> ${data.category}</div>
                <div style="margin-bottom: 0.5rem;"><strong>Priority Level:</strong> ${data.severity}</div>
                <div><strong>Resolution Window:</strong> ${data.estimatedFixTime} hours</div>
            </div>
            <p style="margin-top: 1rem; font-size: 0.75rem;">AI confidence high. You can still manually adjust these if needed.</p>
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
        }, (err) => {
            alert("Error getting location: " + err.message);
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
        const content = document.getElementById('duplicate-content');
        if (duplicates.length > 0) {
            warning.style.display = 'block';
            content.innerHTML = `
                ${duplicates.length} similar issue(s) reported within 100m in the last 30 days. 
                Consider <a href="#" style="color: inherit; font-weight: 700;">upvoting existing reports</a> instead of creating a duplicate.
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
