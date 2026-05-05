package com.civicfix.exception;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.NoHandlerFoundException;

/**
 * Centralized exception handler for the entire application.
 * Addresses JD point: "Assist in troubleshooting and debugging code to ensure optimal performance."
 */
@ControllerAdvice
public class GlobalExceptionHandler {

    private static final Logger logger = LoggerFactory.getLogger(GlobalExceptionHandler.class);

    @ExceptionHandler(NoHandlerFoundException.class)
    public ModelAndView handle404(NoHandlerFoundException ex) {
        logger.warn("404 Error: Resource not found - {}", ex.getRequestURL());
        ModelAndView mav = new ModelAndView();
        mav.addObject("errorMsg", "The page you are looking for does not exist.");
        mav.setViewName("common/error");
        return mav;
    }

    @ExceptionHandler(Exception.class)
    public ModelAndView handleGenericException(Exception ex) {
        logger.error("500 Error: An unexpected exception occurred", ex);
        ModelAndView mav = new ModelAndView();
        mav.addObject("errorMsg", "An unexpected error occurred. Our team has been notified.");
        mav.setViewName("common/error");
        return mav;
    }
}
