<%@ include file="taglibs.jsp" %>
<c:set var="title" value="Join CivicFix+" />
<%@ include file="header.jsp" %>

<div class="auth-card" style="max-width: 500px; border: 1px solid var(--border); box-shadow: var(--shadow-lg);">
    <div style="text-align: center; margin-bottom: 2rem;">
        <h1 style="font-size: 1.5rem; font-weight: 800; color: var(--primary);">Join the Mission</h1>
        <p style="font-size: 0.875rem; color: var(--text-muted);">Create your account to start improving your neighborhood</p>
    </div>

    <c:if test="${not empty error}">
        <div class="error-msg"><i class="fa-solid fa-circle-exclamation"></i> ${error}</div>
    </c:if>

    <form action="<c:url value='/register'/>" method="post">
        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem;">
            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" placeholder="citizen_zero" required>
            </div>
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" placeholder="you@example.com" required>
            </div>
        </div>
        <div class="form-group">
            <label for="phone">Phone Number</label>
            <input type="tel" id="phone" name="phone" placeholder="+91 XXXXXXXXXX">
        </div>
        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" placeholder="Min. 8 characters" required>
        </div>
        <div class="form-group">
            <label for="role">My Role</label>
            <select id="role" name="role" required>
                <option value="CITIZEN">Citizen (Report & Verify)</option>
                <option value="WORKER">Field Worker (Fix & Resolve)</option>
                <option value="OFFICIAL">City Official (Manage & Assign)</option>
            </select>
        </div>
        <button type="submit" class="btn btn-primary" style="width: 100%; padding: 0.875rem;">
            Create Account
        </button>
    </form>
    
    <div style="text-align: center; margin-top: 2rem; padding-top: 1.5rem; border-top: 1px solid var(--border);">
        <p style="font-size: 0.875rem;">Already a member? <a href="<c:url value='/login'/>" style="color: var(--secondary); font-weight: 600; text-decoration: none;">Sign In</a></p>
    </div>
</div>

<%@ include file="footer.jsp" %>
