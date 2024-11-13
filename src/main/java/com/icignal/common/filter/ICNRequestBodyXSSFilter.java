package com.icignal.common.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

/**
 * @name : infavor.base.filter.ICNRequestBodyXSSFilter
 * @date : 2017. 6. 20.
 * @author : "dg.ryu"
 * @description : Request Body XSS Filter
 */
public class ICNRequestBodyXSSFilter implements Filter {
	 
	public FilterConfig filterConfig;

	public void init(FilterConfig filterConfig) throws ServletException {
        this.filterConfig = filterConfig;
    }
 
    public void destroy() {
        this.filterConfig = null;
    }
 
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
        throws IOException, ServletException {
		
    	boolean check = true;
		if (((HttpServletRequest) request).getHeader("content-type") != null && ((HttpServletRequest) request).getHeader("content-type").indexOf("multipart/form-data") > -1) {
				check = false;
		}
		
		if (check) {
			chain.doFilter(new ICNRequestWrapper((HttpServletRequest) request), response);
		} else {
			chain.doFilter((HttpServletRequest) request, response);
		}
 
    }
}