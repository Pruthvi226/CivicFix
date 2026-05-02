<c:set var="title" value="${title}" />
<%@ include file="../common/header.jsp" %>

<div class="auth-card" style="max-width: 600px; background: #0f172a; color: white;">
    <h1 style="color: #f8fafc;"><i class="fa-solid fa-user-secret" style="color: var(--accent);"></i> Whistleblower Mode</h1>
    <p style="color: #94a3b8;">Report corruption or fake resolutions anonymously. Your identity is not stored. Details are AES-encrypted.</p>

    <c:if test="${not empty error}">
        <div class="error-msg">${error}</div>
    </c:if>

    <form action="<c:url value='/whistleblower/submit'/>" method="post">
        <div class="form-group">
            <label style="color: #cbd5e1;">Detailed Incident Report</label>
            <textarea name="details" rows="6" 
                style="background: #1e293b; border-color: #334155; color: white;"
                placeholder="Provide as much detail as possible. Do NOT include your name or contact info." required></textarea>
        </div>
        
        <div style="background: #1e293b; padding: 1rem; border-radius: 0.5rem; margin-bottom: 1.5rem; font-size: 0.875rem; color: #94a3b8;">
            <i class="fa-solid fa-shield-halved" style="color: var(--success);"></i> 
            <strong>Secure Channel:</strong> Once submitted, you will receive a unique tracking token. Save it carefully; it's the only way to check status.
        </div>

        <button type="submit" class="btn btn-primary" style="background: var(--accent); color: #000;">
            Submit Anonymous Report
        </button>
    </form>
</div>

<%@ include file="../common/footer.jsp" %>
