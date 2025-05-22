package com.pathcode.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebFilter("/*")
public class AuthenticationFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization code if needed
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) 
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);
        
        String loginURI = httpRequest.getContextPath() + "/user/login";
        String registerURI = httpRequest.getContextPath() + "/user/register";
        String logoutURI = httpRequest.getContextPath() + "/user/logout";
        String resourcesURI = httpRequest.getContextPath() + "/resources/";
        String cssURI = httpRequest.getContextPath() + "/css/";
        String jsURI = httpRequest.getContextPath() + "/js/";
        
        boolean loggedIn = session != null && session.getAttribute("user") != null;
        boolean loginRequest = httpRequest.getRequestURI().equals(loginURI);
        boolean registerRequest = httpRequest.getRequestURI().equals(registerURI);
        boolean resourceRequest = httpRequest.getRequestURI().startsWith(resourcesURI) ||
                                 httpRequest.getRequestURI().startsWith(cssURI) ||
                                 httpRequest.getRequestURI().startsWith(jsURI);
        
        if (loggedIn || loginRequest || registerRequest || resourceRequest) {
            chain.doFilter(request, response);
        } else {
            // Store the requested URL in session
            if (session != null) {
                session.setAttribute("redirectAfterLogin", httpRequest.getRequestURI());
            }
            httpResponse.sendRedirect(loginURI);
        }
    }

    @Override
    public void destroy() {
        // Cleanup code if needed
    }
}