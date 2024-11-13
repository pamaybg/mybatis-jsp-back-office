package com.icignal.common.util;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * XSSFilter 필터 클래스
 * 
 * @author jskim
 *
 */
public class XSSFilter implements Filter {
	private FilterConfig filterConfig;
	@Override
	public void init(final FilterConfig filterConfig) throws ServletException { 
		this.filterConfig = filterConfig;
	}

	@Override
	public void destroy() {
		this.filterConfig = null;
	}

	@Override
	public void doFilter(final ServletRequest request,
			final ServletResponse response, final FilterChain chain)
					throws IOException, ServletException {
		if (excludeUrl((HttpServletRequest) request)) {
		    HttpServletResponse resp = (HttpServletResponse) response;
		    resp.setHeader("Cache-Control", "no-store, no-cache, must-revalidate, max-age=0, post-check=0, pre-check=0");
		    resp.setHeader("Pragma", "no-cache");
			chain.doFilter(request, response);
		} else {
		    HttpServletResponse resp = (HttpServletResponse) response;
		    resp.setHeader("Cache-Control", "no-store, no-cache, must-revalidate, max-age=0, post-check=0, pre-check=0");
		    resp.setHeader("Pragma", "no-cache");
			chain.doFilter(
					XSSRequestWrapper.newInstance((HttpServletRequest) request),
					response);
		}
	}

	private boolean excludeUrl(final HttpServletRequest request) {
		final String uri = request.getRequestURI().toString().trim();
		final String xssExclude = "";
		final String[] xssExclues = org.springframework.util.StringUtils
				.tokenizeToStringArray(xssExclude, ",; \t\n");
		for (final String exclude : xssExclues) {
			if (uri.endsWith(exclude)) {
				return true;
			}
		}
		return false;
	}

	public FilterConfig getFilterConfig() {
		return filterConfig;
	}

	public void setFilterConfig(FilterConfig filterConfig) {
		this.filterConfig = filterConfig;
	}
	
	
}