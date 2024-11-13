package com.icignal.loyalty.membership.dto.response;

import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;
import com.icignal.core.annotation.personaldata.Decrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

@PersonalData
@CommCode
public class LoyCorpMbrDetailPopResDto {
	private String rid;
	private String empId; 						/*등록자 RID*/
	private String commitYn; 						/*commitYn*/
	
	private String chnlNm;
	private String pgmNm;
	
	private String pgmNo;  									/* 프로그램 번호 */
	private String custtypecd; 								/* 고객유형 (I: 개인, C: 법인) */	
	
	private String mbrTypeCd;   							/* 회원 유형코드(개인무료멤버십	 : P1, 개인유료멤버십 : P2, 법인멤버십 : C1) */
	private String chnlNo;   									/* 가입점 채널 번호 */
	private String prStoreCd;   									/* 주거래 매장 */
	private String prStoreNm;   									
	private String sbscPathCd;  							/* 가입경로 ( 온라인(멤버십WEB)	: A1, 오프라인(매장):C1, POS:B1, 콜센터(CS):D1, 제휴사: E1, 기타:Z1 ) */
    private String sbscDeviceCd;   						/* 가입디바이스 ( PC_WEB,MOBIL_WEB,MOBIL_APP) */
	
	/* 인증 */
    @Decrypted(masked = "none")
    private String cust_nm;  						/* 고객명(대표) */
    @Decrypted(masked = "none")
	private String cust_nm_add;  				/* 고객명(선택) */
	private String birthdt;						/* 생년월일 */
	private String lunar_cd;					/* 양음력 (  음력: 10 , 양력 : 20 ) */
	private String gen_cd; 							/* 성별 */
	private String nlty;								/* 국적	*/
	
	@Decrypted(masked = "none")
	private String email;							/* 이메일 */
	@Decrypted(masked = "none")
	private String hhp;								/* 휴대폰 */
	@Decrypted(masked = "none")
    private String zip;								/* 우편번호 */
	private String adres;	 						/* 주소(기본) */
	@Decrypted(masked = "none")
	private String bunji;		 					/* 주소 (상세) */
	
	private String bCode; 						/* 법정동코드 */
	
	private String mrrg_yn;             			/* 결혼여부 */
	private String annvrsry;  					/* 기념일 */
	private String annvrsry_type_cd;		/* 기념일 구분 */
	private String frgnrNo;      				/* 외국인번호 */
	private String native_yn;    				/*내국인여부(내국인:Y, 외국인:N) */
	
	private String wrc_nm;        				/* 직장명 */
	private String pstn;          				/* 직위 */
	private String empNo;						/* 사번 */
	
    private String zip_add;								/* 우편번호 (추가) */
	private String adres_add;	 						/* 주소(기본) (추가) */
	private String bunji_add;		 					/* 주소 (상세) (추가) */
	
	private String bCodeAdd; 						/* 법정동코드 (추가) */
	
    private String certTypeCd;  				/*  인증유형 ( CI, SNS, NO_CERT ) */
    private String certSubTypeCd;			/* 인증서브유형코드 */
    @Decrypted(masked = "none")
    private String certVal;						/* 인증값 */
    
	private String loginTypeCd;				/* 로그인타입코드 LOY_LOGIN_TYPE_CD : WEB_ID,  KAKAO,  NAVER, FACEBOOK , CI */
	@Decrypted(masked = "none")
	private String user_id;						/* WEB 로그인 ID */
	private String user_pwd;					/* WEB 로그인 패스워드 */
	
	private String rcmmd_no;					/* 추천인번호 */
	private int drmncyChngUnit;      	/* 휴면전환(년) */
	
	//법정대리인
	private String laName;      	/* 법정대리인명 */
	private String laCertVal;      	/*  법정대리인 CI값 */
	private String laAgreDt;      	/* 법정대리인동의일시 */
	
	private String snsTypeCd;
	@MarkName(groupCode = "LOY_SNS_TYPE_CD", codeField = "snsTypeCd")
	private String snsTypeCdNm;
	private String snsAddr;
	private String tel_no;
	
	private String ceo;
	private String bizrNo;
	private String charger;
	private String induty;
	private String bizcnd;
	
	
	
	
	public String getCeo() {
		return ceo;
	}
	public void setCeo(String ceo) {
		this.ceo = ceo;
	}
	public String getBizrNo() {
		return bizrNo;
	}
	public void setBizrNo(String bizrNo) {
		this.bizrNo = bizrNo;
	}
	public String getCharger() {
		return charger;
	}
	public void setCharger(String charger) {
		this.charger = charger;
	}
	public String getInduty() {
		return induty;
	}
	public void setInduty(String induty) {
		this.induty = induty;
	}
	public String getBizcnd() {
		return bizcnd;
	}
	public void setBizcnd(String bizcnd) {
		this.bizcnd = bizcnd;
	}
	public String getTel_no() {
		return tel_no;
	}
	public void setTel_no(String tel_no) {
		this.tel_no = tel_no;
	}
	public String getSnsTypeCd() {
		return snsTypeCd;
	}
	public void setSnsTypeCd(String snsTypeCd) {
		this.snsTypeCd = snsTypeCd;
	}
	public String getSnsTypeCdNm() {
		return snsTypeCdNm;
	}
	public void setSnsTypeCdNm(String snsTypeCdNm) {
		this.snsTypeCdNm = snsTypeCdNm;
	}
	public String getSnsAddr() {
		return snsAddr;
	}
	public void setSnsAddr(String snsAddr) {
		this.snsAddr = snsAddr;
	}
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
	public String getCommitYn() {
		return commitYn;
	}
	public void setCommitYn(String commitYn) {
		this.commitYn = commitYn;
	}
	public String getChnlNm() {
		return chnlNm;
	}
	public void setChnlNm(String chnlNm) {
		this.chnlNm = chnlNm;
	}
	public String getPgmNm() {
		return pgmNm;
	}
	public void setPgmNm(String pgmNm) {
		this.pgmNm = pgmNm;
	}
	public String getPgmNo() {
		return pgmNo;
	}
	public void setPgmNo(String pgmNo) {
		this.pgmNo = pgmNo;
	}
	public String getCusttypecd() {
		return custtypecd;
	}
	public void setCusttypecd(String custtypecd) {
		this.custtypecd = custtypecd;
	}
	public String getMbrTypeCd() {
		return mbrTypeCd;
	}
	public void setMbrTypeCd(String mbrTypeCd) {
		this.mbrTypeCd = mbrTypeCd;
	}
	public String getChnlNo() {
		return chnlNo;
	}
	public void setChnlNo(String chnlNo) {
		this.chnlNo = chnlNo;
	}
	public String getPrStoreCd() {
		return prStoreCd;
	}
	public void setPrStoreCd(String prStoreCd) {
		this.prStoreCd = prStoreCd;
	}
	public String getSbscPathCd() {
		return sbscPathCd;
	}
	public void setSbscPathCd(String sbscPathCd) {
		this.sbscPathCd = sbscPathCd;
	}
	public String getSbscDeviceCd() {
		return sbscDeviceCd;
	}
	public void setSbscDeviceCd(String sbscDeviceCd) {
		this.sbscDeviceCd = sbscDeviceCd;
	}
	public String getPrStoreNm() {
		return prStoreNm;
	}
	public void setPrStoreNm(String prStoreNm) {
		this.prStoreNm = prStoreNm;
	}
	public String getCust_nm() {
		return cust_nm;
	}
	public void setCust_nm(String cust_nm) {
		this.cust_nm = cust_nm;
	}
	public String getCust_nm_add() {
		return cust_nm_add;
	}
	public void setCust_nm_add(String cust_nm_add) {
		this.cust_nm_add = cust_nm_add;
	}
	public String getBirthdt() {
		return birthdt;
	}
	public void setBirthdt(String birthdt) {
		this.birthdt = birthdt;
	}
	public String getLunar_cd() {
		return lunar_cd;
	}
	public void setLunar_cd(String lunar_cd) {
		this.lunar_cd = lunar_cd;
	}
	public String getGen_cd() {
		return gen_cd;
	}
	public void setGen_cd(String gen_cd) {
		this.gen_cd = gen_cd;
	}
	public String getNlty() {
		return nlty;
	}
	public void setNlty(String nlty) {
		this.nlty = nlty;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getHhp() {
		return hhp;
	}
	public void setHhp(String hhp) {
		this.hhp = hhp;
	}
	public String getZip() {
		return zip;
	}
	public void setZip(String zip) {
		this.zip = zip;
	}
	public String getAdres() {
		return adres;
	}
	public void setAdres(String adres) {
		this.adres = adres;
	}
	public String getBunji() {
		return bunji;
	}
	public void setBunji(String bunji) {
		this.bunji = bunji;
	}
	public String getbCode() {
		return bCode;
	}
	public void setbCode(String bCode) {
		this.bCode = bCode;
	}
	public String getMrrg_yn() {
		return mrrg_yn;
	}
	public void setMrrg_yn(String mrrg_yn) {
		this.mrrg_yn = mrrg_yn;
	}
	public String getAnnvrsry() {
		return annvrsry;
	}
	public void setAnnvrsry(String annvrsry) {
		this.annvrsry = annvrsry;
	}
	public String getAnnvrsry_type_cd() {
		return annvrsry_type_cd;
	}
	public void setAnnvrsry_type_cd(String annvrsry_type_cd) {
		this.annvrsry_type_cd = annvrsry_type_cd;
	}
	public String getFrgnrNo() {
		return frgnrNo;
	}
	public void setFrgnrNo(String frgnrNo) {
		this.frgnrNo = frgnrNo;
	}
	public String getNative_yn() {
		return native_yn;
	}
	public void setNative_yn(String native_yn) {
		this.native_yn = native_yn;
	}
	public String getWrc_nm() {
		return wrc_nm;
	}
	public void setWrc_nm(String wrc_nm) {
		this.wrc_nm = wrc_nm;
	}
	public String getPstn() {
		return pstn;
	}
	public void setPstn(String pstn) {
		this.pstn = pstn;
	}
	public String getEmpNo() {
		return empNo;
	}
	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}
	public String getZip_add() {
		return zip_add;
	}
	public void setZip_add(String zip_add) {
		this.zip_add = zip_add;
	}
	public String getAdres_add() {
		return adres_add;
	}
	public void setAdres_add(String adres_add) {
		this.adres_add = adres_add;
	}
	public String getBunji_add() {
		return bunji_add;
	}
	public void setBunji_add(String bunji_add) {
		this.bunji_add = bunji_add;
	}
	public String getbCodeAdd() {
		return bCodeAdd;
	}
	public void setbCodeAdd(String bCodeAdd) {
		this.bCodeAdd = bCodeAdd;
	}
	public String getCertTypeCd() {
		return certTypeCd;
	}
	public void setCertTypeCd(String certTypeCd) {
		this.certTypeCd = certTypeCd;
	}
	public String getCertSubTypeCd() {
		return certSubTypeCd;
	}
	public void setCertSubTypeCd(String certSubTypeCd) {
		this.certSubTypeCd = certSubTypeCd;
	}
	public String getCertVal() {
		return certVal;
	}
	public void setCertVal(String certVal) {
		this.certVal = certVal;
	}
	public String getLoginTypeCd() {
		return loginTypeCd;
	}
	public void setLoginTypeCd(String loginTypeCd) {
		this.loginTypeCd = loginTypeCd;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_pwd() {
		return user_pwd;
	}
	public void setUser_pwd(String user_pwd) {
		this.user_pwd = user_pwd;
	}
	public String getRcmmd_no() {
		return rcmmd_no;
	}
	public void setRcmmd_no(String rcmmd_no) {
		this.rcmmd_no = rcmmd_no;
	}
	public int getDrmncyChngUnit() {
		return drmncyChngUnit;
	}
	public void setDrmncyChngUnit(int drmncyChngUnit) {
		this.drmncyChngUnit = drmncyChngUnit;
	}
	public String getLaName() {
		return laName;
	}
	public void setLaName(String laName) {
		this.laName = laName;
	}
	public String getLaCertVal() {
		return laCertVal;
	}
	public void setLaCertVal(String laCertVal) {
		this.laCertVal = laCertVal;
	}
	public String getLaAgreDt() {
		return laAgreDt;
	}
	public void setLaAgreDt(String laAgreDt) {
		this.laAgreDt = laAgreDt;
	}
}
