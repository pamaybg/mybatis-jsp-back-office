package com.icignal.common.util;

import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.util.CookieGenerator;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.common.net.InternetDomainName;
import com.icignal.common.base.dto.response.CookieResDto;


public class CookieUtil {
	static final Logger logger = LoggerFactory.getLogger(CookieUtil.class);

	public static void createCookie(HttpServletRequest request, HttpServletResponse response, String id, String appServiceId, String country, String lang) {
		HttpSession session = request.getSession(true);

		// String enableSSO = Common.getInstance().getServletProp("context.server.enableSSO");
		
		if (StringUtil.compareLoozy(BeansUtil.getApplicationProperty("icignal.login.sso.check"), "true") ) {
			CookieGenerator cookie = new CookieGenerator();
			String fullDomain = null;
			try {
				fullDomain = new URL(request.getRequestURL().toString()).getHost();
			} catch (MalformedURLException e) {
				LogUtil.error(e.getMessage(), e);
			}
			cookie.setCookieDomain(InternetDomainName.from(fullDomain).topPrivateDomain().toString());
			cookie.setCookieMaxAge(session.getMaxInactiveInterval());
			cookie.setCookieName(CommonUtil.USER_INFO_PROP);
				if ( "Real".equals(BeansUtil.getApplicationProperty("icignal.server-type"))) cookie.setCookieSecure(true);

			CookieResDto cr = new CookieResDto();
			cr.setId(id);
			cr.setLang(lang);
			cookie.addCookie(response, StringUtil.getJSONtoObject(cr));
		}
		
	}

	public static void removeCookie(HttpServletRequest request, HttpServletResponse response) {

		String enableSSO = BeansUtil.getApplicationProperty("icignal.context.server.enableSSO");
		if (enableSSO != null && enableSSO.equalsIgnoreCase("true")) {
			CookieGenerator cookie = new CookieGenerator();

			String fullDomain = null;
			try {
				fullDomain = new URL(request.getRequestURL().toString()).getHost();
			} catch (MalformedURLException e) {
				LogUtil.error(e.getMessage(),e);
			}
			//cookie.setCookieDomain(InternetDomainName.from(fullDomain).topPrivateDomain().toString());
			
			 InternetDomainName	 privateDomain = InternetDomainName.from(fullDomain).topPrivateDomain();
			if (privateDomain  != null ) cookie.setCookieDomain(privateDomain.toString());
			
			cookie.setCookieMaxAge(0);
			cookie.setCookieName(CommonUtil.USER_INFO_PROP);
			if ("Real".equals(BeansUtil.getApplicationProperty("icignal.server-type")))	cookie.setCookieSecure(true);

			cookie.addCookie(response, "");
		}
	} 

	public static Cookie getSSOCookie(HttpServletRequest request) {
		Cookie rtnCookie = null;
		for (Cookie c : request.getCookies()) {
			if (c.getName().equals(CommonUtil.USER_INFO_PROP)) {
				rtnCookie = c;
				break;
			}
		}
		return rtnCookie;
	}

	public static CookieResDto getUserData(Cookie cookie) {
		CookieResDto rtnValue = null;

		String key = cookie.getValue();
		if (key.length() > 0) {
			try {
				rtnValue = new ObjectMapper().readValue(key, CookieResDto.class);
			} catch (JsonParseException e) {
				LogUtil.error(e.getMessage(),e);
			} catch (JsonMappingException e) {
				LogUtil.error(e.getMessage(),e);
			} catch (IOException e) {
				LogUtil.error(e.getMessage(),e);
			}
		}

		return rtnValue;
	}

	public static CookieResDto getUserData(HttpServletRequest request) {
		CookieResDto rtnValue = null;

		Cookie c = getSSOCookie(request);
		if (c != null) {
			rtnValue = getUserData(c);
		}

		return rtnValue;
	}


}
