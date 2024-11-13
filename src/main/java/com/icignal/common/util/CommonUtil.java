package com.icignal.common.util;

import java.util.*;

import javax.servlet.http.HttpServletRequest;

import com.icignal.common.base.dto.response.CommCodeResDto;
import org.modelmapper.internal.typetools.TypeResolver;

/**
 * 공통 클래스
 *
 * @author jskim
 *
 */
public class CommonUtil {
	

	
	 /*
	  * 1. 메소드명: newRid
	  * 2. 클래스명: CommonsUtil
	  * 3. 작성자명: knlee 
	  * 4. 작성일자: 2020. 2. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *  DB 테이블 RID값 랜텀 생성
	 *		
	 * 2. 사용법
	 *	CommonUtil.newRid();
	 * </PRE>
	 *   @return	
	 */
	public final static String newRid() {
      return UUID.randomUUID().toString().replace("-", "").toUpperCase();
	}
	/**
	 * 로그 유형
	 *
	 * @author jskim
	 */
	public static enum LOG_TYPE {
		/**
		 * 에러
		 */
		ERROR,

		/**
		 * 디버깅
		 */
		DEBUG,

		/**
		 * 정보
		 */
		INFO
	}

	/**
	 * 페이징 정렬
	 *
	 * @author jskim
	 */
	public static enum ORDER_BY {
		/**
		 * 순방향 정렬
		 */
		ASC,

		/**
		 * 역방향 정렬
		 */
		DESC,
	}

	/**
	 * 서버 구분
	 *
	 * @author jskim
	 */
	public enum SERVER_TYPE {
		/**
		 * 운영
		 */
		Real,

		/**
		 * 개발
		 */
		Dev,

		/**
		 * 품질
		 */
		QA,

		/**
		 * 로컬
		 */
		Local
	}

	/**
	 * DB 구분
	 *
	 * @author jskim
	 */
	public enum DB_TYPE {
		/**
		 * MYSQL
		 */
		MYSQL,

		/**
		 * ORACLE
		 */
		ORACLE,

		/**
		 * MSSQL
		 */
		MSSQL,
		
		/**
		 * POSTGRESQL
		 */
		POSTGRESQL,
		/**
		 * MEMSQL
		 */
		MEMSQL
	}

	/**
	 * 모바일 서비스 호출 디바이스 구분
	 *
	 * @author 김정석
	 */
	public static enum MOBILE_TYPE {
		/**
		 * 아이폰
		 */
		IOS,

		/**
		 * 안드로이드
		 */
		AND,
	}


	static private CommonUtil instance;

	//private Properties servletProp;
	private static Properties mobileProp;
	private static Properties etcProp;
	//private static SERVER_TYPE serverType;
	private static DB_TYPE dbType;
	private String currentIP;

	public String getCurrentIP() {
		return currentIP;
	}

	public void setCurrentIP(String currentIP) {
		this.currentIP = currentIP;
	}

	public static final String USER_INFO_PROP = "USER_INFO";

	public Set<String> getEtcPropValues() {
		return this.etcProp.stringPropertyNames();
	}

	public Set<String> getMobilePropValues() {
		return this.mobileProp.stringPropertyNames();
	}

//	private static void initTempExcelFile() {
//		File folder = new File(System.getProperty("java.io.tmpdir"));
//		File[] fileNames = folder.listFiles(new FilenameFilter() {
//			@Override
//			public boolean accept(File dir, String name) {
//
//				return name.startsWith("Excel-");
//
//			}
//
//		});
//
//		for (File f : fileNames)
//			f.delete();
//	}


	public String getServletProp(String prop) {
		return BeansUtil.getApplicationProperty(prop);
	//	return servletProp.getProperty(prop);
	}

	public String getRootUrl() {
	//	return servletProp.getProperty("context.rootUrl");
		return BeansUtil.getApplicationProperty("icignal.context.rootUrl");
	}

	public String getImageServerUrl() {
		//return servletProp.getProperty("context.imageServerUrl");
	   return	BeansUtil.getApplicationProperty("icignal.context.imageServerUrl");
		
	}

	public String getCDNServerUrl() {
		//return servletProp.getProperty("context.cdnServerUrl");
		  return	BeansUtil.getApplicationProperty("icignal.context.cdnServerUrl");
	}

	public Boolean getEnablePush() {
	//	return servletProp.getProperty("push.enable").equalsIgnoreCase("true");
		return BeansUtil.getApplicationProperty("icignal.push.enable", Boolean.class);
	}

	public String getEncryptAESKey() {
	//	return servletProp.getProperty("encrypt.aes.key");
		return BeansUtil.getApplicationProperty("icignal.security.properties-data-encryption.password");
	}

	public DB_TYPE getDBType() {
		//String dbType = servletProp.getProperty("jdbc.dbType").toString().toLowerCase();
		String dbType = BeansUtil.getApplicationProperty("icignal.db-connection-info.local.loy-db.master.db-type");
		if (dbType.equals("mysql"))
			this.dbType = DB_TYPE.MYSQL;
		else if (dbType.equals("oracle"))
			this.dbType = DB_TYPE.ORACLE;
		else if (dbType.equals("mssql"))
			this.dbType = DB_TYPE.MSSQL;

		return this.dbType;
	}

	private static HashMap<String, String> banWords;
	private List<CommCodeResDto> langs;

	public HashMap<String, String> getBanWords() {
		if (banWords == null)
			this.banWords = new HashMap<String, String>();
		return banWords;
	}

	private HashMap<String, String> services;

	public HashMap<String, String> getServices() {
		if (services == null)
			this.services = new HashMap<String, String>();
		return services;
	}

	public void setServices(HashMap<String, String> services) {
		this.services = services;
	}

	public List<CommCodeResDto> getLangs() {
		if (langs == null)
			this.langs = new ArrayList<CommCodeResDto>();
		return langs;
	}

	public void setLangs(List<CommCodeResDto> langs) {
		this.langs = langs;
	}
	
	/**
	 * 프로퍼티의 키값에 대한 value를 가져온다
	 * @author knlee  2018.05.15	 
	 * @param key
	 * @return String  프로퍼티 키값에 대한 value
	 */
	public static final String getProperty(String key) {
		return CommonUtil.getInstance().getServletProp(key);
	}

	/**
	 * IFCMCommon
	 * */
	public static enum IMAGE_UPLOAD_TYPE {
		/**
		 * 프로필
		 */
		Party,

		/**
		 * 페이버
		 */
		Site,

		/**
		 * 상품
		 */
		Product,

		/**
		 * 포스트
		 */
		Post,

		/**
		 * 공통 코드
		 */
		CommCode,

		/**
		 * 배너
		 */
		Banner,

		/**
		 * 가이드
		 */
		Guide,

		/**
		 * 비콘
		 */
		BeaconTask,
		/**
		 * 서브 회원
		 */
		Party_Sub,
		/**
		 * 사이트 서브
		 */
		Site_Sub,
		/**
		 * 브랜드
		 */
		Brand,
		/**
		 * 브랜드 서브
		 */
		Brand_Sub,
		/**
		 * 쿠폰
		 */
		Coupon,
		/**
		 * 스탬프 도장
		 */
		Stamp_Item,
		/**
		 * 스탬프 백그라운드
		 */
		Stamp_Back,
		/**
		 * 상품 메인
		 */
		PROD_MAIN,
		/**
		 * 카탈로그 메인
		 */
		CATALOG_MAIN,
		/**
		 * 상품 설명
		 */
		PROD_DESC,
		/**
		 * 카탈로그 설명
		 */
		CATALOG_DESC,
		/**
		 * 서비스 요청
		 */
		SERVICE_REQUEST,
		/**
		 * 캠페인
		 */
		CAMPAIGN,
		/**
		 * 사용자 등록
		 */
		USERCONTS,

		/**
		 * kj.kang -- CMS용 이미지 업로드
		 */
		CONTENT_MANAGER,
		/**
		 * 메뉴 아이콘
		 */
		MENU_ICON,
		/**
		 * B2C이벤트 스탬프형 버튼 이미지
		 */
		B2C_EVENT_STAMP_BUTTON,
		/**
		 * B2C이벤트 비활성별점 이미지
		 */
		B2C_EVENT_STAMP_INACTIVESTAR,
		/**
		 * B2C이벤트 활성별점 이미지
		 */
		B2C_EVENT_STAMP_ACTIVESTAR,
		/**
		 * B2C이벤트 비활성스탬프 이미지
		 */
		B2C_EVENT_INACTIVESTAMP,
		/**
		 * B2C이벤트 활성스탬프 이미지
		 */
		B2C_EVENT_ACTIVESTAMP,
		/**
		 * mj.pyo -- Push Message 이미지
		 */
		PUSH_MESSAGE,
		/**
		 * mj.pyo -- 공지사항 이미지
		 */
		NOTICE,
		/**
		 * mj.pyo -- EVENT 메인 배너 이미지
		 */
		EVENT_MAIN_BANNER,
		/**
		 * mj.pyo -- AppPopup 페이지 이미지
		 */
		APP_POPUP,
		/**
		 * mj.pyo -- EVENT 배너 이미지
		 */
		EVENT_BANNER,
		/**
		 * mj.pyo -- EVENT 페이지 이미지
		 */
		EVENT_DETAIL,
		/**
		 * 스탬프 배경 이미지
		 */
		STMP_BG,
		/**
		 * 스탬프 보드 이미지
		 */
		STMP_BOARD,
		/**
		 * 스탬프 미적립 이미지
		 */
		STMP_IMG_1,
		/**
		 * 스탬프 적립 이미지
		 */
		STMP_IMG_2,
		/**
		 * 스탬프 미적립(혜택) 이미지
		 */
		STMP_IMG_3,
		/**
		 * 스탬프 적립(혜택) 이미지
		 */
		STMP_IMG_4,
		/**
		 * 스탬프 미적립 이미지 (모바일에서 해당 구간 선택 시)
		 */
		STMP_IMG_1_SECT,
		/**
		 * 스탬프 적립 이미지 (모바일에서 해당 구간 선택 시)
		 */
		STMP_IMG_2_SECT,
		/**
		 * 스탬프 미적립(혜택) 이미지 (모바일에서 해당 구간 선택 시)
		 */
		STMP_IMG_3_SECT,
		/**
		 * 스탬프 적립(혜택) 이미지 (모바일에서 해당 구간 선택 시)
		 */
		STMP_IMG_4_SECT,

		PTNR_IMG,

		PTNR_IMG_DETAIL,
		/**
		 * 사용자 등록 컨텐츠 이메일
		 */
		USERCONTS_EMAIL,
		/**
		 * 사용자 등록 컨텐츠 MMS
		 */
		USERCONTS_MMS,
		/**
		 * 사용자 등록 컨텐츠 PUSH
		 */
		USERCONTS_PUSH,

		SURVEY,

		CONTENT


	}

	/**
	 * 서버 구분
	 *
	 * @author 김정석
	 */
//	public enum SERVER_TYPE {
//		/**
//		 * 운영
//		 */
//		Real,
//
//		/**
//		 * 개발
//		 */
//		Dev,
//
//		/**
//		 * 로컬
//		 */
//		Local
//	}

	/**
	 * 외부 접속용 세션변수
	 */
	public static final String EXTERNAL_USER_INFO = "EXTERNAL_USER_INFO";

	public static final String RELATE_SESSION_GROUP_PROP = "RELATE_SESSION_GROUP";

	public static final String SESSIONID_AUTH = "SESSIONID_AUTH";

	public static final String MOBILE_TYPE_PROP = "MOBILE_TYPE";
	public static final String SNS_CALL_TYPE_PROP = "SNS_CALL_TYPE";
	public static final String JOIN_TYPE_PROP = "JOIN_TYPE";
	public static final String LOGIN_ID_PROP = "LOGIN_ID";
	public static final String JOIN_TYPE_INFO_PROP = "JOIN_TYPE_INFO";
	public static final String SYNC_SNS_INFO_PROP = "SYNC_SNS_INFO";
	public static final String SAVE_EMAIL_COOKIE_PROP = "SAVE_EMAIL_COOKIE";
	public static final String POST_HIT_COOKIE_PROP = "POST_HIT_COOKIE";
	public static final String PROD_HIT_COOKIE_PROP = "PROD_HIT_COOKIE";
	public static final String USER_ID_PROP = "USER_ID";
	public static final String USER_IMAGE_PROP = "USER_IMAGE";
	public static final String USER_EMAIL_PROP = "USER_EMAIL";
	public static final String USER_NAME_PROP = "USER_NAME";
	public static final String USER_AUTH_PROP = "USER_AUTH";
	public static final String TWITTER_REQUESTTOKEN_PROP = "TWITTER_REQUESTTOKEN";
	public static final String TWITTER_REQUESTTOKEN_OBJ_PROP = "TWITTER_REQUESTTOKEN_OBJ";
	public static final String TWITTER_ACCESS_TOKEN_PROP = "TWITTER_ACCESS_TOKEN";
	public static final String TWITTER_ACCESS_TOKENSECRET_PROP = "TWITTER_ACCESS_TOKENSECRET";
	public static final String CHANGEPWD_ID_PROP = "CHANGEPWD_ID";
	public static final String JOIN_CALL_TYPE_PROP = "JOIN_CALL_TYPE";
	public static final String PERMISION_ACC_IN_PROP = "PERMISION_ACC_IN";
	public static final String CONTACT = "CONTACT";
	public static final String CONTACT_MASTER = "CONTACT_MASTER";

	// 비콘 매니저 & 라이트 에서 사용하는 속성
	public static final String CURR_STORE_PROP = "CURR_STORE";
	public static final String ACC_INFO = "ACC_INFO";
	public static final String ACC_DETAIL_POP = "ACC_DETAIL_PROP";
	public static final String CURR_DIVISION_PROP = "CURR_DIVISION";
	//static private CommonUtil instanceCommon;

	private String localHostName;
	private String localIp;

	static public CommonUtil getInstance() {
		if (instance == null) {
			instance = new CommonUtil();
		}
		return instance;
	}

	
	public String getMessage(String propname) {
		return CommonUtil.getInstance().getServletProp(propname);
	}

	public String getEncrypt_key() {
		return CommonUtil.getInstance().getServletProp("encrypt.key");
	}

	public String getMail_account() {
		return CommonUtil.getInstance().getServletProp("mail.account");
	}

	public String getMail_name() {
		return CommonUtil.getInstance().getServletProp("mail.name");
	}

	public String getResizeImageWebProfileDetail() {
		return CommonUtil.getInstance().getServletProp("resizeImage.web.profile.detail");
	}

	public String getResizeImageWebProfileNormal() {
		return CommonUtil.getInstance().getServletProp("resizeImage.web.profile.normal");
	}

	public String getResizeImageWebProfileThumb() {
		return CommonUtil.getInstance().getServletProp("resizeImage.web.profile.thumb");
	}

	public String getResizeImageWebPostDetail() {
		return CommonUtil.getInstance().getServletProp("resizeImage.web.post.detail");
	}

	public String getResizeImageWebPostNormal() {
		return CommonUtil.getInstance().getServletProp("resizeImage.web.post.normal");
	}

	public String getResizeImageWebPostThumb() {
		return CommonUtil.getInstance().getServletProp("resizeImage.web.post.thumb");
	}

	public String getResizeImageWebSiteDetail() {
		return CommonUtil.getInstance().getServletProp("resizeImage.web.site.detail");
	}

	public String getResizeImageWebSiteNormal() {
		return CommonUtil.getInstance().getServletProp("resizeImage.web.site.normal");
	}

	public String getResizeImageWebSiteThumb() {
		return CommonUtil.getInstance().getServletProp("resizeImage.web.site.thumb");
	}

	public String getResizeImageMobileLargeDetail() {
		return CommonUtil.getInstance().getServletProp("resizeImage.mobile.large.detail");
	}

	public String getResizeImageMobileLargeThumb() {
		return CommonUtil.getInstance().getServletProp("resizeImage.mobile.large.thumb");
	}

	public String getResizeImageMobileLargeNormal() {
		return CommonUtil.getInstance().getServletProp("resizeImage.mobile.large.normal");
	}

	public String getResizeImageMobileSmallDetail() {
		return CommonUtil.getInstance().getServletProp("resizeImage.mobile.small.detail");
	}

	public String getResizeImageMobileSmallThumb() {
		return CommonUtil.getInstance().getServletProp("resizeImage.mobile.small.thumb");
	}

	public String getResizeImageMobileSmallNormal() {
		return CommonUtil.getInstance().getServletProp("resizeImage.mobile.small.normal");
	}

	public String getMultiImageTablePost() {
		return CommonUtil.getInstance().getServletProp("multiImage.table.post");
	}

	public String getMultiImageTableProduct() {
		return CommonUtil.getInstance().getServletProp("multiImage.table.product");
	}

	public String getPushAndApiKey() {
		return CommonUtil.getInstance().getServletProp("push.and.apikey");
	}

	public String getPushIOSCertPath() {
		return CommonUtil.getInstance().getServletProp("push.ios.cert.path");
	}



	/**
	 * 파일 업로드 경로
	 */
/*	public String getFileUploadPath() {
		return Common.getInstance().getServletProp("fileUpload.fileUploadPath");
	}
*/
	public String getLocalIp() {
		return localIp;
	}

	public void setLocalIp(String localIp) {
		this.localIp = localIp;
	}

	public String getLocalHostName() {
		return localHostName;
	}

	public void setLocalHostName(String localHostName) {
		this.localHostName = localHostName;
	}

	public String getChannelExcelFileDownPath() {
		String excelFileDownPath = CommonUtil.getInstance().getServletProp("excelFileDownChannel.excelFileDownPath");
		return excelFileDownPath;
	}

	public String getChannelExcelFileDownName() {
		String excelFileDownName = CommonUtil.getInstance().getServletProp("excelFileDownChannel.excelFileDownName");
		return excelFileDownName;
	}

	// 기본 속성
	public static final String LANG = "LANG";
	public static final String DEFAULT_APP_SERVICE_ID = "13e28abc1cf39fdb62b00005";
	public static final String DEFAULT_LANG = "ko";

	// 프로그램 적용유형 - 마케팅
	public static final String PGM_APPLY_TYPE_MARKETING = "MARKETING";

	// 워크플로우 노드 활성화 FLAG
	public static final String WORKFLOW_NODE_ACT_FLAG_YES = "1";

	/**
	 * 캠페인 상태 속성
	 *
	 * @author : 류동균
	 */
	public enum CAMPAIGN_STATUS_TYPE {
		W, // 작성중
		A, // 활성
		I, // 비활성
		C, // 취소
		S, // 중지
		E // 완료
	}

	/**
	 * 실행정보 아이템 상태 : 발송완료
	 *
	 * @author : 류동균
	 */
	public static final String MKT_EXEC_STATUS_D = "D";

	/**
	 * 실행정보 아이템 상태 : 활성
	 *
	 * @author : 류동균
	 */
	public static final String MKT_EXEC_STATUS_A = "A";

	/**
	 * 제어그룹단위코드 : 건
	 *
	 * @author : 류동균
	 */
	public static final String MKT_CNTRL_GRP_UOM_C = "C";

	/**
	 * 제어그룹단위코드 : 비율
	 *
	 * @author : 류동균
	 */
	public static final String MKT_CNTRL_GRP_UOM_R = "R";

	/**
	 * 테스크 데이터 상태
	 *
	 * @author : 류동균
	 */
	public enum TASK_DATA_STATUS {
		/**
		 * Normal
		 */
		N,
		/**
		 * Insert
		 */
		I,
		/**
		 * Update
		 */
		U,
		/**
		 * Delete
		 */
		D
	}

	/**
	 * 테스크 데이터 상태
	 *
	 * @author : 류동균
	 */
	public enum DATA_STATUS {
		/**
		 * Normal
		 */
		N,
		/**
		 * Insert
		 */
		I,
		/**
		 * Update
		 */
		U,
		/**
		 * Delete
		 */
		D
	}

	/**
	 * 마케팅 워크플로우 노드 데이터 속성
	 *
	 * @author : 류동균
	 */
	public enum CAMPAIGN_WORKFLOW_NODE_DATA_TYPE {
		/**
		 * 캠페인기본정보
		 */
		INFO,
		/**
         * 예산/지원
         */
        BUDGET,
        /**
         * 스토어
         */
        STORE,
        /**
         * 멀티스테이지
         */
        MULTISTAGE,
        /**
         * 혜택
         */
        OFFER,
        /**
         * 쿠폰
         */
        COUPON,
		/**
		 * 일정
		 */
		SCHEDULE,
		/**
		 * ROI분석
		 */
		ROI,
		/**
		 * 승인
		 */
		APPROVAL,
		/**
		 * 문자Msg
		 */
		TEXTMSG,
		/**
		 * 이미지+문자
		 */
		IMGMSG,
		/**
		 * Html양식
		 */
		HTML,
		/**
		 * Script양식
		 */
		SCRIPT,
		/**
		 * Targeting
		 */
		TARGET,
		/**
		 * SMS
		 */
		SMS,
		/**
		 * LMS
		 */
		LMS,
		/**
		 * MMS
		 */
		MMS,
		/**
		 * PUSH
		 */
		PUSH,
		/**
		 * Email
		 */
		EMAIL,
		/**
		 * Script
		 */
		CALL,
		/**
		 * 페이스북
		 */
		FACEBOOK,
		/**
		 * 인스타그램
		 */
        INSTAGRAM,
        /**
         * 단말기
         */
        TERMINAL,
        /**
         * 웹게시
         */
        WEB,
        /**
         * 카카오톡 친구톡
         */
        KAKAO,
        /**
         * 카카오톡 알림톡
         */
        KAKAONOTICE,
        /**
         * 영수증
         */
        RECEIPT,
        /**
         * 앱공지
         */
        APPNOTICE,
		/**
		 * Logic
		 */
		LOGIC,
		/**
		 * Decision
		 */
		DECISION,
		/**
		 * Next
		 */
		NEXT,
		/**
		 * Fail
		 */
		FAIL,
		/**
		 * Exit
		 */
		EXIT,
		/**
		 * 모니터링
		 */
		MONITORING,
		/**
		 * et 조건
		 */
		ETCOND,
		/**
		 * et 활동
		 */
		ETACT,
		/**
		 * RuleSet
		 */
		RULESET,
		/**
		 * 텔레마케팅
		 */
		TM,
		/**
		 * Wait
		 */
		WAIT,
		/**
		 * 멀티스테이 조건
		 */
		MSCOND,
		/**
		 * KPI
		 */
		KPI,
		/**
		 * KAKAOFR
		 */
		KAKAOFR,
		/**
		 * KAKAONOTI
		 */
		KAKAONOTI,
		
	}

	/**
	* @name : infavor.util.SCORING_WORKFLOW_NODE_DATA_TYPE
	* @date : 2018. 7. 31.
	* @author : hy.jun
	* @description : scoring 워크플로우 노드 데이터 속성
	*/
	public enum SCORING_WORKFLOW_NODE_DATA_TYPE {
		/**
		 * 기본정보
		 */
		INFO,
		/**
		 * Rule 정보
		 */
		SCRCOND,
		/**
		 * Action 정보
		 */
		SCRACT,
	}

	public enum CAMPAIGN_NODE_TYPE_EXCEPTION {
		SMS,
		/**
		 * LMS
		 */
		LMS,
		/**
		 * MMS
		 */
		MMS,
		/**
		 * PUSH
		 */
		PUSH,
		/**
		 * Email
		 */
		EMAIL,
        /**
         * 단말기
         */
        TERMINAL,
        /**
         * 웹게시
         */
        WEB,
        /**
         * 카카오톡 친구톡
         */
        KAKAO,
        /**
         * 카카오톡 알림톡
         */
        KAKAONOTI,
        /**
         * 영수증
         */
        RECEIPT,
        /**
         * 앱공지
         */
        APPNOTICE,
		/**
		 * Script
		 */
		CALL,
		/**
		 * ROI분석
		 */
		ROI,
		/**
		 * 모니터링
		 */
		MONITORING,
        /**
         * 텔레마케팅
         */
        TM,
	}

	public static String getChannelCode(String code) {
		String[] smsList = { "SMS", "LMS", "MMS" };
		String value = code;
		for (String sms : smsList) {
			if (sms.equals(code)) {
				value = "SMS";
				break;
			}
		}

		return value;
	}

	/**
	 * @date : 2015. 11. 17.
	 * @author : 류동균
	 * @description : Acccount ORG Number
	 */
	public enum ACCOUNT_ORG_NUMBER {
		BONIF("BONIF00001"), YM("");

		private final String number;

		private ACCOUNT_ORG_NUMBER(String number) {
			this.number = number;
		}

		public String getNumber() {
			return number;
		}
	}

	public enum AUTH_SERVICE_TYPE {
		/**
		 * IOT
		 */
		IOT,
		/**
		 * MKT
		 */
		MKT
	}

	public static final String AUTH_GROUP_COLUMN = "aut_group_id";
	public static final String CREATE_BY_COLUMN = "create_by";

	/**
	 * 권한 데이터 유형
	 */
	public enum AUTH_DATA_TYPE {
		/**
		 * 전체
		 */
		ALL
		/**
		 * 하위부서
		 */
		, TEAM
		/**
		 * 나의 팀
		 */
		, MY_TEAM
		/**
		 * 나
		 */
		, MY
		/**
		 * 기타
		 */
		,NA
	}

	public enum WORKFLOW_SAVE_TYPE {
		/**
		 * 워크플로우
		 */
		WF,
		/**
		 * 노드
		 */
		NODE
	}

	/**
	 * @name : infavor.util
	 * @date : 2016. 7. 19.
	 * @author : 류동균
	 * @description : 마케팅 연산자 유형
	 */
	public enum MKT_CAL_TYPE {
		/**
		 * 합집합
		 */
		UNION,
		/**
		 * 교집합
		 */
		INTERSECTION,
		/**
		 * A차집합
		 */
		A_DIFF_SET,
		/**
		 * B차집합
		 */
		B_DIFF_SET

	}

	/**
	 * @name : infavor.util
	 * @date : 2016. 7. 19.
	 * @author : 류동균
	 * @description :세그먼트 필터 유형
	 */
	public enum ANL_SEG_FILTER_TYPE {
		/**
		 * 전체
		 */
		ALL,
		/**
		 * 기본 필터
		 */
		DEFAULT,
		/**
		 * 그룹 함수
		 */
		GROUP_FUNC,
		/**
		 * 합집합
		 */
		UNION,
		/**
		 * 교집합
		 */
		INTERSECTION,
		/**
		 * A차집합
		 */
		A_DIFF_SET,
		/**
		 * B차집합
		 */
		B_DIFF_SET

	}

	/**
	 * @name : infavor.util
	 * @date : 2016. 7. 19.
	 * @author : 류동균
	 * @description :세그먼트 유형
	 */
	public enum ANL_SEG_TYPE {
		/**
		 * 세그먼트
		 */
		SEG,
		/**
		 * 타겟그룹
		 */
		TGT_GROUP,
		/**
		 * 고객 세분화 룰
		 */
		CUST_SEG_RULE
	}

	/**
	 * @name : infavor.util
	 * @date : 2016. 7. 19.
	 * @author : 류동균
	 * @description : 마케팅 연산자 유형
	 */
	public enum MKT_SERC_OPRT_TYPE {
		LIKE("LIKE"), IN("IN"), NOT_IN("NOT IN"), BETWEEN("BETWEEN");

		private final String type;

		MKT_SERC_OPRT_TYPE(String arg) {
			this.type = arg;
		}

		public String getType() {
			return type;
		}
	}

	/**
	 * @name : infavor.util
	 * @date : 2016. 7. 19.
	 * @author : 류동균
	 * @description : 동적 쿼리 사용시 WHERE기호
	 */
	public enum MKT_WHERE_SIGN {
		LEFT_PARENTHESIS("( "), RIGHT_PARENTHESIS(" )"), SINGLE_QUOTE("'"), PERCENT("%"), COMMA(" ,"), AND(" AND "), UNDERLINE("_"), BACK_SLASH("\\");

		private final String value;

		MKT_WHERE_SIGN(String arg) {
			this.value = arg;
		}

		public String getValue() {
			return value;
		}
	}

	public enum ET_NODE_TYPE {
		/**
		 * RUL 룰노드
		 */
		RUL,
		/**
		 * ACT 액션 노드
		 */
		ACT
	}

	public enum Loy_RULESET_LIMIT_TYPE {
		/**
		 * 대상경로
		 */
		TAR_PATH,
		/**
		 * 결제기준
		 */
		TAR_CARD
	}

	public enum EXCEL_DOWNLOAD_TYPE {
		/**
		 * 타겟그룹
		 */
		TGT_GROUP_TGT,
		/**
		 * 타겟 파일업로드
		 */
		TGT_IMPORT_TGT,
		/**
		 * 타겟 SQL
		 */
		TGT_SQL_TGT,
		/**
		 * 포인트 거래이력
		 */
		PNT_TRANS,
		/**
		 * 포인트 수동일괄 적립결과
		 */
		PNT_BATCH_RGST_RSLT,
		/**
		 * 소멸포인트 예정자
		 */
		PNT_DROP_MBR,
		/**
		 * 포인트 선물 이력
		 */
		PNT_GIFT_TRANS,
		/**
		 * 스탬프 참여회원 목록
		 */
		STMP_MBR,
		/**
		 * 기프트카드 상품 리스트
		 */
		GIFTCARD_LST,
		/**
		 * 기프트카드 교환이력
		 */
		GIFTCARD_TRANS,
		/**
		 * 기기등록 리스트
		 */
		DEVICEREG_LST,
		/**
		 * 티켓 발행이력
		 */
		TICKET_TRANS,
		/**
		 * ecom 할인권 리스트
		 */
		ECOM_LST,
		/**
		 * 응모자
		 */
		EVT_APPLICANT,
		/**
		 * 당첨자
		 */
		EVT_WINNER,
		/**
		 * 신청자
		 */
		EVT_PRODENTRY,
		/**
		 * 출석이벤트 이력
		 */
		ATTENDANCE_TRANS,
		/**
		 * 이벤트 스토어
		 */
		EVT_STORE,
		/**
		 * 기기등록 현황
		 */
		MBR_DEVICE_HIST,
		/**
		 * 기기등록 조회
		 */
		MBR_DEVICE_SEARCH,
		/**
		 * 스토어 거래이력
		 */
		MBR_STORE_LIST,
		/**
		 * 포인트몰 상세 주문내역
		 */
		POINT_MALL_DETAIL_ORDER_LIST,
		/**
		 * 포인트몰 주문내역
		 */
		POINT_MALL_ORDER_LIST,
		/**
		 * ugc내역
		 */
		MBR_UGC_LIST,
		/**
		 * api spec
		 */
		Loy_API_SPEC_ATTACH,

		/**
		 * 포인트몰 현황
		 */
		POINT_MALL_HIST_LIST,
		/**
		 * shareglo 이벤트현황
		 */
		MBR_SHARE_GLO,
		/**
		 * FAQ 전체목록 (faq + fag_master)
		 */
		FAG_DETAIL_LIST,
		/**
		 * POLL 참여현황 목록
		 */
		PART_HIST_LIST,
		/**
		 * 개인정보 마스킹 해지 이력
		 */
		MBR_PNT_TRANS,
		/**
		 * PI_MASKING_DEC_LIST
		 * 회원 포인트 거래이력
		 */
		 PI_MASKING_DEC_LIST,
		 /**
		  * 오퍼 쿠폰 발급현황
		  * */
		 OFR_CUPON_STATUS_LIST,
		 /**
		  * 카페24 회원조회
		  * */
		 MBR_CAFE_24,
		 /**
		  * 구매이력
		  * */
		 ORD_LIST,
		 /**
		  * 상담이력
		  * */
		 VOC_LIST,
		 /**
		  * 추천인 이력
		  * */
		 RECOMMEND_LIST,
		 /**
		  * 상품평 이력
		  * */
		 PROD_REVW_LIST,
		/**
		 * 회원조회 이력
		 * */
		MBR_LIST,
		/**
		 * 개인정보 조회이력
		 * */
		COND_LOG_HIST_LIST,
		/**
		 * 권한 변경 이력 조회
		 * */
		AUTH_LOG_HISTORY_LIST,
		/**
		 * 엑셀 다운로드 이력 조회
		 * */
		EXCEL_DOWNLOAD_LOG_LIST,
		/**
		 * 로그인 이력 조회
		 * */
		LOGIN_HISTORY_LIST,
		/**
		 * 설문 결과 이력
		 * */
		SURVEY_RSLT_LIST,
		/**
		 * 매장용 리포트 조회 이력
		 * */
		STORE_REPORT_HISTORY_LIST,
		/**
		 * 채널 리스트
		 * */
		CHANNEL_LIST
	}

	/**
	 * @name : getClientIP
	 * @date : 2017. 6. 21.
	 * @author : "dg.ryu"
	 * @return : String
	 * @description : Client IP
	 */
	public static String getClientIP(HttpServletRequest request) {
		String ip = request.getHeader("X-Forwarded-For");

		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}

		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}

		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_CLIENT_IP");
		}

		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_X_FORWARDED_FOR");
		}

		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}

		return ip;
	}

	public enum DATA_SYNC_DB {
		/**
		 * MKT > TXN
		 */
		TXN,
		/**
		 * TXN > MKT
		 */
		MKT
	}

	/**
	 * @name : infavor.util.DATA_SYNC_STEP
	 * @date : 2017. 6. 27.
	 * @author : "dg.ryu"
	 * @description : Data sync Step
	 */
	public enum DATA_SYNC_STEP {
		Publish("1"), Receive("2"), Error("3");

		private final String value;

		DATA_SYNC_STEP(String arg) {
			this.value = arg;
		}

		public String getValue() {
			return value;
		}
	}

	/**
	 * @name : infavor.util.DATA_SYNC_TYPE
	 * @date : 2017. 6. 27.
	 * @author : "dg.ryu"
	 * @description : Data Sync Type
	 */
	public enum DATA_SYNC_TYPE {
		/**
		 * Insert
		 */
		I,
		/**
		 * Update
		 */
		U
	}

	/**
	 * @name : infavor.util.DATA_SYNC_TASK
	 * @date : 2017. 6. 27.
	 * @author : "dg.ryu"
	 * @description : 데이터 sync Task
	 */
	public enum DATA_SYNC_TASK {
		/**
		 * 공통코드
		 */
		COMM_CODE("com.comm_code"),
		/**
		 * 캠페인 마스터
		 */
		MKT_CAM_MST("mkt.mkt_cam_mst"),
		/**
		 * 회원정보
		 */
		MBR_INS("Loy.Loy_mbr"),
		/**
		 * 오퍼 마스터
		 */
		MKT_OFFER_MST("mkt.mkt_offer_mst"),
		/**
		 * 캠페인 오퍼 관계
		 */
		MKT_CAM_OFFER_REL("mkt.mkt_cam_offer_rel"),
		/**
		 * 로얄티 오퍼 포인트
		 */
		Loy_OFFER_PNT_DTL("Loy.Loy_offer_pnt_dtl"),
		/**
		 * 로얄티 오퍼 분담률
		 */
		Loy_OFFER_EXP_DIVID("Loy.Loy_offer_exp_divid"),
		/**
		 * 로얄티 RuleSet 마스터
		 */
		Loy_RULESET_MST("Loy.Loy_ruleset_mst"),
		/**
		 * 로얄티 RuleSet 상품
		 */
		Loy_RULESET_PROD("Loy.Loy_ruleset_prod"),
		/**
		 * 로얄티 RuleSet 제한
		 */
		Loy_RULESET_LIMIT("Loy.Loy_ruleset_limit"),
		/**
		 * 로열티 프로그램
		 */
		Loy_PGM("Loy.Loy_pgm"),
		/**
		 * 로열티 회원정보
		 */
		Loy_MBR("Loy.Loy_mbr"),
		/**
		 * 로열티 고객정보
		 */
		Loy_CUST("Loy.Loy_cust"),
		/**
		 * 로열티 채널 정보
		 */
		Loy_CHANNEL("Loy.Loy_channel"),
		/**
		 * 로열티 브랜드 정보
		 */
		Loy_BRD_CATEGORY("Loy.Loy_brd_category"),
		/**
		 * 로열티 카테고리 정보
		 */
		Loy_PROD_CATEGORY("Loy.Loy_prod_category"),
		/**
		 * 로열티 상품 정보
		 */
		Loy_PROD("Loy.Loy_prod"),
		/**
		 * 등급 그룹 정보
		 */
		Loy_TIER_GROUP("Loy.Loy_tier_group"),
		/**
		 * 등급 정보
		 */
		Loy_TIERS("Loy.Loy_tiers"),
		/**
		 * 등급이력 정보
		 */
		Loy_TIER_HIST("Loy.Loy_tier_hist"),
		/**
		 * 등급그룹과 채널관계 정보
		 */
		Loy_TIER_GRP_CHNL("Loy.Loy_tier_grp_chnl"),
		/**
		 * 회원별 발급 카드 정보
		 */
		Loy_MBR_CARD("Loy.Loy_mbr_card"),
		/**
		 * POS
		 */
		Loy_POS("Loy.Loy_pos"),

		/**
		 * 적립가능여부 이력 정보
		 */
		Loy_CHNL_ACRL_HIST("Loy.Loy_chnl_acrl_hist"),
		/**
		 * VOD 정보
		 */
		Loy_INTACT_VOC("Loy.Loy_intact_voc"),
		/**
		 * 거래 유형
		 */
		Loy_INTACT_TYPE("Loy.Loy_intact_type"),
		/**
		 * 가구화 정보
		 */
		Loy_FAMILY("Loy.Loy_family"),
		/**
		 * 회원별 가구화 정보
		 */
		Loy_MBR_FAML("Loy.Loy_mbr_faml"),

		/**
		 * 고객 부가 정보 테이블
		 */
		Loy_CUST_ADD_INFO("Loy.Loy_cust_add_info"),

		;

		private final String value;

		DATA_SYNC_TASK(String arg) {
			this.value = arg;
		}

		public String getValue() {
			return value;
		}

		public String getName() {
			return this.toString();
		}
	}

	/**
	 * @name : infavor.util.MKT_CAM_TYPE_CD
	 * @date : 2017. 6. 27.
	 * @author : "dg.ryu"
	 * @description : 캠페인 유형 코드
	 */
	public enum MKT_CAM_TYPE_CD {
		/**
		 * 바로실행캠페인
		 */
		LOADNGO,
		/**
		 * 프로모션 캠페인
		 */
		PROMOTION,
		/**
		 * 타겟 캠페인
		 */
		TARGET,
		/**
		 * 정기/반복 캠페인
		 */
		REGULAR,
		/**
		 * 이벤트 트리거 캠페인
		 */
		TRIGGER,
		/**
		 * 오픈 캠페인
		 */
		OPEN,
		/**
		 * Quick 캠페인
		 */
		QUICK,
		/**
		 * MASS 캠페인
		 */
		MASS,
		/**
		 * 멀티스테이지 캠페인
		 */
		MULTISTAGE,
	}

	/**
	 * @name : infavor.util.MKT_CAM_CHNL_TYPE_CD
	 * @date : 2017. 5. 19.
	 * @author : "dg.ryu"
	 * @description : 캠페인 채널 유형
	 */
	public enum MKT_CAM_CHNL_TYPE_CD {
		/**
		 * LMS
		 */
		LMS("mkt.mkt_msg_send_log"),
		/**
		 * MMS
		 */
		MMS("mkt.mkt_msg_send_log"),
		/**
		 * SMS
		 */
		SMS("mkt.mkt_msg_send_log"),
		/**
		 * PUSH
		 */
		PUSH("mkt.mkt_push_send_log"),
		/**
		 * EMAIL
		 */
		EMAIL("mkt.mkt_email_send_log"),
		/**
		 * KAKAONOTI
		 */
		KAKAONOTI("mkt.MKT_KAKAO_SEND_LOG"),
		/**
		 * KAKAOFR
		 */
		KAKAOFR("mkt.MKT_KAKAO_SEND_LOG"),
		/**
		 * CALL CENTER
		 */
		CALL(""),
		/**
		 * 대리점
		 */
		SELLER(""),
		/**
		 * DM
		 */
		DM(""),
		/**
		 * 웹페이지
		 */
		WEBPAGE(""),
		/**
		 * 쿠폰
		 */
		COUPON(""),
		/**
		 * 모바일기프
		 */
		MGIFT(""),
		/**
		 * 쿠폰함
		 */
		COUPON_BOX("mkt.mkt_coupon_box_send_log"),
		/**
		 * 페이스북
		 */
		FACEBOOK(""),
		/**
		 * 인스타그램
		 */
		INSTAGRAM(""),
        /**
         * 카카오톡 친구톡
         */
        KAKAO(""),
        /**
         * 카카오톡 알림톡
         */
        KAKAONOTICE(""),
        /**
         * 단말기
         */
        TERMINAL(""),
        /**
         * 웹게시
         */
        WEB(""),
        /**
         * 영수증
         */
        RECEIPT(""),
        /**
         * 앱공지
         */
        APPNOTICE(""),
        /**
         * 텔레마케팅
         */
        TM(""),
		;

		public static MKT_CAM_CHNL_TYPE_CD setValue(String type) {
			MKT_CAM_CHNL_TYPE_CD rtnType = null;
			switch (type) {
			case "LMS":
				rtnType = MKT_CAM_CHNL_TYPE_CD.SMS;
				break;
			case "MMS":
				rtnType = MKT_CAM_CHNL_TYPE_CD.SMS;
				break;
			case "SMS":
				rtnType = MKT_CAM_CHNL_TYPE_CD.SMS;
				break;
			case "PUSH":
				rtnType = MKT_CAM_CHNL_TYPE_CD.PUSH;
				break;
			case "EMAIL":
				rtnType = MKT_CAM_CHNL_TYPE_CD.EMAIL;
				break;
			case "CALL":
				rtnType = MKT_CAM_CHNL_TYPE_CD.CALL;
				break;
			case "SELLER":
				rtnType = MKT_CAM_CHNL_TYPE_CD.SELLER;
				break;
			case "DM":
				rtnType = MKT_CAM_CHNL_TYPE_CD.DM;
				break;
			case "WEBPAGE":
				rtnType = MKT_CAM_CHNL_TYPE_CD.WEBPAGE;
				break;
			case "COUPON":
				rtnType = MKT_CAM_CHNL_TYPE_CD.COUPON;
				break;
			case "KAKAO":
				rtnType = MKT_CAM_CHNL_TYPE_CD.KAKAO;
				break;
			case "KAKAONOTICE":
				rtnType = MKT_CAM_CHNL_TYPE_CD.KAKAONOTICE;
				break;
			case "TERMINAL":
				rtnType = MKT_CAM_CHNL_TYPE_CD.TERMINAL;
				break;
			case "WEB":
				rtnType = MKT_CAM_CHNL_TYPE_CD.WEB;
				break;
			case "RECEIPT":
				rtnType = MKT_CAM_CHNL_TYPE_CD.RECEIPT;
				break;
            case "APPNOTICE":
                rtnType = MKT_CAM_CHNL_TYPE_CD.APPNOTICE;
                break;
            case "TM":
                rtnType = MKT_CAM_CHNL_TYPE_CD.TM;
                break;
			default:
				break;
			}

			return rtnType;
		}

		private String tblNm;

		MKT_CAM_CHNL_TYPE_CD(String _tblNm) {
			tblNm = _tblNm;
		}

		public String getTblNm() {
			return tblNm;
		}
	}

	/**
	 * @name : infavor.util.ANL_DB_TYPE_CD
	 * @date : 2017. 9. 18.
	 * @author : "dg.ryu"
	 * @description : 분석DB유형
	 */
	public static enum ANL_DB_TYPE_CD {
		/**
		 * MySQL
		 */
		MYSQL,
		/**
		 * Oracle
		 */
		ORACLE,
		/**
		 * PostgreSQL
		 */
		POSTGRESQL
	}

	/**
	 * @name : infavor.util.ANL_DB_TYPE_CD
	 * @date : 2017. 12. 20.
	 * @author : ko.lee
	 * @description : 분석DB유형 그룹 코드명
	 */
	final static public String ANL_DB_TYPE_CD = "ANL_DB_TYPE_CD";

	public static String[] badWords = { "짱파일", "몽디스크", "대출", "性", "尼尾屍發老馬", "히로뽕", "후장", "후배위", "후레자식", "후랴들년", "후래자식", "후래자슥", "후래", "화냥년", "호빠", "호르자슥", "호루잡년", "호로잡놈", "호로잡년", "호로자식", "호로오자석", "호로쌔기", "호로새끼", "허벌창", "허벌", "해볼오빠만", "항문", "핥아", "할타", "필로폰", "폰팅", "폰쌕", "폰섹스", "폰섹", "포르노", "포르x", "포루노", "포루X", "페티시", "페티쉬", "페니스", "펀색", "퍽큐", "퍽유", "패티시", "패티쉬", "패티", "패니스", "팍큐", "털사진", "큰좇",
			"콩까기", "콩까", "콜컬", "콜걸", "콘돔", "컴쌕", "컴섹", "컴색", "컴쎅", "커엄세엑", "촹년", "촹녀", "쳐먹어", "쳐먹", "체위", "처녀막", "챵년", "창부", "창년", "창녀촌", "창녀", "찐따", "진따", "지미", "지룰", "지롤", "지럴", "지랄", "지랄", "즐섹", "즐색", "쥐보지", "쥐미", "쥐럴", "쥐랄", "죤만한색기", "죤나", "좌지", "좇밥", "좇도", "좇대가리", "좇나", "좇까", "좇같은년", "좇같은", "좇", "좆빨이", "좆밥", "좆도", "좆나", "좆까", "좆귀두", "좆같은년", "좆같은", "좆", "종놈", "종년", "좃밥", "좃도", "좃나", "좃까",
			"좃같은년", "좃같은", "좃", "좁밥", "존물", "존만아", "존만", "존나", "족까", "족같", "조져", "조옷까", "조옷", "조오옷", "조센징", "조삐리", "조뺑이", "조빠지게", "조밥", "조또", "조깟", "조까튼", "조까", "조건만남", "조개나빨어", "조가튼년", "조가튼", "조옺", "젖었", "젖밥새귀", "젖밥", "젖도", "젖나", "젖꼭지", "젖까", "젖같은", "젖이다", "젖까", "젖", "젓밥", "젓도", "젓더", "젓나", "젓까", "젓같은", "젓", "접밥", "저년", "저까", "잦이", "잡놈", "잡년", "잠지", "자지", "자쥐", "자위", "자아지", "자ㅈㅣ", "자ㅈl", "자ㅈI",
			"자ㅈ1", "자ㅈ!", "자x", "자g", "이년", "음부", "육시랄", "육봉", "원조하자", "원조녀", "원조교제", "원조교", "원.교", "왕보지", "왕죳", "옷벗기기", "올가슴", "오입질", "오입", "오르가즘", "오르가줌", "오르가슴", "오럴", "오랄", "옘병", "엿처먹어", "엿처거머", "엿먹어", "염병", "엠병", "에비씹", "에비", "에미", "에무", "에로", "엄창", "양아치", "양년", "양갈보", "야화", "야설", "야마", "야리", "야려", "야동", "야겜", "애자매", "애자", "애비", "애미씹", "애미", "애므", "애무", "애널", "아굴창", "아구창", "아구리", "아갈창",
			"아가리", "씹할새끼", "씹할년", "씹할", "씹팔늠", "씹팔놈", "씹팔년", "씹파뇬", "씹퉁", "씹탱이", "씹탱", "씹창년", "씹창", "씹질", "씹자지", "씹자식", "씹이다", "씹을냔", "씹연", "씹알늠", "씹알뇬", "씹알놈", "씹알년", "씹쌔들", "씹쌔끼", "씹쌔꺄", "씹쉐키", "씹쉐", "씹셰", "씹섹키", "씹섹년", "씹세키", "씹세야", "씹세기야", "씹생알", "씹생", "씹새끼", "씹새", "씹빨아", "씹빨년", "씹보지", "씹발놈", "씹물", "씹놈", "씹년", "씹구멍", "씹구녕", "씹1세", "씹.새.끼", "씹.년.들", "씹팔년", "씨팔뇬", "씨팔놈", "씨팔년", "씨팔", "씨팍", "씨파",
			"씨앙년", "씨빨년", "씨빨", "씨빡", "씨블", "씨붤너머세기", "씨불알년", "씨불알", "씨불넘", "씨불", "씨부럴", "씨부랄뇬", "씨부랄년", "씨부랄", "씨봉새끼", "씨봉", "씨볼늠", "씨볼놈", "씨볼년", "씨볼넘", "씨보랄", "씨벨세꺄", "씨벨늠", "씨벨놈", "씨벨년", "씨벨넘", "씨벨", "씨벌세끼", "씨벌새끼", "씨벌년", "씨벌", "씨버럴놈", "씨버럴년", "씨버럴", "씨밸늠", "씨밸놈", "씨밸넘", "씨방쉐", "씨방세", "씨방새끼", "씨방새", "씨방년", "씨발스키", "씨발새끼", "씨발눔아", "씨발놈아", "씨발년", "씨발", "씨바", "씨뎅", "씨댕", "씨뺠년", "씨뷍", "씨;발",
			"씨1발1년들아", "씨1발", "씨.팔,년,,", "씨.발늠", "씨,발넘", "씨,발,연", "씨'발", "씨발년", "씌팔년", "씌뻘년", "씌팛뇬", "씌벌뇬", "씌벌년", "씌발련이", "씌발년", "씌발", "쓰팔", "쓰팍", "쓰파", "쓰으발", "쓰블", "쓰불", "쓰봉", "쓰벵세끼", "쓰벌눔", "쓰벌놈", "쓰벌", "쓰버", "쓰방세끼", "쓰방새끼", "쓰발쌕끼", "쓰발놈", "쓰발", "쓰바", "쒸펄", "쒸팍", "쒸파", "쑤셔줄께", "쑤쎠박는다", "쎄엑스", "써버럴", "썅놈", "썅년", "썅녀언", "썅", "쌕쓰", "쌔낑", "쌍뇬", "쌍놈", "쌍년", "쌍녀언", "쌍넘", "쌍너엄", "싸갈통", "싯팔", "싯;팔",
			"싯1팔", "십팔놈아", "십팔년", "십탱이", "십창", "십쇼키", "십섹키", "십세키", "십세기", "십새야", "십새끼", "십새", "십보지", "십딱", "십년아", "십구녕", "시펄", "시팔", "시파", "시키", "시블넘들", "시붕년", "시불알년", "시불", "시볼년", "시벌세끼", "시벌새끼", "시벌년", "시벌넘", "시벌", "시방세야", "시방년", "시발어", "시발새끼", "시발름", "시발놈아", "시발놈", "시발년아", "시발넘", "시발", "시바알년", "시바라마", "시댕", "시끼", "시1발", "습탱이", "스와핑", "스벌놈", "스벌년아", "스발년", "스발녀나", "쉽텡아", "쉽발새야", "쉽수ㅔ", "쉽수ㅐ",
			"쉬풍", "쉬퐁", "쉬팔", "쉬파", "쉬불넘아", "쉬벌뇬", "쉬벌년", "쉬벌", "쉬발엑스", "쉬발새야", "쉑", "쉐끼", "쉐뀌", "숏자지", "섹쓰", "섹쑤", "섹스", "섹수", "섹소리", "섹녀", "섹s", "세키", "세퀴", "세엑스", "세끼", "세꺄", "성방", "성기구", "성기", "성교", "샹년", "색스", "색녀", "색끼", "색끈한", "색꺄", "색기", "새키", "새캬", "새끼", "새꺄", "새;끼", "새1끼", "새/끼", "새//끼야", "새꺄", "상놈", "상노무", "상년", "사까시", "뾰큐", "뽕", "뽀큐", "뽀찌", "뽀지", "뽀오지", "뽀사", "뽀르노", "뽀개", "뻑큐", "뻑꺼",
			"뻐큐", "뻐지", "빨자", "빨어", "빨아줘", "빨아줄께", "빨아줄까", "빨아봐", "빨아라", "빨구와라", "빠큐", "빠러", "빠라주까", "빠라죠", "빠라바", "빠라라", "빠라", "빠굴이", "빠굴", "빠구리", "빠구리", "빙신", "빙시", "빙.신", "빈신", "비잉신", "블래지어", "브지", "브랄", "븅신", "븅", "뷩신", "붕신", "붕삼", "불알", "부랄", "뵤지", "보짓물", "보짓", "보지털", "보지씹네", "보지씹", "보지빨아", "보지물", "보지깔아", "보지깔년", "보지구멍", "보지구녕", "보지구녁", "보지", "보쥐", "보우지", "보오지", "보ㅈㅣ", "보ㅈl", "보ㅈI", "보ㅈ1",
			"보ㅈ!", "보ㅈ", "보x", "보G", "보지구녕", "보지", "병신", "병시나", "병쉰", "병1신", "변태", "변섹", "변/태", "벼엉신", "벗걸", "번쌕", "번섹", "번쎅", "X버지", "버어지", "버러지", "뱅신", "발정", "박큐", "밑구멍", "미틴년", "미친새끼", "미친놈아", "미친놈", "미친년아", "미친년", "미친개보지같은년", "미이친년아", "미린년", "미년씹", "미.친.개.잡.년.이네", "뭘봐쉽발새야", "문디", "문둥", "몸캠", "목따", "매춘", "말보지", "만져줘", "마약", "띱", "띠블", "띠방세", "띠발", "똘추새끼", "또라이", "떡치기", "딸딸이", "딸따리", "딸구",
			"따먹고", "디질래", "디진다", "디져라", "디져", "등신", "등쉰아", "등;쉰", "등1쉰", "뒷치기", "뒤질", "뒤진다", "뒈진다", "뒈죠라", "뒈져라", "뒈져", "되져라", "데질래", "데져", "대주라", "대마초", "대갈통", "대갈빡", "다리벌려", "닝기미", "닝기리조또", "닝기리", "님이럴", "니주가리", "니엠", "니에미", "니어미", "니애비", "니애미", "니뿡", "니뽕", "니미럴", "니미랄", "니미", "니메랄", "니기미", "니믜", "니에비", "니에미", "니애비", "니애미", "늬미", "늬믜", "늬;1미", "늬//미", "느그엄마", "뉨이럴", "뉘미", "누드", "누두", "뇬", "노팬티",
			"노팬", "노브라", "냄비찢어", "나체", "끈팬티", "꼽냐", "꼴통새끼", "꼴통", "꼴린다", "꼴리는", "꼴리네", "꼴려", "꼬추", "깝사지", "근친상간", "근친", "그즤새끼", "그즤새끼", "구녘", "구녕", "고환", "고자새끼", "고자놈", "고자", "계집년", "게세리", "게색갸", "게보지", "게년", "게쉐이", "걸레같은", "걸레", "걸래놈", "걸래년", "걸래", "거지새키", "거지새끼들", "거지새끼", "거시기", "개후리상놈", "개후랴새끼", "개후랴들", "개후랴달놈", "개후랄년", "개후라릴놈", "개후라릴년", "개허벌창", "개지랄", "개좇같은놈", "개좇", "개좆같은놈", "개좆", "개종년", "개좃",
			"개존만아", "개조가치", "개젖", "개젓", "개잡년", "개자지", "개자식", "개자슥", "개자석", "개양아새리", "개양아새끼", "개양아", "개씹헐놈", "개씹할", "개씹보지", "개씹", "개씨불알", "개썅년", "개쌔끼", "개싼년", "개섹", "개색기", "개색갸", "개색", "개새캬", "개새야", "개새년", "개새끼", "개새", "개뼉다구", "개빠구리", "개불알", "개불랄", "개보지털", "개보지", "개미친", "개라슥", "개늠", "개눔", "개뇬", "개놈", "개년", "개넘", "개기냐", "개거지", "개같은놈", "개같은년", "개같은", "개갈보", "개젗", "개쌴년", "개;새", "개1세", "개1새", "개18놈",
			"개,세,끼,야", "개,같,은,년,", "개'새'끼", "개호로세끼야", "개호로새기", "개호로들.", "개자식", "개자식", "개십보지야", "개보지년", "개보지", "개년", "강간", "갈아먹을", "갈아마실", "갈보자식", "가라머글", "가라마실", "쬬다", "ㅈ물", "ㅈㅣ랄", "ㅈㅓㄲㅏ", "ㅈㅓㄱㄱㅏ", "ㅈr지", "ㅈrㅈㅣ", "ㅈrㅈl", "ㅈrㅈI", "ㅈrㅈ1", "ㅈrㅈ!", "ㅈ;ㄹ", "ㅈ1ㄹ", "ㅈ물", "ㅆㅣ발", "ㅅㅂㄻ", "ㅅㅂㄹㅁ", "ㅅㄲ", "ㅅ1발새갸", "ㅅㅔㄲㅣ", "ㅅㅐ끼", "ㅅㅐ끼", "ㅅㅐㄲㅣ", "ㅂ지", "ㅂㅈㅈㅈ", "ㅂㅈ", "ㅂ;ㅅ", "ㅂ1ㅅ", "ㅂ'ㅅ", "ㅁㅣ친년", "ㄴiㄱIㅁ1", "ㄴㅣㅇㅐㅁㅣ",
			"ㄱㅐ새", "줫밥", "죶", "죳도", "죳나", "죳", "좉", "졎꼭찌", "졎꼭지", "젙같은", "젗밥", "젗도", "젗까", "젗같은", "씝팔", "씝창년", "씝발", "씝년아", "씝", "쌰앙년", "쌰꺄", "싀팔", "싀발", "뵹신",
			// "zazi",
			// "yasisi",
			"x지",
			// "umo",
			// "suicide",
			// "suck",
			// "ssex",
			// "sex",
			// "porno",
			// "phorno",
			// "penis",
			// "oral",
			// "oOo",
			// "o0o",
			// "nomo",
			// "jaji",
			// "isex",
			// "fucking",
			// "fuckyou",
			// "fock",
			// "fetish",
			// "ero",
			"dog새",
			// "cam",
			// "c8",
			// "bz",
			// "bozy",
			// "bozi",
			// "boG",
			// "bitch",
			// "b.z",
			// "asshole",
			// "FUCKYOU",
			// "FUCK",
			// "Bullshit",
			// "BG",
			// "@!@",
			"1시발", "1닥;쳐", "18쎄키", "18쇄끼", "18섹히", "18섹키", "18세", "18색히", "18새끼", "18년아", "18년", "18것", "18쎅히",
			// "18x",
			// "18sus",
			// "1818",
			"10펄년", "10알늠", "10알놈", "10세기야", "10새야", "10새끼", "108새끼", "108년" };

	public static String[] xssWords = { "user_tables ", "user_table_columns ", "table_name ", "column_name ", "syscolumns ", "union ", "select ", "insert ", "drop ", "update ", " and ", " or ", "if ", "join ", "substring ", "from ", "where ", "declare ", "substr ", "openrowset ",

			"sysobjects", "object", "iframe", "link ", "applet", "embed ", "script",
			// "form",
			"div ", "javascript", "vbscript", "urn ", "document", "cookie", "alert", "input", "location", "unescape", " href",

			"onabort", "onblur", "onchange", "onclick", "ondblclick", "ondragdrop", "onerror", "onkeydown", "onkeypress", "onkeyup", "onload", "onmousedown", "onmouseout", "onmouseover", "onmouseup", "onmove", "onreset", "onresize", "onsubmit", "onunload" };

	public static String[] validURL = {};

	public String getKeyFilePath() {
		return CommonUtil.getInstance().getServletProp("security.keyFilePath");
	}

	/*
	 * Moblie Membership Start
	 */

	/**
	 * 멤버십 세션ID
	 */
	public static final String MEMBERSHIP_SESSIONID = "MEMBERSHIP_SESSIONID";

	/**
	 * 멤버십 사용자 정보
	 */
	public static final String MEMBERSHIP_USER_INFO = "MEMBERSHIP_USER_INFO";

	/**
	 * 고객 식별 유형 해당 테이블 : Loy.Loy_cust.identi_type_cd 해당 공통코드 :
	 * Loy_IDENTI_TYPE_CD
	 *
	 * @author 박광민 2017.04.10
	 */
	public static enum IDENTI_TYPE {
		/**
		 * CI
		 */
		CI("01"),
		/**
		 * 휴대폰번호
		 */
		PHONE("02"),
		/**
		 * 카드번호
		 */
		CARD("03"),
		/**
		 * 여권번호
		 */
		PASSPORT("04"),
		/**
		 * 법인번호
		 */
		LEGAL("05"),
		/**
		 * 이메일
		 */
		EMAIL("06");
		final private String cd;

		private IDENTI_TYPE(String cd) {
			this.cd = cd;
		}

		public String cd() {
			return cd;
		}
	}

	/**
	 * 회원 가입 상태
	 *
	 * @author 박광민 2017.03.27
	 */
	public static enum MEMBER_JOIN_STATUS {
		/**
		 * 두타몰 멤버십 회원
		 */
		DOOTA,
		/**
		 * 외부에서 유입된 회원(webId 생성 안된 상태)
		 */
		FROM_OUTSIDE,
		/**
		 * 휴면 회원
		 */
		LOCKED,
		/**
		 * 미인증 회원
		 */
		NOT_AUTH,
		/**
		 * 미회원
		 */
		NOT_MEMBER,
		/**
		 * 탈회 회원(재가입 불가기간)
		 */
		LEAVE,
		/**
		 * 활성
		 */
		A,
		/**
		 * 인증 전
		 */
		W,
		/**
		 * 탈회
		 */
		C
	}

	/**
	 * 회원 정보 조회 타입
	 *
	 * @author 박광민 2017.03.24
	 */
	public static enum MEMBER_INFO_SEARCH_TYPE {
		/**
		 * 회원존재유무
		 */
		MEM01,

		/**
		 * 로그인
		 */
		MEM02,

		/**
		 * 자동로그인
		 */
		MEM03,

		/**
		 * 아이디중복체크
		 */
		MEM04,

		/**
		 * 회원정보조회
		 */
		MEM05,

		/**
		 * 이메일인증
		 */
		MEM06
	}

	/**
	 * SCI 인증 유형
	 *
	 * @author 박광민 2017.04.19
	 */
	public static enum SCI_AUTH_TYPE {
		/**
		 * 본인인증
		 */
		H,

		/**
		 * 아이핀인증
		 */
		I
	}

	/**
	 * 가입 채널(번호) 해당 테이블 : Loy.Loy_channel.chnl_no
	 *
	 * @author 박광민 2017.04.05
	 */
	public static enum CHNL_TYPE {
		/**
		 * 웹
		 */
		WEB("CH0000354"),
		/**
		 * 모바일웹
		 */
		M("CH0000741"),
		/**
		 * 안드로이드
		 */
		AND("CH0000355"),
		/**
		 * 아이폰
		 */
		IOS("CH0000356"),
		/**
		 * 시럽
		 */
		SYRUP("CH0000357"),
		/**
		 * 두타면세점
		 */
		DUTYFREE("CH0000358");

		final private String chnlNo;

		private CHNL_TYPE(String chnlNo) {
			this.chnlNo = chnlNo;
		}

		public String chnlNo() {
			return chnlNo;
		}
	}

	/**
	 * 중복 여부
	 *
	 * @author 박광민 2017.03.27
	 */
	public static enum DUPLICATION_STATUS {
		/**
		 * 중복
		 */
		DUPL,
		/**
		 * 중복 아님
		 */
		NOT_DUPL
	}

	/**
	 * validation 체크시 사용하는 정규 표현식
	 *
	 * @author 박광민 2017.08.21
	 */
	public static final String REGEX_WEB_ID = "[A-Za-z]+(([\\.\\-\\_][A-Za-z0-9])|([A-Za-z0-9])){3,12}";
	public static final String REGEX_WEB_PWD = "^(?=.*[0-9])(?=.*[a-zA-Z])[a-zA-Z0-9~`!@#$%\\\\^&()-?=*._]{10,20}$";
	public static final String REGEX_EMAIL_ADDR = "^([0-9a-zA-Z!#\\$%&'\\*\\+\\-\\/=\\?\\^_`{\\|}~\\.]+)@([0-9a-zA-Z_-]+)(\\.[a-zA-Z]+){1,2}$";
	public static final String REGEX_ONLY_NUMBER = "^[0-9]*$";
	public static final String REGEX_JOIN_RCMMD_02 = "^[A-Z0-9]{5}$";

	/**
	 * 고객 유형 해당 테이블 : Loy.Loy_cust.cust_type_cd 해당 공통코드 : Loy_CUST_TYPE_CD
	 *
	 * @author 박광민 2017.04.10
	 */
	public static enum CUST_TYPE {
		/**
		 * 개인
		 */
		PERSON("01"),
		/**
		 * 법인
		 */
		LEGAL("02"),
		/**
		 * 외국인
		 */
		FOREIGNER("03");
		final private String cd;

		private CUST_TYPE(String cd) {
			this.cd = cd;
		}

		public String cd() {
			return cd;
		}
	}

	/**
	 * 회원 유형 해당 테이블 : Loy.Loy_mbr.mbr_type_cd 해당 공통코드 : Loy_MEM_TYPE_CD
	 *
	 * @author 박광민 2017.04.10
	 */
	public static enum MEM_TYPE {
		/**
		 * 개인
		 */
		P,
		/**
		 * 법인
		 */
		B,
		/**
		 * 임시(외국인)
		 */
		T
	}

	/**
	 * 국가 코드 해당 공통코드 : Loy_COUNTRY_CD
	 *
	 * @author 박광민 2017.04.20
	 */
	public static enum NATN_CD {
		/**
		 * 한국(한국어)
		 */
		KR("ko"),
		/**
		 * 미국(영어)
		 */
		US("en"),
		/**
		 * 중국(중국어)
		 */
		CN("zh");
		final private String lang;

		private NATN_CD(String lang) { // enum에서 생성자 같은 역할
			this.lang = lang;
		}

		public String lang() { // 문자를 받아오는 함수
			return lang;
		}
	}

	/**
	 * 약관 종류 해당 테이블 : Loy.Loy_terms.terms_type_cd 해당 공통코드 : LOY_CUST_AGRE_TYPE_CD
	 *
	 * @author 박광민 2017.04.17
	 */
	public static enum TERMS_TYPE {
		/**
		 * 회원약관동의
		 */
		MEMBER,
		/**
		 * 개인정보 수집 동의
		 */
		PRV_INFO,
		/**
		 * 위치정보 서비스활용 동의
		 */
		LBS_BIZ,
		/**
		 * 마케팅 활용 동의
		 */
		MKT_USE,
		/**
		 * 제 3자정보제공동의
		 */
		THIRD_SND
	}

	/**
	 * 결제 상태
	 *
	 * 해당 테이블 : mkt.mkt_elec_aprv.elec_aprv_status_cd 해당 공통코드 :
	 * EL_APPROVAL_STATUS_CD
	 *
	 * @author 김재희 2017.12.19
	 */
	public static enum APPROVAL_STATUS {

		/**
		 * 작성중
		 */
		WRITING("001"),
		/**
		 * 작성취소
		 */
		WRITE_CANCEL("002"),
		/**
		 * 결제진행중
		 */
		APPROVAL_IN_PROCESS("010"),
		/**
		 * 승인반려
		 */
		APPROVAL_RETURN("020"),
		/**
		 * 승인완료
		 */
		APPROVAL_SUCCESS("090"),
		/**
		 * 강제승인
		 */
		FORCED_APPROVAL("090"),;

		private String code;

		private APPROVAL_STATUS(String code) {
			this.code = code;
		}

		public String getCode() {
			return code;
		}

		public void setCode(String code) {
			this.code = code;
		}
	}

	/**
	 * 충전소 캠페인 혜택 유형
	 *
	 * @author 전화영 2018.02.05
	 */
	public static enum MKT_OFFER_TYPE_STN {
		/**
		 * 무료세차권
		 */
		CAR_WASH,

		/**
		 * 할인쿠폰
		 */
		DC_COUPON,

		/**
		 * 포인트
		 */
		POINT,

		/**
		 * 현장할인
		 */
		DC_FIELD,

		/**
		 * 미사용
		 */
		NA
	}

	/**
	 * 오퍼유형
	 *
	 * @author 전화영 2018.02.06
	 */
	public static enum MKT_OFFER_TYPE_CD {
		/**
		 * 포인트
		 */
		POINT,

		/**
		 * 스탬프
		 */
		STAMP,

		/**
		 * 할인
		 */
		DC,

		/**
		 * 사은품/경품
		 */
		GIFT,

		/**
		 * 정보제공
		 */
		INFO,
	}

	/**
	 * 오퍼사용처구분코드
	 *
	 * @author 전화영 2018.02.06
	 */
	public static enum OFFER_USE_DESK_DIV_CD {
		/**
		 * 전체
		 */
		D01,

		/**
		 * 특정가맹점
		 */
		D02,
	}

	/**
	 * 오퍼재원구분코드
	 *
	 * @author 전화영 2018.02.06
	 */
	public static enum OFFER_ECNRS_DIV_CD {
		/**
		 * 본사
		 */
		E01,

		/**
		 * 사용처 전체
		 */
		E02,

		/**
		 * 분담 없음
		 */
		E03,
	}

	/**
	 * 쿠폰승인유형코드
	 *
	 * @author 전화영 2018.02.06
	 */
	public static enum COUPN_APV_TYPE_CD {
		/**
		 * 직원
		 */
		A01,

		/**
		 * MHOWS
		 */
		A02,
	}

	/**
	 * 쿠폰발급유형코드
	 *
	 * @author 전화영 2018.02.06
	 */
	public static enum COUPN_ISS_TYPE_CD {
		/**
		 * 자사
		 */
		I01,

		/**
		 * MHOWS
		 */
		I02,
	}

	/**
	 * 프로모션 유형
	 *
	 * @author 전화영 2018.02.06
	 */
	public static enum Loy_PROMO_TYPE {
		/**
		 * E1Day(훼미리마트)
		 */
		ED02,

		/**
		 * 일반
		 */
		PO,

		/**
		 * 회원생일
		 */
		PD,

		/**
		 * E1 Day
		 */
		ED,

		/**
		 * 카드등록후 첫충전
		 */
		FR,

		/**
		 * 결혼기념일
		 */
		WD,
	}

	public static enum Loy_PROM_SUB_TYPE {
		P001, //기본포인트
		P002, //등급가산포인트
		P003, //승급업포인트
		P004, //웰컴포인트
		P005, //추천인포인트-가입자
		P006, //추천인포인트-피추천인
		P007, //다이소SOL페이가입 포인트
		P008, //간편가입회원신규전환 포인트
		P101, //매장별포인트
		P102, //카드사별포인트
		P014, //등급별포인트
		P009, //금액대별포인트(판매)
		P010, //금액대별포인트(결제)
		P011, //모델별포인트
		P013, //구매금액횟수(누적)포인트
		P012, //가구화 프로모션
		P201, //사후적립포인트
		P104, //더블포인트
	}

	/**
	 * @name : getLoyaltyTxnserverIp
	 * @date : 2017. 9. 29.
	 * @author : "dg.ryu"
	 * @return : String
	 * @description : 승인서버 IP
	 */
	public String getLoyaltyTxnserverIp() {
		return CommonUtil.getInstance().getServletProp("Loyalty.txnserver.ip");
	}

	/**
	 * @name : getLoyaltyTxnserverPort
	 * @date : 2017. 9. 29.
	 * @author : "dg.ryu"
	 * @return : String
	 * @description : 승인서버 Port
	 */
	public String getLoyaltyTxnserverPort() {
		return CommonUtil.getInstance().getServletProp("Loyalty.txnserver.port");
	}

	/*
	 * Moblie Membership End
	 *
	 */

	/**
	 * 엑셀 파일 업로드 경로
	 */
	public String getExcelFileUploadPath() {
		return CommonUtil.getInstance().getServletProp("icignal.context.resource.excelFileUploadPath");
	}
	
	/**
	 * 템플릿 파일 업로드 경로*
	 */
	public String getTempFileUploadPath() {
		return CommonUtil.getInstance().getServletProp("icignal.context.resource.excelFileUploadExcelPath") + "template/";
	}
	

	/**
	 * 엑셀 셈플 다운로드 경로
	 */
	public String getExcelFileSampleDownPath() {
		return CommonUtil.getInstance().getServletProp("icignal.context.resource.file-sample-path");
	}
	public String getExcelFileSampleDownPath2() {
		return CommonUtil.getInstance().getServletProp("icignal.context.resource.excelFileUploadPath");
	}

	public String getQimUrlPath() {
		return CommonUtil.getInstance().getServletProp("qim.url");
	}

	/**
	 * IFVCommon 에 getDbType 메소드가 있으나,
	 * 해당 메소드는 enum 타입 리턴이라 String 형으로 리턴해주는 메소드 추가
	 *
	 * 2017. 12. 21. 이기오.
	 * */
	public String getDatabaseType() {
		return CommonUtil.getInstance().getServletProp("jdbc.dbType");
	}

	/*
	 * 권한그룹 유형
	 */
	public static enum AUTH_GROUP_TYPE_CD {
		/*
		 * VOC
		 */
		VOC,
		/*
		 * 상담원
		 */
		ADVISER,
		/*
		 * 상담원 관리자
		 */
		ADVISER_MGT,
		/*
		 * 관리자
		 */
		MKT_MASTER
	}

	/**
	 * @name : PROMOTION_STATUS
	 * @date : 2017. 8. 9.
	 * @author : "dg.ryu"
	 * @description : 프로모션 상태
	 */
	public enum PROMOTION_STATUS {
		/**
		  * 신규
		  */
		 NEW("1"),
		/**
		  * 변경
		  */
		 EDIT("2"),
		 /**
		  * 중지
		  */
		 STOP("3");

		private String value;
		private PROMOTION_STATUS(String value) {
			this.value = value;
		}

		public String getValue() {
			return value;
		}

	}

    /**
     * 이벤트 트리거 실행 상태
     *
     * @name : infavor.util.EVENT_TRIGGER_STATUS
     * @date : 2018. 5. 2.
     * @author : jh.kim
     * @description :
     */
    public enum EVENT_TRIGGER_STATUS {
        /**
         * 실행중
         */
        RUNNING,
        /**
         * 중지
         */
        STOP,
    }

	/**
	 * QIM 인터페이스ID
	 */
	public static enum QIM_INTERFACE_ID {
		/**
		 * 승인전송 프로모션룰 저장
		 */
		CAM_1001
	}

	/**
	 * @name infavor.util.DECRYPT_TYPE
	 * @date 2018. 10. 29.
	 * @author jh.kim
	 * @description 복호화 유형
	 */
	public static enum DECRYPT_TYPE {
        /**
         * 주민번호
         */
        PRIVACY_NUM,
        /**
         * 카드번호
         */
        CARD_NUM,
        CARD_NUMBER,
        CARD_NUM_MASK,
        /**
         * 카드패스워드
         */
        CARD_PWD,
        /**
         * 주소상세
         */
        ADDR_DETAIL,
        /**
         * 폰번호 (010-1234-5***)
         */
        PHONE_NUM,
        /**
         * 폰번호 (010-****-5678)
         */
        PHONE_NUM2,
        /**
         * 여권번호
         */
        PASSPORT_NUM,
        /**
         * 법인번호
         */
        L_PERSON_NUM,
        /**
         * 이메일 (ab***@gmail.com)
         */
        EML,
        /**
         * 생년월일
         */
        BIRTH_DATE,
    }

	/**
	* @name : infavor.util.PNT_TXN_TYPE
	* @date : 2018. 12. 3.
	* @author : hy.jun
	* @description : 포인트 거래유형 (PNT_TXN_TYPE)
	*/
	public enum PNT_TXN_TYPE {
		/**
		 * 적립
		 */
		ACRL("100"),
		/**
		 * 사용
		 */
		RDM("200");

		private String value;
		private PNT_TXN_TYPE(String value) {
			this.value = value;
		}

		public String getValue() {
			return value;
		}
	}

	/**
	* @name : infavor.util.CAMPAIGN_PROGRAM_TYPE
	* @date : 2018. 12. 4.
	* @author : hy.jun
	* @description : 마케팅 / 프로모션 캠페인 구분 (WF_NODE_MST.TYPE)
	 */
    public enum CAMPAIGN_PROGRAM_TYPE {
        /**
         * 마케팅 캠페인
         */
        MKT,
        /**
         * 프로모션 캠페인 (=로열티 시스템)
         */
        Loy,
    }

	/**
	* @name : infavor.util.MKT_ELEC_APRV_TYPE
	* @date : 2018. 12. 5.
	* @author : hy.jun
	* @description : 승인업무 유형
	*/
	public enum MKT_ELEC_APRV_TYPE {
		/**
		 * 캠페인
		 */
		CAMPAIGN("01");

		private String value;
		private MKT_ELEC_APRV_TYPE(String value) {
			this.value = value;
		}

		public String getValue() {
			return value;
		}
	}

	/**
	* @name : infavor.util.COM_AUTH_LOG_TYPE_CD
	* @date : 2019. 1. 25.
	* @author : hy.jun
	* @description : 권한 변경로그 유형
	*/
	public enum COM_AUTH_LOG_TYPE_CD {
		/**
		 * 권한그룹 관련 변경로그
		 */
		AUTH_GROUP,
		/**
		 * 권한 관련 변경로그
		 */
		AUTH,
		/**
		 * 사용자 관련 변경로그
		 */
		USER,
	}

	/**
	* @name : infavor.util.LOG_TYPE_DTL
	* @date : 2019. 1. 25.
	* @author : hy.jun
	* @description : 권한 변경로그 유형상세
	*/
	public enum LOG_TYPE_DTL {
		/**
		 * 사용자 생성
		 */
		USER_C,
		/**
		 * 사용자 삭제
		 */
		USER_D,
		/**
		 * 권한그룹 - 사용자 추가
		 */
		USER_A,
		/**
		 * 권한그룹 - 사용자 제거
		 */
		USER_R,
		/**
		 * 권한그룹 생성
		 */
		AUTH_GROUP_C,
		/**
		 * 권한그룹 삭제
		 */
		AUTH_GROUP_D,
		/**
		 * 권한 생성
		 */
		AUTH_C,
		/**
		 * 권한 삭제
		 */
		AUTH_D,
		/**
		 * 권한그룹 - 권한 추가
		 */
		AUTH_A,
		/**
		 * 권한그룹 - 권한 제거
		 */
		AUTH_R,
	}

    /**
     * 세그먼트 필터 유형 코드
     */
    public enum ANL_SEG_FILTER_TYPE_CD {
    	/**
    	 * 기본필터
    	 */
    	DEFAULT,
    	/**
    	 * 그룹함수 필터
    	 */
    	GROUP_FUNC,
    	/**
    	 * 조합필터(합집합)
    	 */
    	UNION,
    	/**
    	 * 조합필터(교집합)
    	 */
    	INTERSECTION,
    	/**
    	 * 조합필터(A차집합)
    	 */
    	A_DIFF_SET,
    	/**
    	 * 조합필터(B차집합)
    	 */
    	B_DIFF_SET,
    	/**
    	 * 전체건수
    	 */
    	ALL
    }

	/**
	* @name : infavor.util.Loy_STMP_APPLY_CHNL_CD
	* @date : 2019. 3. 14.
	* @author : hy.jun
	* @description : 스탬프적용 채널 코드
	*/
	public enum Loy_STMP_APPLY_CHNL_CD {
		/**
		 * 전체
		 */
		ALL_CHNL("01"),
		/**
		 * 매장포함
		 */
		INCLUDE_CHNL("02"),
		/**
		 * 매장제외
		 */
		EXCEPT_CHNL("03");

		private String value;
		private Loy_STMP_APPLY_CHNL_CD(String value) {
			this.value = value;
		}

		public String getValue() {
			return value;
		}
	}

	/**
	 * @name : infavor.util.Loy_STMP_CALC_TYPE_CD
	 * @date : 2019. 3. 14.
	 * @author : hy.jun
	 * @description : 스탬프 계산유형 코드
	 */
	public enum Loy_STMP_CALC_TYPE_CD {
		/**
		 * 단일거래
		 */
		COND_SINGLE("01"),
		/**
		 * 누적거래
		 */
		COND_MULTIPLE("02");

		private String value;
		private Loy_STMP_CALC_TYPE_CD(String value) {
			this.value = value;
		}

		public String getValue() {
			return value;
		}
	}

	/**
	 * @name : infavor.util.Loy_STMP_CALC_TYPE_SUB_CD
	 * @date : 2019. 3. 14.
	 * @author : hy.jun
	 * @description : 스탬프 계산유형 상세코드
	 */
	public enum Loy_STMP_CALC_TYPE_SUB_CD {
		/**
		 * 구매금액
		 */
		PURAMT("A"),
		/**
		 * 방문횟수
		 */
		PURCNT("B"),
		/**
		 * 구매금액AND방문횟수
		 */
		PURAMT_AND_PURCNT("C");

		private String value;
		private Loy_STMP_CALC_TYPE_SUB_CD(String value) {
			this.value = value;
		}

		public String getValue() {
			return value;
		}
	}

	/**
	 * @name : infavor.util.Loy_STMP_SATUS_CD
	 * @date : 2019. 3. 14.
	 * @author : hy.jun
	 * @description : 스탬프 계산유형 상세코드
	 */
	public enum Loy_STMP_SATUS_CD {
		/**
		 * 작업중
		 */
		W,
		/**
		 * 활성
		 */
		A,
		/**
		 * 비활성
		 */
		I
	}
	
	public static String getServletProperty(String key){
		
		return CommonUtil.getInstance().getServletProp(key);
	}

	/**
	 * 피로도 상태 속성
	 *
	 * @author : 윤법공
	 */
	public enum FATIGUE_STATE_TYPE {
		/**
		* 적용중
		 */
		A("S"),
		/**
		 * 미적용중
		 */
		S("A");

		private final String changeValue;

		FATIGUE_STATE_TYPE(String changeValue){
			this.changeValue = changeValue;
		}

		public static FATIGUE_STATE_TYPE find(String changeValue) {
			return Arrays.stream(values())
					.filter(fatigue_state_type -> fatigue_state_type.changeValue.equals(changeValue))
					.findAny()
					.orElse(null);
		}
	}

	/**
	 * 설문 상세 이미지 타입
	 *
	 * @author : 윤법공
	 */
	public enum SURVEY_DETAIL_IMAGE_TYPE {
		/**
		 * 시작이미지
		 */
		START,
		/**
		 *종료이미지
		 */
		END
	}
}