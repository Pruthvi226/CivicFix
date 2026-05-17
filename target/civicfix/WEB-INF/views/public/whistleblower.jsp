<%@ include file="../common/taglibs.jsp" %>
<c:set var="title" value="${title}" />
<%@ include file="../common/header.jsp" %>

<div style="max-width: 700px; margin: 4rem auto;">
    <div class="stat-card" style="background: var(--primary); color: white; border: none; padding: 3rem;">
        <div style="text-align: center; margin-bottom: 2rem;">
            <i class="fa-solid fa-user-secret" style="font-size: 3.5rem; color: var(--accent); margin-bottom: 1.5rem;"></i>
            <h1 style="font-size: 2rem; font-weight: 800; letter-spacing: -0.04em;">Secure Whistleblower Mode</h1>
            <p style="color: #94a3b8; font-size: 1rem; margin-top: 0.5rem;">Protecting the integrity of our city through anonymous reporting.</p>
        </div>

        <c:if test="${not empty error}">
            <div class="error-msg" style="background: rgba(239, 68, 68, 0.1); border-color: rgba(239, 68, 68, 0.2); color: #fca5a5;">
                <i class="fa-solid fa-circle-exclamation"></i> ${error}
            </div>
        </c:if>

        <form action="<c:url value='/whistleblower/submit'/>" method="post">
            <div class="form-group">
                <label style="color: #cbd5e1; font-weight: 600;">Incident Description</label>
                <textarea name="details" rows="6" 
                    style="background: rgba(255,255,255,0.05); border-color: rgba(255,255,255,0.1); color: white; padding: 1rem; font-size: 1rem;"
                    placeholder="Provide specific details about the corruption or fake resolution. Do NOT include identifying information." required></textarea>
            </div>
            
            <div style="background: rgba(255,255,255,0.05); padding: 1.25rem; border-radius: 0.75rem; margin-bottom: 2rem; font-size: 0.875rem; color: #94a3b8; border: 1px dashed rgba(255,255,255,0.1);">
                <i class="fa-solid fa-shield-halved" style="color: var(--secondary); margin-right: 0.5rem;"></i> 
                <strong>Privacy Guaranteed:</strong> Your report is AES-256 encrypted. We do not log IP addresses or browser fingerprints in this mode.
            </div>

            <button type="submit" class="btn" style="width: 100%; background: var(--accent); color: var(--primary); font-weight: 800; padding: 1rem; font-size: 1rem;">
                <i class="fa-solid fa-paper-plane"></i> Submit Encrypted Report
            </button>
        </form>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>
