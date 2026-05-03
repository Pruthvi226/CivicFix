package com.civicfix.config;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(urlPatterns = "/*")
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization code if needed
    }

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        
        // Use getServletPath() instead of getRequestURI() to avoid context path issues
        String path = request.getServletPath();

        // 1. Whitelist public paths that do NOT require authentication
        if (path.equals("/health") ||
            path.equals("/") ||
            path.equals("/home") ||
            path.equals("/index.jsp") ||
            path.startsWith("/login") ||
            path.startsWith("/register") ||
            path.startsWith("/public/") ||
            path.startsWith("/resources/")) {
            
            chain.doFilter(req, res); // Whitelisted, let it through
            return;
        }

        // 2. For all other paths: check session for logged-in user
        HttpSession session = request.getSession(false);
        boolean loggedIn = (session != null && session.getAttribute("user") != null);

        if (loggedIn) {
            chain.doFilter(req, res); // Authenticated, let it through
        } else {
            // No session -> redirect to /login
            response.sendRedirect(request.getContextPath() + "/login");
        }
    }

    @Override
    public void destroy() {
        // Cleanup code if needed
    }
}
