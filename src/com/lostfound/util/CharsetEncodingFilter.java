package com.lostfound.util;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

public class CharsetEncodingFilter implements Filter {
	private String encoding = "UTF-8";

	public void destroy() {
	}

	public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse,
	    FilterChain filterChain) throws IOException, ServletException {
	   servletRequest.setCharacterEncoding(this.encoding);
	   filterChain.doFilter(servletRequest, servletResponse);
	}

	public void init(FilterConfig filterConfig) throws ServletException {
	   this.encoding = filterConfig.getInitParameter("encoding");
	}
}
