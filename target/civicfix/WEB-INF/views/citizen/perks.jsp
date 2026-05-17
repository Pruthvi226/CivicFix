<%@ include file="../common/taglibs.jsp" %>
<c:set var="title" value="${title}" />
<%@ include file="../common/header.jsp" %>

<div style="margin-bottom: 2rem; display: flex; justify-content: space-between; align-items: flex-end;">
    <div>
        <h1 style="font-size: 2.25rem; font-weight: 800; color: var(--primary); letter-spacing: -0.04em;">Karma Marketplace</h1>
        <p style="color: var(--text-muted);">Redeem your hard-earned Karma for community perks and personal rewards.</p>
    </div>
    <div class="stat-card" style="padding: 1rem 1.5rem; background: var(--primary); color: white; border: none;">
        <div style="font-size: 0.75rem; text-transform: uppercase; opacity: 0.8; font-weight: 700;">Your Balance</div>
        <div style="font-size: 1.5rem; font-weight: 800; color: var(--accent);"><i class="fa-solid fa-star"></i> ${userKarma} Points</div>
    </div>
</div>

<c:if test="${not empty param.success}">
    <div class="success-msg fade-in">${param.success}</div>
</c:if>
<c:if test="${not empty param.error}">
    <div class="error-msg fade-in">${param.error}</div>
</c:if>

<div class="dashboard-grid fade-in">
    <c:forEach var="perk" items="${perks}">
        <div class="stat-card" style="display: flex; flex-direction: column; justify-content: space-between;">
            <div>
                <div style="width: 50px; height: 50px; background: #f1f5f9; border-radius: 12px; display: flex; align-items: center; justify-content: center; margin-bottom: 1.25rem;">
                    <i class="fa-solid ${perk.iconClass}" style="font-size: 1.5rem; color: var(--primary);"></i>
                </div>
                <h3 style="font-size: 1.125rem; margin-bottom: 0.5rem;">${perk.name}</h3>
                <p style="font-size: 0.875rem; color: var(--text-muted); margin-bottom: 1.5rem;">${perk.description}</p>
            </div>
            
            <div style="display: flex; align-items: center; justify-content: space-between; padding-top: 1rem; border-top: 1px solid var(--border);">
                <div style="font-weight: 700; color: var(--primary);">${perk.costKarma} Points</div>
                <form action="<c:url value='/citizen/perks/redeem/${perk.id}'/>" method="post">
                    <button type="submit" class="btn ${userKarma >= perk.costKarma ? 'btn-primary' : 'btn-outline'}" 
                            ${userKarma < perk.costKarma ? 'disabled' : ''}
                            style="padding: 0.5rem 1rem; font-size: 0.8125rem;">
                        ${userKarma >= perk.costKarma ? 'Redeem Now' : 'Need More Karma'}
                    </button>
                </form>
            </div>
        </div>
    </c:forEach>
</div>

<div class="stat-card" style="margin-top: 2rem; background: #f8fafc; border-style: dashed; border-width: 2px; text-align: center; padding: 3rem;">
    <i class="fa-solid fa-gift" style="font-size: 2rem; color: var(--text-muted); margin-bottom: 1rem;"></i>
    <h3 style="color: var(--text-muted);">More Perks Coming Soon!</h3>
    <p style="font-size: 0.875rem; color: var(--text-muted);">We're partnering with local businesses to bring you more rewards.</p>
</div>

<%@ include file="../common/footer.jsp" %>
