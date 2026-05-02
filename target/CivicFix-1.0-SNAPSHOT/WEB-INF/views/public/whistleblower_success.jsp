<c:set var="title" value="Report Submitted" />
<%@ include file="../common/header.jsp" %>

<div class="auth-card" style="text-align: center; max-width: 500px;">
    <i class="fa-solid fa-circle-check" style="font-size: 4rem; color: var(--success); margin-bottom: 1.5rem;"></i>
    <h1>Report Secured</h1>
    <p>Your anonymous report has been encrypted and sent to senior officials.</p>

    <div style="background: #f8fafc; border: 2px dashed var(--primary); padding: 1.5rem; border-radius: 0.5rem; margin: 2rem 0;">
        <div style="font-size: 0.75rem; color: var(--text-muted); text-transform: uppercase; letter-spacing: 0.05em; margin-bottom: 0.5rem;">
            Your Tracking Token (Save This!)
        </div>
        <div style="font-family: monospace; font-size: 1.25rem; font-weight: 800; word-break: break-all; color: var(--text-main);">
            ${token}
        </div>
    </div>

    <p style="font-size: 0.875rem; color: var(--text-muted); margin-bottom: 2rem;">
        Use this token to check status on the home page. We cannot recover this token if lost.
    </p>

    <a href="<c:url value='/'/>" class="btn btn-primary">Return to Home</a>
</div>

<%@ include file="../common/footer.jsp" %>
