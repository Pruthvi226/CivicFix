<%@ include file="../common/taglibs.jsp" %>
<c:set var="title" value="${title}" />
<%@ include file="../common/header.jsp" %>

<div style="margin-bottom: 3rem; display: flex; justify-content: space-between; align-items: flex-end;">
    <div>
        <h1 style="font-size: 2.25rem; font-weight: 800; color: var(--primary); letter-spacing: -0.04em;">Karma Ledger</h1>
        <p style="color: var(--text-muted);">A transparent history of your contributions and rewards.</p>
    </div>
    <div class="stat-card" style="padding: 1rem 1.5rem; background: var(--secondary); color: white; border: none;">
        <div style="font-size: 0.75rem; text-transform: uppercase; opacity: 0.8; font-weight: 700;">Total Balance</div>
        <div style="font-size: 1.5rem; font-weight: 800;"><i class="fa-solid fa-star"></i> ${userKarma} Points</div>
    </div>
</div>

<div class="stat-card" style="padding: 0; overflow: hidden;">
    <table>
        <thead>
            <tr>
                <th>Date</th>
                <th>Description</th>
                <th style="text-align: right;">Amount</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="tx" items="${transactions}">
                <tr>
                    <td style="color: var(--text-muted); font-size: 0.875rem;">
                        <fmt:parseDate value="${tx.createdAt}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDate" type="both" />
                        <fmt:formatDate value="${parsedDate}" pattern="MMM dd, yyyy HH:mm" />
                    </td>
                    <td style="font-weight: 600; color: var(--text-main);">
                        ${tx.reason}
                    </td>
                    <td class="text-right font-bold ${tx.points >= 0 ? 'text-success' : 'text-error'}" style="text-align: right; font-weight: 800;">
                        ${tx.points >= 0 ? '+' : ''}${tx.points}
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty transactions}">
                <tr>
                    <td colspan="3" style="padding: 5rem; text-align: center; color: var(--text-muted);">
                        <i class="fa-solid fa-receipt" style="font-size: 3rem; opacity: 0.2; margin-bottom: 1rem;"></i>
                        <p>No transactions found. Start contributing to earn Karma!</p>
                    </td>
                </tr>
            </c:if>
        </tbody>
    </table>
</div>

<div style="margin-top: 2rem; text-align: center;">
    <a href="<c:url value='/citizen/dashboard'/>" class="btn btn-outline">
        <i class="fa-solid fa-arrow-left"></i> Back to Dashboard
    </a>
</div>

<%@ include file="../common/footer.jsp" %>
