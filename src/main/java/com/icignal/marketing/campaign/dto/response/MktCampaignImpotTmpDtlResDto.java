package com.icignal.marketing.campaign.dto.response;

import java.util.Map;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
 * @name : infavor.marketing.campaign.dto.response.MktCampaignImpotTmpDtlResDto
 * @date : 2018. 3. 16.
 * @author : jh.kim
 * @description :
 */
public class MktCampaignImpotTmpDtlResDto extends GridPagingItemResDto {

    private String id;
    private String camId;
    private String memId;
    private String ridTgtHad;

    private String prsnlVal01;
    private String prsnlVal02;
    private String prsnlVal03;
    private String prsnlVal04;
    private String prsnlVal05;
    
    Map<String, Object> mbrInfo;   //회원 추가 정보

    public String getRidTgtHad() {
        return ridTgtHad;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getCamId() {
        return camId;
    }

    public void setCamId(String camId) {
        this.camId = camId;
    }

    public String getMemId() {
        return memId;
    }

    public void setMemId(String memId) {
        this.memId = memId;
    }

    public Map<String, Object> getMbrInfo() {
        return mbrInfo;
    }

    public void setMbrInfo(Map<String, Object> mbrInfo) {
        this.mbrInfo = mbrInfo;
    }

    public void setRidTgtHad(String ridTgtHad) {
        this.ridTgtHad = ridTgtHad;
    }

	public String getPrsnlVal01() {
		return prsnlVal01;
	}

	public void setPrsnlVal01(String prsnlVal01) {
		this.prsnlVal01 = prsnlVal01;
	}

	public String getPrsnlVal02() {
		return prsnlVal02;
	}

	public void setPrsnlVal02(String prsnlVal02) {
		this.prsnlVal02 = prsnlVal02;
	}

	public String getPrsnlVal03() {
		return prsnlVal03;
	}

	public void setPrsnlVal03(String prsnlVal03) {
		this.prsnlVal03 = prsnlVal03;
	}

	public String getPrsnlVal04() {
		return prsnlVal04;
	}

	public void setPrsnlVal04(String prsnlVal04) {
		this.prsnlVal04 = prsnlVal04;
	}

	public String getPrsnlVal05() {
		return prsnlVal05;
	}

	public void setPrsnlVal05(String prsnlVal05) {
		this.prsnlVal05 = prsnlVal05;
	}

}
