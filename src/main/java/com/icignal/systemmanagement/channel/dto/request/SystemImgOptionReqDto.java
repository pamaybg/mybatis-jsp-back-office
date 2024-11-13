package com.icignal.systemmanagement.channel.dto.request;



import com.icignal.common.base.dto.request.CommonDataAuthReqDto;

/**
 * @name : MKTChannelRequestDTO
 * @date : 2015. 09. 21.
 * @author : 박지열
 * @description : 채널 정보 조회
 */
public class SystemImgOptionReqDto extends CommonDataAuthReqDto{
	private String id;                    //아이디
	private String mktChnlId;     		  //마케팅 채널 아이디
	private String chnlId;                   //채널 시스템 ID
	private String fileType;                 //파일 타입
    private String accntId;                  //어카운트 ID
    private String chnlType;                //채널 유형

	public String getMktChnlId() {
		return mktChnlId;
	}

	public void setMktChnlId(String mktChnlId) {
		this.mktChnlId = mktChnlId;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

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
