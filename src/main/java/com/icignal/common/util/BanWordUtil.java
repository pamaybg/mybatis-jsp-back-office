package com.icignal.common.util;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.icignal.core.exception.DataBanWordRequestException;

/**
 * 로그 관련 Util 클래스
 * 
 * @author jskim
 * 
 */
public class BanWordUtil {

	static final Logger logger = LoggerFactory.getLogger(BanWordUtil.class);
	
	/** 금칙어 최대 크기 */
	public static final int FILTER_WORD_MAX_LENGTH = Integer
			.valueOf(CommonUtil.getInstance().getServletProp("banWord.filter.maxLength"));
	/** 금칙어 최소 크기 */
	public static final int FILTER_WORD_MIN_LENGTH = Integer
			.valueOf(CommonUtil.getInstance().getServletProp("banWord.filter.minLength"));
	/** 단어 구분자 */
	public static final String DELIMITERS = " ,;/'\"\n\r.~!@#$%^&*()+|-=`[]";


	public static String checkFilterWord4HashMap(HashMap _filterWordList, String _contents) {

		String content = null;
		HashMap<String, String> hash = new HashMap<String, String>();

		if (_contents == null)
			return null;
		
		try {
			content = URLDecoder.decode(_contents, "utf-8");
		} catch (UnsupportedEncodingException e) {
			LogUtil.error(e);
		} catch (IllegalArgumentException e) {
			LogUtil.error(e);
			content = _contents;
		}
		
		content = content.toLowerCase();

		StringTokenizer st = new StringTokenizer(content, DELIMITERS, false);

		// 단어를 추출한다.
		while (st.hasMoreElements()) {
			String str = st.nextToken();
			int length = str.length();
			String substr;

			String tmpstr = hash.get(str);
			if (tmpstr != null)
				continue;

			if (CommonUtil.getInstance().getServletProp("banWord.filter.containsFlag").equalsIgnoreCase("true")) {
				for (int k = 0; k < length - FILTER_WORD_MIN_LENGTH + 1; k++) {
					for (int i = FILTER_WORD_MIN_LENGTH + k; i <= length && i < FILTER_WORD_MAX_LENGTH; i++) {
						substr = str.substring(k, i);
						if (_filterWordList.get(substr.toLowerCase()) != null)
							return substr;
					}
				}
			} else {
				if (_filterWordList.get(str.toLowerCase()) != null)
					return str;
			}

			hash.put(str, str);
		}

		return null;
	}

	public static void checkFilterWord4HashMap(HttpServletRequest httpRequest, String jsonString) {
		if(CommonUtil.getInstance().getServletProp("banWord.enabled") != null
				&& CommonUtil.getInstance().getServletProp("banWord.enabled").equalsIgnoreCase("true")) {
			try {
				ObjectMapper mapper = new ObjectMapper();

				Map<String, Object> orgMap = mapper.readValue(jsonString,
						new TypeReference<Map<String, Object>>() {
						});

				HashMap<String, String> map = new HashMap<String, String>();
				for (Map.Entry<String, Object> elem : orgMap.entrySet()) {
					printAll(map, elem.getKey(), elem.getValue());
				}

				String variables = CommonUtil.getInstance().getServices().get(httpRequest.getRequestURI());
				HashMap<String, String> passVariables = new HashMap<String, String>();
				if (variables != null && variables.length() > 0) {
					List<String> objs = Arrays.asList(variables.split(","));
					for (String s : objs)
						passVariables.put(s, "");
				}

				for (Map.Entry<String, String> elem : map.entrySet()) {
					if (passVariables.get(elem.getKey()) != null) {
						String value = elem.getValue() != null ? String.valueOf(elem.getValue()) : "";
						String findResult = checkFilterWord4HashMap(CommonUtil.getInstance().getBanWords(), value);
						if (findResult != null) {
							String msg = String.format("%s:%s", elem.getKey(), findResult);

							LogUtil.error("Ban Word - " + msg);

							throw new DataBanWordRequestException(msg);
						}
					}
				}
			} catch (JsonParseException e) {
				LogUtil.error(e.getMessage(),e);
			} catch (JsonMappingException e) {
				LogUtil.error(e.getMessage(),e);
			} catch (IOException e) {
				LogUtil.error(e.getMessage(),e);
			}
		}
	}

	public static void printAll(Map<String, String> _map, String key, Object elem)
			throws JsonParseException, JsonMappingException, IOException {
		if (elem instanceof ArrayList) {
			for (Object obj : (ArrayList) elem) {
				printAll(_map, key, obj);
			}
		} else if (elem instanceof LinkedHashMap) {
			HashMap<String, Object> map = (HashMap<String, Object>) elem;

			for (Map.Entry<String, Object> ele : map.entrySet()) {
				printAll(_map, key + "-" + ele.getKey(), ele.getValue());
			}
		} else {
			_map.put(key, elem != null ? elem.toString() : "");
		}

	}
}
