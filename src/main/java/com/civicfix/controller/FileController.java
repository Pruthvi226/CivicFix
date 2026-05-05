package com.civicfix.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

/**
 * Secure file serving controller — simulates a Cloud Storage retrieval platform.
 * Only authenticated users can view uploaded evidence files.
 * Addresses JD points: #2 (MySQL + Cloud Storage), #3 (Spring MVC dynamic pages).
 */
@Controller
@RequestMapping("/files")
public class FileController {

    private static final Logger logger = LoggerFactory.getLogger(FileController.class);

    @GetMapping("/evidence/{filename}")
    public void serveEvidenceFile(@PathVariable String filename,
                                  HttpServletRequest request,
                                  HttpServletResponse response,
                                  HttpSession session) throws IOException {

        // Security check: only logged-in users can access evidence files
        Object user = session.getAttribute("user");
        if (user == null) {
            logger.warn("SECURITY: Unauthenticated access attempt to file: {}", filename);
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Prevent path traversal attacks
        Path uploadPath = Paths.get(request.getServletContext().getRealPath("/uploads/")).normalize();
        Path filePath = uploadPath.resolve(filename).normalize();

        if (!filePath.startsWith(uploadPath)) {
            logger.error("SECURITY: Path traversal attempt detected for filename: {}", filename);
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid filename");
            return;
        }

        if (!Files.exists(filePath)) {
            logger.warn("File not found: {}", filePath);
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        // Detect and set correct content type
        String contentType = Files.probeContentType(filePath);
        if (contentType == null) {
            contentType = MediaType.APPLICATION_OCTET_STREAM_VALUE;
        }

        response.setContentType(contentType);
        response.setContentLengthLong(Files.size(filePath));
        response.setHeader("Content-Disposition", "inline; filename=\"" + filename + "\"");

        logger.info("Serving evidence file: {} (type: {})", filename, contentType);
        Files.copy(filePath, response.getOutputStream());
        response.getOutputStream().flush();
    }
}
