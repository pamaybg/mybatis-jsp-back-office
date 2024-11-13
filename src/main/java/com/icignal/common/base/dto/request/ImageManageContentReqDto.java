package com.icignal.common.base.dto.request;

import java.util.List;

import com.icignal.common.util.CommonUtil.IMAGE_UPLOAD_TYPE;
import com.icignal.common.util.ObjectUtil;
import com.icignal.marketing.contents.dto.request.MktSendTestTargetReqDto;


/**
 * @name : ImageManageContentRequestDTO
 * @date : 2018. 09. 11.
 * @author : 금동우
 * @description : 콘텐츠 정보 조회
 */
public class ImageManageContentReqDto extends CommonDataAuthReqDto {
    
	private String id;                       //아이디
	private String contentsName;             //콘텐츠명
	private String contentsChannel;          //콘텐츠 채널
	private String contentsType;             //콘텐츠 유형
	private String contentsFlag;    		 //콘텐츠 종류
	private String title;          		     //제목
	private String subTitle;                 //소제목
	private String emailType;          		 //콘텐츠 이메일 유형
	private String txtMsgObject;  		     //TEXT 메세지 목적			
	private String contents;       		     //내용
	private String html;            		 //HTML
	private String description;    		     //설명
	private int textByteSize;      		     //콘텐츠 용량
	private long imgSize;          		     //이미지 용량
	private int imgCnt;           		     //이미지 적용 건수
	private int imgBarCnt;          		 //바코드 이미지 적용 건수
	private String memId;         		     //접속 ID
	private String couponNum;  		         //쿠폰 번호
	private String imgId;    		         //이미지 아이디
	private String barId;     		         //바코드 아이디
	private String merId;      		         //병합 이미지 아이디
	
	//콘텐츠 이미지 연결
	private String fileId;      		     //파일 아이디
	private String memid;        		     //유저 아이디
	private String filePath;   			     //파일 경로
	private String barPath;        			 //바코드 경로
	private String denial;                   //수신자 거부 메세지
	private List<MktSendTestTargetReqDto> phoneArr; //전화번호
	private List<String> lisContentFlowId;   //콘텐츠 삭제 ID 리스트
	private String chnlId;                   //채널 시스템 ID
	
	private String chnlType;				 //채널 유형
	private String camFlag;				     //퀵캠페인 플래그
	private String accntId;                  //어카운트Id
	private boolean merCheck;       		 //머지 체크
	private String typeCode;                 //mms/sms유형 구분
	private String senderEmail;              //보내는 사람 이메일
	private String senderNm;                 //보내는 사람 이름
	private String senderInfo; 
	private String bottom;                   
	private String contsPushTypeCode;        //콘텐츠 PUSH 유형코드
	private String contsPushTypeName;        //콘텐츠 PUSH 유형명
	private String contsPushSubTypeCode;     //콘텐츠 PUSH 업무 유형코드
	private String contsPushSubTypeVal;      //콘텐츠 PUSH 업무 유형 값
	private String camId;                    //캠페인 아이디
	private String snsInfo;
	
	//게시물 예약
	private String postDate;
	private String postTime;
	private String reservePost;
	
	//포스팅 공개 범위 설정
	private String openRange;
	
	//iCIGNAL 이미지 세팅
	private List<MultiUploadReqDto> subImages;
	
	private String attType;				  //첨부파일 종류

	private String contsPushParam;        //사용자정의
    private String contsPushAppTypeCode;  //app유형코드
    private String contsPushSendTypeCode; //발송유형코드
    
    private String pstngTypeCd;   //게시유형
    private String contsAttenMtr; //주의사항
    private String inqrNo;        //이용문의
    private String dpStartDt;     //기간(표시시작일시)
    private String dpEndDt;       //기간
    private String newDpCloDt;    //New표시마감일시
    private Integer apctPosblNum; //응모가능수
    private Integer contsSeq;     //순서
    private Integer contsLoadSeq; //부하순서
    private String hpage;         //홈페이지
    private String evNo;          //이벤트번호
    private String imgLinkUrl;    //이미지링크url
    private String attrib01;      //단말기사용안내
    private String attrib02;      //공지메시지
    private String attrib03;      //슬로건
    private String attrib04;      //Only You Y/N
    private String attrib05;      //Hot 기능
    private String attrib06;      //Highlight In Pad
    private String attrib07;      //프로모션 Y/N
    private String attrib08;      //제휴유형코드
    private String attrib09;      //상세슬로건
    
    //서브이미지 추가
    private int subImgSize;       //서브이미지 크기
    private String subImgId;      //서브이미지ID
    
    public int getSubImgSize() {
        return subImgSize;
    }
    public void setSubImgSize(int subImgSize) {
        this.subImgSize = subImgSize;
    }
    public String getSubImgId() {
        return subImgId;
    }
    public void setSubImgId(String subImgId) {
        this.subImgId = subImgId;
    }
    public String getSubTitle() {
        return subTitle;
    }
    public void setSubTitle(String subTitle) {
        this.subTitle = subTitle;
    }
    public String getImgLinkUrl() {
        return imgLinkUrl;
    }
    public void setImgLinkUrl(String imgLinkUrl) {
        this.imgLinkUrl = imgLinkUrl;
    }
    public String getPstngTypeCd() {
        return pstngTypeCd;
    }
    public void setPstngTypeCd(String pstngTypeCd) {
        this.pstngTypeCd = pstngTypeCd;
    }
    public String getContsAttenMtr() {
        return contsAttenMtr;
    }
    public void setContsAttenMtr(String contsAttenMtr) {
        this.contsAttenMtr = contsAttenMtr;
    }
    public String getInqrNo() {
        return inqrNo;
    }
    public void setInqrNo(String inqrNo) {
        this.inqrNo = inqrNo;
    }
    public String getDpStartDt() {
        return dpStartDt;
    }
    public void setDpStartDt(String dpStartDt) {
        this.dpStartDt = dpStartDt;
    }
    public String getDpEndDt() {
        return dpEndDt;
    }
    public void setDpEndDt(String dpEndDt) {
        this.dpEndDt = dpEndDt;
    }
    public String getNewDpCloDt() {
        return newDpCloDt;
    }
    public void setNewDpCloDt(String newDpCloDt) {
        this.newDpCloDt = newDpCloDt;
    }
    public Integer getApctPosblNum() {
        return apctPosblNum;
    }
    public void setApctPosblNum(Integer apctPosblNum) {
        this.apctPosblNum = apctPosblNum;
    }
    public Integer getContsSeq() {
        return contsSeq;
    }
    public void setContsSeq(Integer contsSeq) {
        this.contsSeq = contsSeq;
    }
    public Integer getContsLoadSeq() {
        return contsLoadSeq;
    }
    public void setContsLoadSeq(Integer contsLoadSeq) {
        this.contsLoadSeq = contsLoadSeq;
    }
    public String getHpage() {
        return hpage;
    }
    public void setHpage(String hpage) {
        this.hpage = hpage;
    }
    public String getEvNo() {
        return evNo;
    }
    public void setEvNo(String evNo) {
        this.evNo = evNo;
    }
    public String getAttrib01() {
        return attrib01;
    }
    public void setAttrib01(String attrib01) {
        this.attrib01 = attrib01;
    }
    public String getAttrib02() {
        return attrib02;
    }
    public void setAttrib02(String attrib02) {
        this.attrib02 = attrib02;
    }
    public String getAttrib03() {
        return attrib03;
    }
    public void setAttrib03(String attrib03) {
        this.attrib03 = attrib03;
    }
    public String getAttrib04() {
        return attrib04;
    }
    public void setAttrib04(String attrib04) {
        this.attrib04 = attrib04;
    }
    public String getAttrib05() {
        return attrib05;
    }
    public void setAttrib05(String attrib05) {
        this.attrib05 = attrib05;
    }
    public String getAttrib06() {
        return attrib06;
    }
    public void setAttrib06(String attrib06) {
        this.attrib06 = attrib06;
    }
    public String getAttrib07() {
        return attrib07;
    }
    public void setAttrib07(String attrib07) {
        this.attrib07 = attrib07;
    }
    public String getContsPushAppTypeCode() {
        return contsPushAppTypeCode;
    }
    public void setContsPushAppTypeCode(String contsPushAppTypeCode) {
        this.contsPushAppTypeCode = contsPushAppTypeCode;
    }
    public String getContsPushSendTypeCode() {
        return contsPushSendTypeCode;
    }
    public void setContsPushSendTypeCode(String contsPushSendTypeCode) {
        this.contsPushSendTypeCode = contsPushSendTypeCode;
    }
    public String getContsPushParam() {
        return contsPushParam;
    }
    public void setContsPushParam(String contsPushParam) {
        this.contsPushParam = contsPushParam;
    }
    public String getPostDate() {
		return postDate;
	}
	public void setPostDate(String postDate) {
		this.postDate = postDate;
	}
	public List<MultiUploadReqDto> getSubImages() {
		return subImages;
	}
	public void setSubImages(List<MultiUploadReqDto> subImages) {
		this.subImages = subImages;
	}
	
	public IMAGE_UPLOAD_TYPE getSubImageCategory () {
		IMAGE_UPLOAD_TYPE category = null;
		if(ObjectUtil.isNotEmpty(this.subImages)) {
			category = this.subImages.get(0).getCategory();
			/*for (MultiUploadReqDto mur : this.subImages) {
				category = mur.getCategory();
				break;
			}*/
		}
		
		return category;
	}
	
	public String getSubImageFileNames() {
		StringBuilder result = new StringBuilder();
		if(ObjectUtil.isNotEmpty(this.subImages)) {
			for(MultiUploadReqDto mur : this.subImages) {
				result.append(mur.getFileName());
				result.append(',');
			}
		}
		
		return result.length() > 0 ? result.substring(0, result.length() - 1): "";
	}
	
	public String getSubImageFilePaths() {
		StringBuilder result = new StringBuilder();
		if(ObjectUtil.isNotEmpty(this.subImages)) {
			for(MultiUploadReqDto mur : this.subImages) {
				result.append(mur.getFilePath());
				result.append(',');
			}
		}
		
		return result.length() > 0 ? result.substring(0, result.length() - 1): "";
	}
	
	public String getSubImageOriNames() {
		StringBuilder result = new StringBuilder();
		if(ObjectUtil.isNotEmpty(this.subImages)) {
			for(MultiUploadReqDto mur : this.subImages) {
				result.append(mur.getOriName());
				result.append(',');
			}
		}
		
		return result.length() > 0 ? result.substring(0, result.length() - 1): "";
	}
	
	public String getSubImageRotateAngles() {
		StringBuilder result = new StringBuilder();
		if(ObjectUtil.isNotEmpty(this.subImages)) {
			for(MultiUploadReqDto mur : this.subImages) {
				result.append(mur.getRotateAngle());
				result.append(',');
			}
		}
		
		return result.length() > 0 ? result.substring(0, result.length() - 1): "";
	}
	
	public String getSenderInfo() {
		return senderInfo;
	}
	public void setSenderInfo(String senderInfo) {
		this.senderInfo = senderInfo;
	}
	public String getMemId() {
		return memId;
	}
	public void setMemId(String memId) {
		this.memId = memId;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getContentsName() {
		return contentsName;
	}
	public void setContentsName(String contentsName) {
		this.contentsName = contentsName;
	}
	public String getContentsType() {
		return contentsType;
	}
	public void setContentsType(String contentsType) {
		this.contentsType = contentsType;
	}
	public String getContentsFlag() {
		return contentsFlag;
	}
	public void setContentsFlag(String contentsFlag) {
		this.contentsFlag = contentsFlag;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getTxtMsgObject() {
		return txtMsgObject;
	}
	public void setTxtMsgObject(String txtMsgObject) {
		this.txtMsgObject = txtMsgObject;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getHtml() {
		return html;
	}
	public void setHtml(String html) {
		this.html = html;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public int getTextByteSize() {
		return textByteSize;
	}
	public void setTextByteSize(int textByteSize) {
		this.textByteSize = textByteSize;
	}
	public long getImgSize() {
		return imgSize;
	}
	public void setImgSize(long size) {
		this.imgSize = size;
	}
	public int getImgCnt() {
		return imgCnt;
	}
	public void setImgCnt(int imgCnt) {
		this.imgCnt = imgCnt;
	}
	public String getContentsChannel() {
		return contentsChannel;
	}
	public void setContentsChannel(String contentsChannel) {
		this.contentsChannel = contentsChannel;
	}


	private String imageId;
	private String imageSystemId;
	private String imageSubject;
	private String imageStatus;
	private String userId;
	private int fileSeq;
	private List<MultiUploadReqDto> fileImages;
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public List<MultiUploadReqDto> getBannerImages() {
		return fileImages;
	}
	public void setFileImages(List<MultiUploadReqDto> fileImages) {
		this.fileImages = fileImages;
	}
	
	public IMAGE_UPLOAD_TYPE getLogoImageCategory () {
		IMAGE_UPLOAD_TYPE category = null;
		if (ObjectUtil.isNotEmpty(this.fileImages)) {
			category = this.fileImages.get(0).getCategory();
			/*for (MultiUploadReqDto mur : this.fileImages) {
				category = mur.getCategory();
				break;
			}*/
		}
		
		return category;
	}
	
	public String getFileImageFileNames() {
		StringBuilder result = new StringBuilder();
		if (ObjectUtil.isNotEmpty(this.fileImages)) {
			for(MultiUploadReqDto mur : this.fileImages) {
				result.append(mur.getFileName());
				result.append(',');
			}
		}
		
		return result.length() > 0 ? result.substring(0, result.length() - 1): "";
	}
	
	public String getFIleImageRotateAngles() {
		StringBuilder result = new StringBuilder();
		if (ObjectUtil.isNotEmpty(this.fileImages)) {
			for(MultiUploadReqDto mur : this.fileImages) {
				result.append(mur.getRotateAngle());
				result.append(',');
			}
		}
		
		return result.length() > 0 ? result.substring(0, result.length() - 1): "";
	}
	
	public String getImageId() {
		return imageId;
	}
	public void setImageId(String imageId) {
		this.imageId = imageId;
	}
	public String getImageSystemId() {
		return imageSystemId;
	}
	public void setImageSystemId(String imageSystemId) {
		this.imageSystemId = imageSystemId;
	}
	public String getImageSubject() {
		return imageSubject;
	}
	public void setImageSubject(String imageSubject) {
		this.imageSubject = imageSubject;
	}
	public String getImageStatus() {
		return imageStatus;
	}
	public void setImageStatus(String imageStatus) {
		this.imageStatus = imageStatus;
	}
	public int getFileSeq() {
		return fileSeq;
	}
	public void setFileSeq(int fileSeq) {
		this.fileSeq = fileSeq;
	}
	public List<MultiUploadReqDto> getFileImages() {
		return fileImages;
	}
	public String getCouponNum() {
		return couponNum;
	}
	public void setCouponNum(String couponNum) {
		this.couponNum = couponNum;
	}
	public String getFileId() {
		return fileId;
	}
	public void setFileId(String fileId) {
		this.fileId = fileId;
	}
	public String getMemid() {
		return memid;
	}
	public void setMemid(String memid) {
		this.memid = memid;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public String getImgId() {
		return imgId;
	}
	public void setImgId(String imgId) {
		this.imgId = imgId;
	}
	public String getBarId() {
		return barId;
	}
	public void setBarId(String barId) {
		this.barId = barId;
	}
	public String getBarPath() {
		return barPath;
	}
	public void setBarPath(String barPath) {
		this.barPath = barPath;
	}
	public String getMerId() {
		return merId;
	}
	public void setMerId(String merId) {
		this.merId = merId;
	}
	public List<MktSendTestTargetReqDto> getPhoneArr() {
		return phoneArr;
	}
	public void setPhoneArr(List<MktSendTestTargetReqDto> phoneArr) {
		this.phoneArr = phoneArr;
	}
	public String getDenial() {
		return denial;
	}
	public void setDenial(String denial) {
		this.denial = denial;
	}
	public List<String> getLisContentFlowId() {
		return lisContentFlowId;
	}
	public void setLisContentFlowId(List<String> lisContentFlowId) {
		this.lisContentFlowId = lisContentFlowId;
	}
	public int getImgBarCnt() {
		return imgBarCnt;
	}
	public void setImgBarCnt(int imgBarCnt) {
		this.imgBarCnt = imgBarCnt;
	}
	public String getChnlId() {
		return chnlId;
	}
	public void setChnlId(String chnlId) {
		this.chnlId = chnlId;
	}
	public String getChnlType() {
		return chnlType;
	}
	public void setChnlType(String chnlType) {
		this.chnlType = chnlType;
	}
	public String getCamFlag() {
		return camFlag;
	}
	public void setCamFlag(String camFlag) {
		this.camFlag = camFlag;
	}
	public String getAccntId() {
		return accntId;
	}
	public void setAccntId(String accntId) {
		this.accntId = accntId;
	}
	public boolean isMerCheck() {
		return merCheck;
	}
	public void setMerCheck(boolean merCheck) {
		this.merCheck = merCheck;
	}
	public String getTypeCode() {
		return typeCode;
	}
	public void setTypeCode(String typeCode) {
		this.typeCode = typeCode;
	}
	public String getSenderEmail() {
		return senderEmail;
	}
	public void setSenderEmail(String senderEmail) {
		this.senderEmail = senderEmail;
	}
	public String getSenderNm() {
		return senderNm;
	}
	public void setSenderNm(String senderNm) {
		this.senderNm = senderNm;
	}
	public String getBottom() {
		return bottom;
	}
	public void setBottom(String bottom) {
		this.bottom = bottom;
	}
	public String getEmailType() {
		return emailType;
	}
	public void setEmailType(String emailType) {
		this.emailType = emailType;
	}
    public String getContsPushTypeCode() {
        return contsPushTypeCode;
    }
    public void setContsPushTypeCode(String contsPushTypeCode) {
        this.contsPushTypeCode = contsPushTypeCode;
    }
    public String getContsPushTypeName() {
        return contsPushTypeName;
    }
    public void setContsPushTypeName(String contsPushTypeName) {
        this.contsPushTypeName = contsPushTypeName;
    }
    public String getContsPushSubTypeCode() {
        return contsPushSubTypeCode;
    }
    public void setContsPushSubTypeCode(String contsPushSubTypeCode) {
        this.contsPushSubTypeCode = contsPushSubTypeCode;
    }
    public String getContsPushSubTypeVal() {
        return contsPushSubTypeVal;
    }
    public void setContsPushSubTypeVal(String contsPushSubTypeVal) {
        this.contsPushSubTypeVal = contsPushSubTypeVal;
    }
    public String getCamId() {
        return camId;
    }
    public void setCamId(String camId) {
        this.camId = camId;
    }
	public String getReservePost() {
		return reservePost;
	}
	public void setReservePost(String reservePost) {
		this.reservePost = reservePost;
	}
	public String getOpenRange() {
		return openRange;
	}
	public void setOpenRange(String openRange) {
		this.openRange = openRange;
	}
	public String getPostTime() {
		return postTime;
	}
	public void setPostTime(String postTime) {
		this.postTime = postTime;
	}
	public String getAttType() {
		return attType;
	}
	public void setAttType(String attType) {
		this.attType = attType;
	}
	public String getSnsInfo() {
		return snsInfo;
	}
	public void setSnsInfo(String snsInfo) {
		this.snsInfo = snsInfo;
	}
	public String getAttrib08() {
		return attrib08;
	}
	public void setAttrib08(String attrib08) {
		this.attrib08 = attrib08;
	}
	public String getAttrib09() {
		return attrib09;
	}
	public void setAttrib09(String attrib09) {
		this.attrib09 = attrib09;
	}
	

	
	
}
