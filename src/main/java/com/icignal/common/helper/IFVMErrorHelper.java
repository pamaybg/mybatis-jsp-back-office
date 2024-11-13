package com.icignal.common.helper;

/**
 * 헬퍼 클래스
 *
 * @author jskim
 *
 */
public class IFVMErrorHelper extends ErrorHelper {

	/**
	 * <b>BEACON_DATA_UNHANDLED</b> : 비콘 관련 오류<br>
	 */
	public final static int BEACON_DATA_UNHANDLED = 300500; //비콘 관련 오류
	/**
	 * <b>BEACON_DATA_UNAUTHORIZED</b> : 비콘 api키 인증 실패<br>
	 */
	public final static int BEACON_DATA_UNAUTHORIZED = 300510; //비콘 api키 인증 실패
	/**
	 * <b>WEBSERVICE_RESULT_FAIL</b> : 웹서비스 결과 실패<br>
	 */
	public final static int WEBSERVICE_CALL_FAIL = 600500; //웹서비스 결과 실패
	/**
	 * <b>MSG_3001</b> : 등록된 API 정보가 없음<br>
	 */
	public final static String MSG_3001 = "MSG_3001"; // : 등록된 API 정보가 없음

	public final static int MARKETING_QUERY_NOTMATCH = 400100; //쿼리 문자열 불일치

	public final static int MARKETING_QUERY_NOTCOUNT = 400200; //쿼리 카운트 불일치

	public final static int MARKETING_QUERY_NOQUERY = 400300; //쿼리 없음

	public final static int MARKETING_QUERY_NOPROMPT = 400400; //프롬프트 없음

	//캠페인 발송 시 유효성 에러

	public final static int MARKETING_NOCAMPAIGNINFO= 500100; //캠페인 정보 없음

	public final static int MARKETING_NOSEGMENTINFO = 500200; //세그먼트 없음

	public final static int MARKETING_NOCONTENTSINFO = 500300; //컨텐츠 없음

	//결재 승인자 추가 시 에러

	public final static int APPROVER_COUNT_CHECK = 700100; //결재 승인자 최대 수 초과

	//테스트 발송 관련 에러

	public final static int SEND_TEST_TRANCE_CHCK = 800100; //테스트 발송 중 개인화 속성 변환을 하지 못할 시 오류

	//컬럼, 테이블 타입 체크

	public final static int OUTALBE_TYPE_CHECK = 900100; //컬럼과 테이블 타입의 유형이 하나 이상일 시 발생하는 오류

	//시퀀스 중복 에러
	public final static int SEQUENCE_DUPLICATION_CHCK = 900001;	//시퀀스 중복 에러

	//name 중복 에러
	public final static int NAME_DUPLICATION_CHCK = 900002;	//명칭 중복 에러

	//코드 중복 에러
	public final static int CODE_DUPLICATION_CHCK = 900003;	//코드 중복 에러

	//고객 중복 에러
	public final static int CUST_DUPLICATION_CHCK = 900004;	//고객 중복 에러(식별값 체크)

	//하위 필터가 존재 합니다. 하위 필터를 먼저 삭제하여 주세요.
	public final static String MSG_S0001 = "MSG_S0001";
	
	//그룹함수 상세가 올바르지 않습니다.
	public final static String MSG_S0002 = "MSG_S0002";
	
	//선택된 로지컬 컴포넌트가 세그먼트 사용에 적합하지 않습니다.
	public final static String MSG_S0003 = "MSG_S0003";
	
	//로지컬 컴포넌트가 올바르지 않습니다.
	public final static String MSG_S0004 = "MSG_S0004";
	
	//세그먼트 필터가 올바르지 않습니다.
	public final static String MSG_S0005 = "MSG_S0005";
	
	//세그먼트 필터 생성시 오류가 발생하였습니다.
	public final static String MSG_S0006 = "MSG_S0006";
	
	//타겟그룹 대상자 건수 조회 오류
	public final static String MSG_T0001 = "MSG_T0001";
	
	/** 로그인 오류 */
	public final static String MSG_3012 = "MSG_3012";//입력하신 아이디 또는 비밀번호를 다시 확인하여 주시기 바랍니다.
	
	/** 미등록 고객 */
	public final static String MSG_3013 = "MSG_3013";//등록되지 않은 고객 입니다.
	
	/** 같은 비밀번호 변경 */
	public final static String MSG_3014 = "MSG_3014";//같은 비밀번호로 변경할 수 없습니다.
	
	/** 이미 인증된 회원 */
	public final static String MSG_3015 = "MSG_3015";//이미 인증확인된 회원입니다.
	
	/** 이미 등록된 회원 */
	public final static String MSG_3016 = "MSG_3016";//이미 가입하신 회원입니다.
	
	/** 아이디 중복 */
	public final static String MSG_3017 = "MSG_3017";//이미 사용중인 아이디 입니다.
	
	/** 인증확인값 없음 */
	public final static String MSG_3018 = "MSG_3018";//인증확인값이 없습니다.
	
	/** 인증확인값 유효일 만료 */
	public final static String MSG_3019 = "MSG_3019";//인증확인값 유효일이 만료되었습니다.
	
	/** 비밀번호 틀림 */
	public final static String CN010317 = "CN010317";//입력하신 비밀번호를 다시 확인하여 주시기 바랍니다.
	
	/** 추천인코드 오류 */
	public final static String MSG_3020 = "MSG_3020";//입력하신 추천인코드 정보를 다시 확인하여 주시기 바랍니다.
	
	/** 14세 미만 회원가입 불가 */
	public final static String MSG_3022 = "MSG_3022";//만 14세 이상 본인인증이 가능하신 분만 가입이 가능합니다.
	
	/** 결제 실패 */
	public final static String MSG_3023 = "MSG_3023";//페이 런처 결제를 실패하였습니다.
	
	/** POS Push 발송 실패 */
	public final static String MSG_3024 = "MSG_3024";//POS Push 발송 실패하였습니다.

	/** 세그먼트 생성 실패 */
	public final static String MSG_3025 = "MSG_3025";//세그먼트 생성에 실패하였습니다.
	
	/**
	 * Qpid
	 */
	public static final int PUSH_SFTP_EXCEPTION = 400600;
	public static final int PUSH_SFTP_FILENOTFOUND = 400700;
}