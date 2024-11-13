package com.icignal.loyalty.channel.dto.response;

/*
 * 1. 클래스명	: LoyChnlDefaultInfoResDto
 * 2. 파일명	: LOYChnlDefaultInfoResponseDTO.java
 * 3. 패키지명	: com.icignal.loyalty.channel.dto.response
 * 4. 작성자명	: hy.jun
 * 5. 작성일자	: 2018. 10. 10.
 */
/**
 * <PRE>
 * 1. 설명
 *  채널상세 상단 기본정보
 * </PRE>
 */ 

public class LoyChnlDefaultInfoResDto extends LoyChnlMasterResDto {
    private String parChnlNo;
    private String parChnlNm;
    
    private String createDate;
    private String createBy;
    private String createByNm;
    
    private String storeCd;
    //private String cipherKey;

    public String getParChnlNo() {
        return parChnlNo;
    }

    public void setParChnlNo(String parChnlNo) {
        this.parChnlNo = parChnlNo;
    }

    public String getParChnlNm() {
        return parChnlNm;
    }

    public void setParChnlNm(String parChnlNm) {
        this.parChnlNm = parChnlNm;
    }

    public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate;
    }

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }

    public String getCreateByNm() {
        return createByNm;
    }

    public void setCreateByNm(String createByNm) {
        this.createByNm = createByNm;
    }

	public String getStoreCd() {
		return storeCd;
	}

	public void setStoreCd(String storeCd) {
		this.storeCd = storeCd;
	}
	
    
}
