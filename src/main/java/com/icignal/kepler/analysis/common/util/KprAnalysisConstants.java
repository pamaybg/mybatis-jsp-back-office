package com.icignal.kepler.analysis.common.util;

/*
 * 1. 클래스명	: KPRAnalysisConstants
 * 2. 파일명	: KPRAnalysisConstants.java
 * 3. 패키지명	: com.icignal.kepler.analysis.common.util
 * 4. 작성자명	: 
 * 5. 작성일자	: 2020. 3. 17.
 */
/**
 * <PRE>
 * 1. 설명
 *		KPRAnalysisConstants
 * </PRE>
 */ 
public class KprAnalysisConstants {
	public static enum ANALYSIS_TYPE {
		CHART, TABLE;
	}

	public static enum CHART_TYPE_CODE {
		COMBINATION, COLUMN, PIE, DOUGHNUT;
	}

	public static enum COL_TYPE_CD {
		MEASURE, DIMENSION;
	}

	public static enum COL_USE_TYPE_CD {
		COLUMN, ROW;
	}

	public static enum COMB_COL_TYPE_CODE {
		COLUMN, LINE;
	}

	public static enum DATABASE_TYPE {
		MYSQL, ORACLE, POSTGRESQL;
	}

	public static enum PROMPT_TYPE_CD {
		LIST_BOX, DATE, DATE_BETWEEN;
	}

	public static enum SERC_OPRT_CODE {
		BETWEEN, IN, LIKE, CUSTDTDEF;
	}

	public static enum EXPORT_TYPE {
		EXCEL, WORD, HWP, PDF, HTML;
	}

	public static enum ORDER_TYPE {
		ASCENDING, DESCENDING, ASC, DESC
	}

	public static enum TOTAL_DP_TYPE_CD {
		SUM, AVG
	}

	public static String convertGroupFunction(String groupFuncTypeCode, String tableColumnAlias) {
		if ("COUNT(DISTINCT)".equals(groupFuncTypeCode)) {
			return "COUNT( DISTINCT " + tableColumnAlias + " )";
		}

		return groupFuncTypeCode + "( " + tableColumnAlias + " )";
	}
}