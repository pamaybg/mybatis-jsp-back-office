package com.icignal.loyalty.membership.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;
import com.icignal.core.annotation.personaldata.Encrypted;
import com.icignal.core.annotation.personaldata.PersonalData;

@PersonalData
public class LoyMbrSearchHelpReqDto extends CommonDataAuthReqDto {

    private String rid;
    private String mbrNo;
    @Encrypted
    private String custNm;
    private String mbrType;
    private String webMemId;
    private String hhpNo;
    private String cipherKey;
    private String first;
    private String realBirthDt;
    private String tierNm;
    private String emailAddr;

    private String hhpSearhFlag;
    private String hhpSearhOpType;
    
    @Encrypted
    private String hhpSearhValue;

    public String getHhpSearhFlag() {
        return hhpSearhFlag;
    }

    public void setHhpSearhFlag(String hhpSearhFlag) {
        this.hhpSearhFlag = hhpSearhFlag;
    }

    public String getHhpSearhOpType() {
        return hhpSearhOpType;
    }

    public void setHhpSearhOpType(String hhpSearhOpType) {
        this.hhpSearhOpType = hhpSearhOpType;
    }

    public String getHhpSearhValue() {
        return hhpSearhValue;
    }

    public void setHhpSearhValue(String hhpSearhValue) {
        this.hhpSearhValue = hhpSearhValue;
    }

    public LoyMbrSearchHelpReqDto() {
   /*     try {
            this.setCipherKey(CryptoManager.getCipherKey());
        }
        catch ( Exception e ) {
            LogUtil.error(e);
        }*/
    }

	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getMbrNo() {
		return mbrNo;
	}
	public void setMbrNo(String mbrNo) {
		this.mbrNo = mbrNo;
	}
	public String getCustNm() {
		return custNm;
	}
	public void setCustNm(String custNm) {
		this.custNm = custNm;
	}
	public String getMbrType() {
		return mbrType;
	}
	public void setMbrType(String mbrType) {
		this.mbrType = mbrType;
	}
	public String getWebMemId() {
		return webMemId;
	}
	public void setWebMemId(String webMemId) {
		this.webMemId = webMemId;
	}
	public String getHhpNo() {
		return hhpNo;
	}
	public void setHhpNo(String hhpNo) {
		this.hhpNo = hhpNo;
	}
	public String getCipherKey() {
		return cipherKey;
	}
	public void setCipherKey(String cipherKey) {
		this.cipherKey = cipherKey;
	}

	public String getFirst() {
		return first;
	}

	public void setFirst(String first) {
		this.first = first;
	}

	public String getRealBirthDt() {
		return realBirthDt;
	}

	public void setRealBirthDt(String realBirthDt) {
		this.realBirthDt = realBirthDt;
	}

	public String getTierNm() {
		return tierNm;
	}

	public void setTierNm(String tierNm) {
		this.tierNm = tierNm;
	}

	public String getEmailAddr() {
		return emailAddr;
	}

	public void setEmailAddr(String emailAddr) {
		this.emailAddr = emailAddr;
	}





}
