<%@ include file="taglibs.jsp" %>
<c:set var="title" value="Sign In" />
<%@ include file="header.jsp" %>

<div class="auth-card" style="border: 1px solid var(--border); box-shadow: var(--shadow-lg);">
    <div style="text-align: center; margin-bottom: 2rem;">
        <i class="fa-solid fa-building-columns" style="font-size: 2.5rem; color: var(--secondary); margin-bottom: 1rem;"></i>
        <h1 style="font-size: 1.5rem; font-weight: 800; color: var(--primary);">Welcome Back</h1>
        <p style="font-size: 0.875rem; color: var(--text-muted);">Sign in to manage your reports and karma</p>
    </div>

    <c:if test="${not empty error}">
        <div class="error-msg"><i class="fa-solid fa-circle-exclamation"></i> ${error}</div>
    </c:if>

    <c:if test="${not empty param.success}">
        <div class="success-msg"><i class="fa-solid fa-circle-check"></i> ${param.success}</div>
    </c:if>

    <form action="<c:url value='/login'/>" method="post">
        <div class="form-group">
            <label for="username">Username</label>
            <input type="text" id="username" name="username" placeholder="Enter your username" required>
        </div>
        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" placeholder="••••••••" required>
        </div>
        <button type="submit" class="btn btn-primary" style="width: 100%; padding: 0.875rem;">
            Continue to Dashboard
        </button>
    </form>
    
    <div style="text-align: center; margin-top: 2rem; padding-top: 1.5rem; border-top: 1px solid var(--border);">
        <p style="font-size: 0.875rem;">New to CivicFix+? <a href="<c:url value='/register'/>" style="color: var(--secondary); font-weight: 600; text-decoration: none;">Join the Community</a></p>
    </div>
</div>

<%@ include file="footer.jsp" %>
