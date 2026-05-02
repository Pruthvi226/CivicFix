<%@ include file="../common/taglibs.jsp" %>
<c:set var="title" value="${title}" />
<%@ include file="../common/header.jsp" %>

<div style="max-width: 600px; margin: 0 auto; padding: 2rem 0;">
    <div style="text-align: center; margin-bottom: 3rem;">
        <h1 style="font-size: 2.5rem; font-weight: 800; color: var(--primary); letter-spacing: -0.04em;">Verify Resolution</h1>
        <p style="color: var(--text-muted);">Please confirm if the issue has been fixed to your satisfaction.</p>
    </div>

    <div class="stat-card" style="margin-bottom: 2rem;">
        <div style="display: flex; justify-content: space-between; margin-bottom: 1.5rem;">
            <span class="badge" style="background: #f1f5f9; color: var(--text-main);">#CF-${complaint.id}</span>
            <span class="badge" style="background: #f0fdf4; color: #166534;">Resolved</span>
        </div>

        <h3 style="margin-bottom: 0.5rem;">${complaint.category}</h3>
        <p style="color: var(--text-muted); font-size: 0.9375rem; line-height: 1.6; margin-bottom: 1.5rem;">
            ${complaint.description}
        </p>

        <div style="border-top: 1px solid var(--border); padding-top: 1.5rem;">
            <div style="font-weight: 700; font-size: 0.875rem; margin-bottom: 1rem;">Resolution Proof</div>
            <img src="${complaint.resolutionPhotoUrl}" alt="Resolution Proof" style="width: 100%; border-radius: 0.5rem; border: 1px solid var(--border); margin-bottom: 1rem; max-height: 300px; object-fit: cover;">
            <div style="font-size: 0.8125rem; color: var(--text-muted);">
                Resolved by <strong>${complaint.assignedWorker.username}</strong> on ${complaint.resolvedAt}
            </div>
        </div>
    </div>

    <form action="<c:url value='/citizen/complaint/${complaint.id}/verify'/>" method="post" id="verifyForm">
        <div class="stat-card">
            <h3 style="font-size: 1.125rem; margin-bottom: 1.5rem;">Is the issue fixed?</h3>
            
            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem; margin-bottom: 1.5rem;">
                <label style="cursor: pointer;">
                    <input type="radio" name="accepted" value="true" checked style="display: none;" onchange="toggleReason(false)">
                    <div id="btn-accept" class="btn" style="width: 100%; background: #f0fdf4; color: #166534; border: 1px solid #bbf7d0;">
                        <i class="fa-solid fa-check"></i> Yes, fixed
                    </div>
                </label>
                <label style="cursor: pointer;">
                    <input type="radio" name="accepted" value="false" style="display: none;" onchange="toggleReason(true)">
                    <div id="btn-reject" class="btn btn-outline" style="width: 100%;">
                        <i class="fa-solid fa-xmark"></i> No, keep open
                    </div>
                </label>
            </div>

            <div id="reason-box" style="display: none;">
                <div class="form-group">
                    <label for="reason">Why are you rejecting the resolution?</label>
                    <textarea id="reason" name="reason" rows="3" placeholder="Describe what's still pending..."></textarea>
                </div>
            </div>

            <button type="submit" class="btn btn-primary" style="width: 100%; padding: 1rem;">
                Submit Verification
            </button>
        </div>
    </form>
</div>

<script>
function toggleReason(show) {
    const box = document.getElementById('reason-box');
    const accept = document.getElementById('btn-accept');
    const reject = document.getElementById('btn-reject');
    
    if (show) {
        box.style.display = 'block';
        reject.style.background = '#fef2f2';
        reject.style.color = '#991b1b';
        reject.style.borderColor = '#fecaca';
        accept.style.background = 'white';
        accept.style.color = 'var(--text-main)';
        accept.style.borderColor = 'var(--border)';
    } else {
        box.style.display = 'none';
        accept.style.background = '#f0fdf4';
        accept.style.color = '#166534';
        accept.style.borderColor = '#bbf7d0';
        reject.style.background = 'white';
        reject.style.color = 'var(--text-main)';
        reject.style.borderColor = 'var(--border)';
    }
}
</script>

<%@ include file="../common/footer.jsp" %>
