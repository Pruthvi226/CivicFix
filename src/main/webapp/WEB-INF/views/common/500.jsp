<%@ include file="taglibs.jsp" %>
<c:set var="title" value="System Error" />
<%@ include file="header.jsp" %>

<div style="text-align: center; padding: 5rem 2rem;">
    <div style="font-size: 6rem; font-weight: 800; color: var(--error); opacity: 0.2; margin-bottom: -2rem;">500</div>
    <h1 style="font-size: 2.5rem; font-weight: 800; color: var(--primary); margin-bottom: 1rem;">Structural Failure</h1>
    <p style="font-size: 1.125rem; color: var(--text-muted); max-width: 500px; margin: 0 auto 2rem;">Something went wrong on our end. Our digital engineers have been notified.</p>
    <a href="<c:url value='/'/>" class="btn btn-primary" style="padding: 1rem 2rem;">Back to Home</a>
</div>

<%@ include file="footer.jsp" %>
