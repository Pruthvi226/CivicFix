<c:set var="title" value="Register" />
<%@ include file="header.jsp" %>

<div class="auth-card" style="max-width: 500px;">
    <h1>Create Account</h1>
    <p>Join our mission to fix the city</p>

    <c:if test="${not empty error}">
        <div class="error-msg">
            <i class="fa-solid fa-circle-exclamation"></i> ${error}
        </div>
    </c:if>

    <form action="<c:url value='/register'/>" method="post">
        <div class="form-group">
            <label for="username">Username</label>
            <input type="text" id="username" name="username" placeholder="Choose a username" required>
        </div>
        <div class="form-group">
            <label for="email">Email Address</label>
            <input type="email" id="email" name="email" placeholder="email@example.com" required>
        </div>
        <div class="form-group">
            <label for="phone">Phone Number</label>
            <input type="tel" id="phone" name="phone" placeholder="+91 XXXXXXXXXX">
        </div>
        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" placeholder="Create a strong password" required>
        </div>
        <button type="submit" class="btn btn-primary">Create Account</button>
    </form>

    <p style="margin-top: 1.5rem; font-size: 0.875rem;">
        Already have an account? <a href="<c:url value='/login'/>" style="color: var(--primary); font-weight: 600;">Login instead</a>
    </p>
</div>

<%@ include file="footer.jsp" %>
