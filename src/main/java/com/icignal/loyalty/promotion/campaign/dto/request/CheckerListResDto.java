package com.icignal.loyalty.promotion.campaign.dto.request;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.response.GridPagingItemResDto;


/**
 * @name : infavor.marketing.common.checker.dto.response
 * @date : 2015. 11. 10.
 * @author : 류동균
 * @description :
 */
public class CheckerListResDto extends GridPagingItemResDto {

    private String tagetDtlId;    //대상자 상세 ID

    private String memberId;    //회원아이디

    private String exceptionYn = "0";    //제외 여부

    private String duplicateDeleteYn = "1";    //중복 삭제 여부

    private String permissionCheckDeleteYn = "1";    //허가 점검 삭제 여부

    private String fatigueCheckDeleteYn = "1";    //피로도 점검 삭제 여부

    private String infoPrvYn = "0";    //제3자정보제공동의여부

    private String infoUtilYn = "0";    //개인정보활용동의여부

    private String locInfoYn = "0";    //위치정보사업동의여부

    private String lbsYn = "0";    //위치기반서비스사업동의여부

    private String mktUtilYn = "0";    //마케팅활용동의여부

    private String smsConsentYn = "0";    //sms수신동의여부

    private String dmConsentYn = "0";    //DM수신동의여부

    private String emailConsentYn = "0";    //email수신동의여부

    private String tmConsentYn = "0";    //tm수신동의여부

    private String pushConsentYn = "0";

    private String hpYn = "0";    //핸드폰번호유무여부

    private String emailYn = "0";    //이메일주소유무여부

    private String memberYn = "0";    //회원유무

    private String chnnelCode;    //채널코드

    private String email;       //회원 이메일

    private String phoneNo;     //핸드폰번호

    private String memSeq;      //회원 순서

    private String memName;		//외부고객 회원 명

    private String memNameYn;	//외부고객 회원명 유무




    private String memberIdChk = "0";    //회원아이디

    private String exceptionYnChk = "0";    //제외 여부

    private String duplicateDeleteYnChk = "0";    //중복 삭제 여부

    private String permissionCheckDeleteYnChk = "0";    //허가 점검 삭제 여부

    private String fatigueCheckDeleteYnChk = "0";    //피로도 점검 삭제 여부

    private String infoPrvYnChk = "0";    //제3자정보제공동의여부

    private String infoUtilYnChk = "0";    //개인정보활용동의여부

    private String locInfoYnChk = "0";    //위치정보사업동의여부

    private String lbsYnChk = "0";    //위치기반서비스사업동의여부

    private String mktUtilYnChk = "0";    //마케팅활용동의여부

    private String smsConsentYnChk = "0";    //sms수신동의여부

    private String dmConsentYnChk = "0";    //DM수신동의여부

    private String emailConsentYnChk = "0";    //email수신동의여부

    private String tmConsentYnChk = "0";    //tm수신동의여부

    private String pushConsentYnChk = "0";

    private String hpYnChk = "0";    //핸드폰번호유무여부

    private String emailYnChk = "0";    //이메일주소유무여부

    private String memberYnChk = "0";    //회원유무

    private String emailChk = "0";       //회원 이메일

    private String phoneNoChk = "0";     //핸드폰번호

    private String failFlag = "0";		//모두실패

    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

    public String getMemberId() {
        return memberId;
    }

    public void setMemberId(String memberId) {
        this.memberId = memberId;
    }

    public String getExceptionYn() {
        return exceptionYn;
    }

    public void setExceptionYn(String exceptionYn) {
        this.exceptionYn = exceptionYn;
    }

    public String getDuplicateDeleteYn() {
        return duplicateDeleteYn;
    }

    public void setDuplicateDeleteYn(String duplicateDeleteYn) {
        this.duplicateDeleteYn = duplicateDeleteYn;
    }

    public String getPermissionCheckDeleteYn() {
        return permissionCheckDeleteYn;
    }

    public void setPermissionCheckDeleteYn(String permissionCheckDeleteYn) {
        this.permissionCheckDeleteYn = permissionCheckDeleteYn;
    }

    public String getFatigueCheckDeleteYn() {
        return fatigueCheckDeleteYn;
    }

    public void setFatigueCheckDeleteYn(String fatigueCheckDeleteYn) {
        this.fatigueCheckDeleteYn = fatigueCheckDeleteYn;
    }

    public String getTagetDtlId() {
        return tagetDtlId;
    }

    public void setTagetDtlId(String tagetDtlId) {
        this.tagetDtlId = tagetDtlId;
    }

    public String getInfoPrvYn() {
        return infoPrvYn;
    }

    public void setInfoPrvYn(String infoPrvYn) {
        this.infoPrvYn = infoPrvYn;
    }

    public String getInfoUtilYn() {
        return infoUtilYn;
    }

    public void setInfoUtilYn(String infoUtilYn) {
        this.infoUtilYn = infoUtilYn;
    }

    public String getLocInfoYn() {
        return locInfoYn;
    }

    public void setLocInfoYn(String locInfoYn) {
        this.locInfoYn = locInfoYn;
    }

    public String getLbsYn() {
        return lbsYn;
    }

    public void setLbsYn(String lbsYn) {
        this.lbsYn = lbsYn;
    }

    public String getMktUtilYn() {
        return mktUtilYn;
    }

    public void setMktUtilYn(String mktUtilYn) {
        this.mktUtilYn = mktUtilYn;
    }

    public String getSmsConsentYn() {
        return smsConsentYn;
    }

    public void setSmsConsentYn(String smsConsentYn) {
        this.smsConsentYn = smsConsentYn;
    }

    public String getDmConsentYn() {
        return dmConsentYn;
    }

    public void setDmConsentYn(String dmConsentYn) {
        this.dmConsentYn = dmConsentYn;
    }

    public String getEmailConsentYn() {
        return emailConsentYn;
    }

    public void setEmailConsentYn(String emailConsentYn) {
        this.emailConsentYn = emailConsentYn;
    }

    public String getTmConsentYn() {
        return tmConsentYn;
    }

    public void setTmConsentYn(String tmConsentYn) {
        this.tmConsentYn = tmConsentYn;
    }

    public String getHpYn() {
        return hpYn;
    }

    public void setHpYn(String hpYn) {
        this.hpYn = hpYn;
    }

    public String getEmailYn() {
        return emailYn;
    }

    public void setEmailYn(String emailYn) {
        this.emailYn = emailYn;
    }

    public String getMemberYn() {
        return memberYn;
    }

    public void setMemberYn(String memberYn) {
        this.memberYn = memberYn;
    }

    public String getChnnelCode() {
        return chnnelCode;
    }

    public void setChnnelCode(String chnnelCode) {
        this.chnnelCode = chnnelCode;
    }

    public String getPushConsentYn() {
        return pushConsentYn;
    }

    public void setPushConsentYn(String pushConsentYn) {
        this.pushConsentYn = pushConsentYn;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhoneNo() {
        return phoneNo;
    }

    public void setPhoneNo(String phoneNo) {
        this.phoneNo = phoneNo;
    }

    public String getMemSeq() {
        return memSeq;
    }

    public void setMemSeq(String memSeq) {
        this.memSeq = memSeq;
    }

	public String getMemberIdChk() {
		return memberIdChk;
	}

	public void setMemberIdChk(String memberIdChk) {
		this.memberIdChk = memberIdChk;
	}

	public String getExceptionYnChk() {
		return exceptionYnChk;
	}

	public void setExceptionYnChk(String exceptionYnChk) {
		this.exceptionYnChk = exceptionYnChk;
	}

	public String getDuplicateDeleteYnChk() {
		return duplicateDeleteYnChk;
	}

	public void setDuplicateDeleteYnChk(String duplicateDeleteYnChk) {
		this.duplicateDeleteYnChk = duplicateDeleteYnChk;
	}

	public String getPermissionCheckDeleteYnChk() {
		return permissionCheckDeleteYnChk;
	}

	public void setPermissionCheckDeleteYnChk(String permissionCheckDeleteYnChk) {
		this.permissionCheckDeleteYnChk = permissionCheckDeleteYnChk;
	}

	public String getFatigueCheckDeleteYnChk() {
		return fatigueCheckDeleteYnChk;
	}

	public void setFatigueCheckDeleteYnChk(String fatigueCheckDeleteYnChk) {
		this.fatigueCheckDeleteYnChk = fatigueCheckDeleteYnChk;
	}

	public String getInfoPrvYnChk() {
		return infoPrvYnChk;
	}

	public void setInfoPrvYnChk(String infoPrvYnChk) {
		this.infoPrvYnChk = infoPrvYnChk;
	}

	public String getInfoUtilYnChk() {
		return infoUtilYnChk;
	}

	public void setInfoUtilYnChk(String infoUtilYnChk) {
		this.infoUtilYnChk = infoUtilYnChk;
	}

	public String getLocInfoYnChk() {
		return locInfoYnChk;
	}

	public void setLocInfoYnChk(String locInfoYnChk) {
		this.locInfoYnChk = locInfoYnChk;
	}

	public String getLbsYnChk() {
		return lbsYnChk;
	}

	public void setLbsYnChk(String lbsYnChk) {
		this.lbsYnChk = lbsYnChk;
	}

	public String getMktUtilYnChk() {
		return mktUtilYnChk;
	}

	public void setMktUtilYnChk(String mktUtilYnChk) {
		this.mktUtilYnChk = mktUtilYnChk;
	}

	public String getSmsConsentYnChk() {
		return smsConsentYnChk;
	}

	public void setSmsConsentYnChk(String smsConsentYnChk) {
		this.smsConsentYnChk = smsConsentYnChk;
	}

	public String getDmConsentYnChk() {
		return dmConsentYnChk;
	}

	public void setDmConsentYnChk(String dmConsentYnChk) {
		this.dmConsentYnChk = dmConsentYnChk;
	}

	public String getEmailConsentYnChk() {
		return emailConsentYnChk;
	}

	public void setEmailConsentYnChk(String emailConsentYnChk) {
		this.emailConsentYnChk = emailConsentYnChk;
	}

	public String getTmConsentYnChk() {
		return tmConsentYnChk;
	}

	public void setTmConsentYnChk(String tmConsentYnChk) {
		this.tmConsentYnChk = tmConsentYnChk;
	}

	public String getPushConsentYnChk() {
		return pushConsentYnChk;
	}

	public void setPushConsentYnChk(String pushConsentYnChk) {
		this.pushConsentYnChk = pushConsentYnChk;
	}

	public String getHpYnChk() {
		return hpYnChk;
	}

	public void setHpYnChk(String hpYnChk) {
		this.hpYnChk = hpYnChk;
	}

	public String getEmailYnChk() {
		return emailYnChk;
	}

	public void setEmailYnChk(String emailYnChk) {
		this.emailYnChk = emailYnChk;
	}

	public String getMemberYnChk() {
		return memberYnChk;
	}

	public void setMemberYnChk(String memberYnChk) {
		this.memberYnChk = memberYnChk;
	}

	public String getEmailChk() {
		return emailChk;
	}

	public void setEmailChk(String emailChk) {
		this.emailChk = emailChk;
	}

	public String getPhoneNoChk() {
		return phoneNoChk;
	}

	public void setPhoneNoChk(String phoneNoChk) {
		this.phoneNoChk = phoneNoChk;
	}

	public String getFailFlag() {
		return failFlag;
	}

	public void setFailFlag(String failFlag) {
		this.failFlag = failFlag;
	}

	public String getMemName() {
		return memName;
	}

	public void setMemName(String memName) {
		this.memName = memName;
	}

	public String getMemNameYn() {
		return memNameYn;
	}

	public void setMemNameYn(String memNameYn) {
		this.memNameYn = memNameYn;
	}

 }