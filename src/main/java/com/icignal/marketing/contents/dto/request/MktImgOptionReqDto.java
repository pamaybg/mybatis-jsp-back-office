package com.icignal.marketing.contents.dto.request;

import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * @name : MKTContentRequestDTO
 * @date : 2015. 09. 21.
 * @author : 박지열
 * @description : 콘텐츠 정보 조회
 */
public class MktImgOptionReqDto extends CommonDataAuthReqDto{
	private String chnlId;                   //채널 시스템 ID
	private String fileType;                 //파일 타입
    private String accntId;                  //어카운트 ID
    private String chnlType;                //채널 유형
    
	public String getChnlId() {
		return chnlId;
	}

	public void setChnlId(String chnlId) {
		this.chnlId = chnlId;
	}

	public String getFileType() {
		return fileType;
	}

	public void setFileType(String fileType) {
		this.fileType = fileType;
	}

	public String getAccntId() {
		return accntId;
	}

	public void setAccntId(String accntId) {
		this.accntId = accntId;
	}

    public String getChnlType() {
        return chnlType;
    }

    public void setChnlType(String chnlType) {
        this.chnlType = chnlType;
    }

	
}
