package com.icignal.common.helper;


/**
 * ErrorHelper 클래스
 * 
 * @author jskim
 */
public class ErrorHelper {
	/**
	 * <b>LOGIN_WRONG_USER_INFO</b> : 아이디/패스워드 잘못됨 <br>
	 */
	public final static int LOGIN_WRONG_USER_INFO = 100400;	//아이디/패스워드 잘못됨
	/**
	 * <b>LOGIN_NOT_JOIN_USER</b> : SNS로그인 시 가입 회원이 아닐경우 요청 <br>
	 */
	public final static int LOGIN_NOT_JOIN_USER = 100410; // SNS로그인 시 가입 회원이
															// 아닐경우 요청
	/**
	 * 이전 패스워드 잘못됨
	 */
	public final static int LOGIN_WRONG_BEFORE_PASSWD = 100500; //이전 패스워드 잘못됨
	/**
	 * <b>DATA_FAIL</b> : Delete & Update 실패<br>
	 */
	public final static int DATA_FAIL = 200300; //Delete & Update 실패
	/**
	 * <b>DATA_DUPLICATION</b> : 데이타 중복<br>
	 */
	public final static int DATA_DUPLICATION = 200310; //데이타 중복
	/**
	 * <b>DATA_BAD_REQUEST</b> : 클라이언트의 잘못된 요청으로 처리할 수 없음<br>
	 */
	public final static int DATA_BAD_REQUEST = 200400; //클라이언트의 잘못된 요청으로 처리할 수 없음
	/**
	 * <b>DATA_UNAUTHORIZED</b> : 인증 실패 인증을 요청 --> 재로그인<br>
	 */
	public final static int DATA_UNAUTHORIZED = 200410; //클라이언트의 - 인증 실패 인증을 요청 --> 재로그인
	/**
	 * <b>DATA_FORBIDDEN</b> : 접근이 거부된 문서를 요청함(권한)<br>
	 */
	public final static int DATA_FORBIDDEN = 200420; //접근이 거부된 문서를 요청함(권한)
	/**
	 * <b>DATA_UNAUTHORIZED</b> : 권한 오류 --> 정회원 인증 요청<br>
	 */
	public final static int DATA_NOT_PERMISSION = 200430; //권한 오류 --> 정회원 인증 요청
	/**
	 * <b>SITE_NOT_PERMISSION</b> : 사이트 권한 오류 --> 비공개 & 비밀 페이버 접근 권한 없음<br>
	 */
	public final static int SITE_NOT_PERMISSION = 200440; //비공개 & 비밀 페이버 접근 권한 없음
	/**
	 * <b>SITEMNG_NOT_PERMISSION</b> : 사이트 관리 권한 오류 --> 페이버 관리 페이지 접근 권한 없음<br>
	 */
	public final static int SITEMNG_NOT_PERMISSION = 200450; //페이버 관리 페이지 접근 권한 없음
	/**
	 * <b>BEACON_MNG_NOT_PERMISSION</b> : 비콘 관리 페이지 권한 오류 --> 비콘 관리 페이지 접근 권한 없음<br>
	 */
	public final static int BEACON_MNG_NOT_PERMISSION = 200460; //비콘 관리 페이지 접근 권한 없음
	/**
	 * <b>DATA_UNHANDLED</b> : 서버 오류<br>
	 */
	public final static int DATA_UNHANDLED = 200500; //서버 오류
	/**
	 * <b>DATA_BAN_REQUEST</b> : 금칙어 포함 오류<br>
	 */
	public final static int DATA_BAN_WORD_REQUEST = 200600; // 금칙어 포함 오류
	/**
	 * <b>BENEFIT_VALIDATION</b> : 혜택 유효성 에러<br>
	 */
	public final static int BENEFIT_VALIDATION = 200700; // 혜택 유효성 에러

	/**
	 * <b>BEACON_DATA_UNHANDLED</b> : 비콘 관련 오류<br>
	 */
	public final static int BEACON_DATA_UNHANDLED = 300500; //비콘 관련 오류
	/**
	 * <b>BEACON_DATA_UNAUTHORIZED</b> : 비콘 api키 인증 실패<br>
	 */
	public final static int BEACON_DATA_UNAUTHORIZED = 300510; // 비콘 api키 인증 실패
	/**
	 * <b>PUSH_CANONICALREGID</b> : 하나 이상의 토큰 아이디 사용<br>
	 */
	public final static int PUSH_CANONICALREGID = 400100; // 하나 이상의 토큰 아이디 사용

	/**
	 * <b>PUSH_DATA_UNHANDLED</b> : 푸쉬 관련 오류<br>
	 */
	public final static int PUSH_DATA_UNHANDLED = 400500; //푸쉬 관련 오류
	/**
	 * <b>AUTH_SMS_DATA_UNHANDLED</b> : SMS 인증 관련 오류<br>
	 */
	public final static int AUTH_SMS_DATA_UNHANDLE = 500100; // SMS 인증 관련 오류

	/**
	 * <b>AUTH_MOBILIANS_DATA_UNHANDLE</b> : 모빌리언스 인증 관련 오류<br>
	 */
	public final static int AUTH_MOBILIANS_DATA_UNHANDLE = 500200; // 모빌리언스 인증
																	// 관련 오류
	/**
	 * <b>AUTH_MEMBER_JOIN_DATA_UNHANDLE</b> : 인증 회원 가입 관련 오류<br>
	 */
	public final static int AUTH_MEMBER_JOIN_DATA_UNHANDLE = 600100; // 인증 회원 가입
																		// 관련 오류
	/**
	 * <b>WEBSERVICE_RESULT_FAIL</b> : 웹서비스 결과 실패<br>
	 */
	public final static int WEBSERVICE_CALL_FAIL = 600500; // 웹서비스 결과 실패

	/**
	 * <b>MSG_1000</b> : 권한이 없습니다.<br>
	 */
	public final static String MSG_1000 = "MSG_1000"; // : 권한이 없습니다.
	/**
	 * <b>MSG_1001</b> : 작업도중 실패<br>
	 */
	public final static String MSG_1001 = "MSG_1001"; // : 작업도중 실패
	/**
	 * <b>MSG_1002</b> : 파일 용량초과<br>
	 */
	public final static String MSG_1002 = "MSG_1002"; // : 파일 용량초과
	/**
	 * <b>MSG_1003</b> : 글자수 초과<br>
	 */
	public final static String MSG_1003 = "MSG_1003"; // : 글자수 초과
	/**
	 * <b>MSG_1004</b> : SQL 에러<br>
	 */
	public final static String MSG_1004 = "MSG_1004"; // : SQL 에러
	/**
	 * <b>MSG_1005</b> : 이름 중복<br>
	 */
	public final static String MSG_1005 = "MSG_1005"; // : 이름 중복
	/**
	 * <b>MSG_1006</b> : 전화번호 중복<br>
	 */
	public final static String MSG_1006 = "MSG_1006"; // : 전화번호 중복
	/**
	 * <b>MSG_1007</b> : 이름과 전화번호 동시 중복<br>
	 */
	public final static String MSG_1007 = "MSG_1007"; // : 이름과 전화번호 동시 중복 
	/**
	 * <b>MSG_1008</b> : 이메일 중복<br>
	 */
	public final static String MSG_1008 = "MSG_1008"; // : 이메일 중복 
	/**
	 * <b>MSG_1009</b> : 메시지 자기 자신 보냄<br>
	 */
	public final static String MSG_1009 = "MSG_1009"; // : 메시지 자기 자신 보냄
	/**
	 * <b>MSG_1010</b> : Facebook 토큰 만료<br>
	 */
	public final static String MSG_1010 = "MSG_1010"; // : Facebook 토큰 만료
	/**
	 * <b>MSG_1011</b> : URL 중복<br>
	 */
	public final static String MSG_1011 = "MSG_1011"; // : URL 중복
	/**
	 * <b>MSG_1012</b> : 휴대폰 번호를 확인해주세요.<br>
	 */
	public final static String MSG_1012 = "MSG_1012"; // : 휴대폰 번호를 확인해주세요.
	/**
	 * <b>MSG_1012</b> : 해당 스토어에서 진행중인 스탬프가 없습니다.<br>
	 */
	public final static String MSG_1013 = "MSG_1013"; // : 해당 스토어에서 진행중인 스탬프가
														// 없습니다.
	/**
	 * <b>MSG_1012</b> : 중복된 데이터가 이미 있습니다.<br>
	 */
	public final static String MSG_1014 = "MSG_1014"; // : 중복된 데이터가 이미 있습니다.
	/**
	 * <b>MSG_1012</b> : 적립스탬프 수량을 확인해주세요.<br>
	 */
	public final static String MSG_1015 = "MSG_1015"; // : 적립스탬프 수량을 확인해주세요.
	/**
	 * <b>MSG_1012</b> : 이메일을 잘못 입력하셨습니다.<br>
	 */
	public final static String MSG_1016 = "MSG_1016"; // : 이메일을 잘못 입력하셨습니다.
	/**
	 * <b>MSG_1012</b> : 온라인 정보가 다른사용자에 의해 수정되었습니다. \\\\n 화면을 새로고침 합니다.<br>
	 */
	public final static String MSG_1017 = "MSG_1017"; // : 온라인 정보가 다른사용자에 의해
														// 수정되었습니다. \\\\n 화면을
														// 새로고침 합니다.
	/**
	 * <b>MSG_1012</b> : 실행중인 쿠폰이 있습니다.<br>
	 */
	public final static String MSG_1018 = "MSG_1018"; // : 실행중인 쿠폰이 있습니다.
	/**
	 * <b>MSG_1012</b> : 사용가능한 배너는 최대 5개입니다.<br>
	 */
	public final static String MSG_1019 = "MSG_1019"; // : 사용가능한 배너는 최대 5개입니다.
	/**
	 * <b>MSG_2000</b> : 비콘 서버 에러<br>
	 */
	public final static String MSG_2000 = "MSG_2000"; // : 비콘 서버 에러
	/**
	 * <b>MSG_2001</b> : 활성 워크 플로우 없음<br>
	 */
	public final static String MSG_2001 = "MSG_2001"; // : 활성 워크 플로우 없음
	/**
	 * <b>MSG_2002</b> : 회원 정보 없음<br>
	 */
	public final static String MSG_2002 = "MSG_2002"; // : 회원 정보 없음
	/**
	 * <b>MSG_2003</b> : 스토어 정보 없음<br>
	 */
	public final static String MSG_2003 = "MSG_2003"; // : 스토어 정보 없음
	/**
	 * <b>MSG_2004</b> : 사이트 정보 없음<br>
	 */
	public final static String MSG_2004 = "MSG_2004"; // : 사이트 정보 없음
	/**
	 * <b>MSG_2005</b> : 계약 만료된 스토어<br>
	 */
	public final static String MSG_2005 = "MSG_2005"; // : 계약 만료된 스토어
	/**
	 * <b>MSG_2051</b> : 스탬프 조회시 대상 스탬프 없음<br>
	 */
	public final static String MSG_2051 = "MSG_2051"; // : 스탬프 조회시 대상 스탬프 없음
	/**
	 * <b>MSG_2052</b> : 스탬프 신규 발행시 다운로드 기간 종료<br>
	 */
	public final static String MSG_2052 = "MSG_2052"; // : 스탬프 신규 발행시 다운로드 기간 종료
	/**
	 * <b>MSG_2053</b> : 존재 하지 않는 스탬프<br>
	 */
	public final static String MSG_2053 = "MSG_2053"; // : 존재 하지 않는 스탬프
	/**
	 * <b>MSG_2061</b> : 쿠폰 조회시 대상 쿠폰 없음<br>
	 */
	public final static String MSG_2061 = "MSG_2061"; // : 쿠폰 조회시 대상 쿠폰 없음
	/**
	 * <b>MSG_2062</b> : 쿠폰 신규 발행시 다운로드 기간 종료<br>
	 */
	public final static String MSG_2062 = "MSG_2062"; // : 쿠폰 신규 발행시 다운로드 기간 종료
	/**
	 * <b>MSG_2101</b> : 존재 하지 않는 쿠폰<br>
	 */
	public final static String MSG_2101 = "MSG_2101"; // : 존재 하지 않는 쿠폰
	/**
	 * <b>MSG_2102</b> : 발행중이 아닌 쿠폰<br>
	 */
	public final static String MSG_2102 = "MSG_2102"; // : 발행중이 아닌 쿠폰
	/**
	 * <b>MSG_2103</b> : 다운로드 기간이 아닌 쿠폰<br>
	 */
	public final static String MSG_2103 = "MSG_2103"; // : 다운로드 기간이 아닌 쿠폰
	/**
	 * <b>MSG_2104</b> : 총 발급 수를 초과한 쿠폰<br>
	 */
	public final static String MSG_2104 = "MSG_2104"; // : 총 발급 수를 초과한 쿠폰
	/**
	 * <b>MSG_2105</b> : 삭제된 쿠폰<br>
	 */
	public final static String MSG_2105 = "MSG_2105"; // : 삭제된 쿠폰
	/**
	 * <b>MSG_2106</b> : 이미 사용 완료 된 쿠폰 입니다<br>
	 */
	public final static String MSG_2106 = "MSG_2106"; // : 이미 사용 완료 된 쿠폰 입니다
	/**
	 * <b>MSG_2107</b> : 사용 기간 만료된 쿠폰 입니다<br>
	 */
	public final static String MSG_2107 = "MSG_2107"; // : 사용 기간 만료된 쿠폰 입니다
	/**
	 * <b>MSG_2108</b> : 반복 발행 횟수 제한으로 인하여 발행이 안되는 쿠폰<br>
	 */
	public final static String MSG_2108 = "MSG_2108"; // : 반복 발행 횟수 제한으로 인하여 발행이
														// 안되는 쿠폰
	/**
	 * <b>MSG_2109</b> : 사용하지 않은 쿠폰<br>
	 */
	public final static String MSG_2109 = "MSG_2109"; // : 사용하지 않은 쿠폰
	/**
	 * <b>MSG_2201</b> : 존재 하지 않는 스탬프<br>
	 */
	public final static String MSG_2201 = "MSG_2201"; // : 존재 하지 않는 스탬프
	/**
	 * <b>MSG_2202</b> : 발행중이 아닌 스탬프<br>
	 */
	public final static String MSG_2202 = "MSG_2202"; // : 발행중이 아닌 스탬프
	/**
	 * <b>MSG_2203</b> : 다운로드 기간이 아닌 스탬프<br>
	 */
	public final static String MSG_2203 = "MSG_2203"; // : 다운로드 기간이 아닌 스탬프
	/**
	 * <b>MSG_2204</b> : 총 발급 수를 초과한 스탬프<br>
	 */
	public final static String MSG_2204 = "MSG_2204"; // : 총 발급 수를 초과한 스탬프
	/**
	 * <b>MSG_2205</b> : 삭제된 스탬프<br>
	 */
	public final static String MSG_2205 = "MSG_2205"; // : 삭제된 스탬프
	/**
	 * <b>MSG_2206</b> : 이미 사용 완료 된 스탬프 입니다<br>
	 */
	public final static String MSG_2206 = "MSG_2206"; // : 이미 사용 완료 된 스탬프 입니다
	/**
	 * <b>MSG_2207</b> : 사용 기간 만료된 스탬프 입니다<br>
	 */
	public final static String MSG_2207 = "MSG_2207"; // : 사용 기간 만료된 스탬프 입니다
	/**
	 * <b>MSG_2208</b> : 반복 발행 횟수 제한으로 인하여 발행이 안되는 스탬프<br>
	 */
	public final static String MSG_2208 = "MSG_2208"; // : 반복 발행 횟수 제한으로 인하여 발행이
														// 안되는 스탬프
	/**
	 * <b>MSG_2209</b> : 이미 발행중인 카드가 있습니다.<br>
	 */
	public final static String MSG_2209 = "MSG_2209"; // : 이미 발행중인 카드가 있습니다.
	/**
	 * <b>MSG_2210</b> : 적립 수량 미달된 카드입니다.<br>
	 */
	public final static String MSG_2210 = "MSG_2210"; // : 적립 수량 미달된 카드입니다.
	/**
	 * <b>MSG_2211</b> : 미사용된 스탬프<br>
	 */
	public final static String MSG_2211 = "MSG_2211"; // : 미사용된 스탬프
	/**
	 * <b>MSG_2212</b> : 발행 중인 스탬프<br>
	 */
	public final static String MSG_2212 = "MSG_2212"; // : 발행 중인 스탬프
	/**
	 * <b>MSG_2213</b> : 혜택 사용시 종료되는 스탬프는 사용 취소할수 없습니다.<br>
	 */
	public final static String MSG_2213 = "MSG_2213"; // : 혜택 사용시 종료되는 스탬프는 사용
														// 취소할수 없습니다.
	/**
	 * <b>MSG_2214</b> : 적립 기간이 만료된 스탬프입니다.<br>
	 */
	public final static String MSG_2214 = "MSG_2214"; // : 적립 기간이 만료된 스탬프입니다
	/**
	 * <b>MSG_4001</b> : 푸쉬 관련 오류<br>
	 */
	public final static String MSG_4001 = "MSG_4001"; // : 푸쉬 관련 오류
	/**
	 * <b>MSG_3001</b> : 등록된 API 정보가 없음<br>
	 */
	public final static String MSG_3001 = "MSG_3001"; // : 등록된 API 정보가 없음
	/**
	 * <b>MSG_4002</b> : 푸쉬 토큰 중복<br>
	 */
	public final static String MSG_4002 = "MSG_4002"; // : 푸쉬 토큰 중복
	/**
	 * <b>MSG_5001</b> : 비정산적인 접근<br>
	 */
	public final static String MSG_5001 = "MSG_5001"; // : 비정산적인 접근
	/**
	 * <b>MSG_5002</b> : 요청시간경과<br>
	 */
	public final static String MSG_5002 = "MSG_5002"; // : 요청시간경과
	/**
	 * <b>MSG_5003</b> : IP불일치<br>
	 */
	public final static String MSG_5003 = "MSG_5003"; // : IP불일치
	/**
	 * <b>MSG_5004</b> : 이미 인증된 전화번호<br>
	 */
	public final static String MSG_5004 = "MSG_5004"; // : 이미 인증된 전화번호
	/**
	 * <b>MSG_5005</b> : 인증 요청 횟수 초과<br>
	 */
	public final static String MSG_5005 = "MSG_5005"; // : 인증 요청 횟수 초과
	/**
	 * <b>MSG_6001</b> : 회원 가입 실패<br>
	 */
	public final static String MSG_6001 = "MSG_6001"; // : 회원 가입 실패
	/**
	 * <b>MSG_6002</b> : 회원 가입시 약관 동의 저장 실패<br>
	 */
	public final static String MSG_6002 = "MSG_6002"; // : 회원 가입시 약관 동의 저장 실패
}
