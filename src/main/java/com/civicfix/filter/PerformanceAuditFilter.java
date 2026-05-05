package com.civicfix.filter;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

/**
 * A J2EE Filter to audit request performance.
 * This satisfies the JD requirement for: "Implement J2EE technologies to enhance application functionality"
 * and "Assist in troubleshooting and debugging code to ensure optimal performance."
 */
@WebFilter("/*")
public class PerformanceAuditFilter implements Filter {

    private static final Logger logger = LoggerFactory.getLogger(PerformanceAuditFilter.class);

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        logger.info("PerformanceAuditFilter initialized.");
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        long startTime = System.currentTimeMillis();

        // Continue the filter chain
        chain.doFilter(request, response);

        long endTime = System.currentTimeMillis();
        long duration = endTime - startTime;

        if (request instanceof HttpServletRequest) {
            HttpServletRequest httpRequest = (HttpServletRequest) request;
            String uri = httpRequest.getRequestURI();
            String method = httpRequest.getMethod();
            
            // Only log if it's not a static resource to keep logs clean
            if (!uri.contains("/css/") && !uri.contains("/js/") && !uri.contains("/images/")) {
                logger.info("PERFORMANCE AUDIT: [{}] {} took {} ms", method, uri, duration);
                
                // Alert on slow queries (e.g. over 500ms)
                if (duration > 500) {
                    logger.warn("SLOW ENDPOINT DETECTED: [{}] {} took {} ms", method, uri, duration);
                }
            }
        }
    }

    @Override
    public void destroy() {
        logger.info("PerformanceAuditFilter destroyed.");
    }
}
