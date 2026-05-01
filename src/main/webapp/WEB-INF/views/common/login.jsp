<c:set var="title" value="Login" />
<%@ include file="header.jsp" %>

<div class="auth-card">
    <h1>Welcome Back</h1>
    <p>Sign in to your CivicFix+ account</p>

    <c:if test="${not empty error}">
        <div class="error-msg">
            <i class="fa-solid fa-circle-exclamation"></i> ${error}
        </div>
    </c:if>

    <c:if test="${not empty param.success}">
        <div class="success-msg">
            <i class="fa-solid fa-circle-check"></i> ${param.success}
        </div>
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
        <button type="submit" class="btn btn-primary">Sign In</button>
    </form>

    <p style="margin-top: 1.5rem; font-size: 0.875rem;">
        Don't have an account? <a href="<c:url value='/register'/>" style="color: var(--primary); font-weight: 600;">Register here</a>
    </p>
</div>

<%@ include file="footer.jsp" %>
