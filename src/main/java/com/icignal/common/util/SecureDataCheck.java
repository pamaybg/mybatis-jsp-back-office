package com.icignal.common.util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.icignal.core.exception.DataSQLException;

/**
 * @name infavor.util.IFVMSecureDataCheck
 * @date 2019. 03. 19.
 * @author jk.kim
 * @description ${데이터} sqlinejection 방지
 */
public class SecureDataCheck {

    /**
     * @programId
     * @name preventSqlInjection
     * @date 2019. 03. 19.
     * @author jk.kim
     * @param data
     * @return
     * @description
     */
    public static void preventSqlInjection(String data) {
    	String tempData = data;
    	final Pattern SpecialChars = Pattern.compile("['\"\\-#()@;=*/+]");
		final String regex = "(union |select |from |where | and | or )";
		tempData = SpecialChars.matcher(tempData).replaceAll("");

		Pattern pattern = Pattern.compile(regex, Pattern.CASE_INSENSITIVE);
		Matcher matcher = pattern.matcher(tempData);
		if(matcher.find()){
			 throw new DataSQLException();
		}

    }

}
