package com.icignal.common.base.dto.response;

/**
 * @name : ImageManageContentResponseDTO
 * @date : 2018. 09. 11.
 * @author : 금동우
 * @description : 콘텐츠 정보 조회
 */
public class ImageManageContentResDto extends GridPagingItemResDto{
	private String id;               //아이디
	private String contentsName;     //콘텐츠명
	private String contentsType;     //콘텐츠 유형
	private String contentsChannel;  //콘텐츠 채널
	private String contentsFlag;     //콘텐츠 종류
	private String title;            //제목
	private String subTitle;         //소제목
	private String description;      //설명
	private String txtMsgObject;     //TEXT 메세지 목적1
	private String contents;         //내용
	private String html;             //HTML
	private int textByteSize;        //콘텐츠 용량
	private int imgSize;             //이미지 용량
	private int imgCnt;              //이미지 적용 건수
	private String modifyBy;         //수정자
	private String modifyDate;       //수정일
	private String memId;            //접속 ID
	private String filepath;         //파일 경로
	private String imagepath;        //이미지 경로
	private String fileName;         //파일 이름
	private String path;             //이동 경로
	private String realfileName;     //실제 파일 명
	private String barpath;          //바코드 파일 경로
	private String merpath;          //머지 이미지 경로
	private String merId;			 //머지 아이디
	private String barId;			 //바코드 아이디
	private String imgId;		     //이미지 아이디
	private String chnlId;           //채널 시스템 ID
	private boolean campaignCehck;   //캠페인 체크
	private String contentsTypeCode; //컨텐츠 타입 유형 코드
	private String bottom;           //발신자 번호
	private String contsPushTypeCode;    //콘텐츠 PUSH 유형코드
    private String contsPushTypeName;    //콘텐츠 PUSH 유형명
    private String contsPushSubTypeCode; //콘텐츠 PUSH 업무 유형코드
    private String contsPushSubTypeVal;  //콘텐츠 PUSH 업무 유형 값
    
    private String contsPushParam;        //사용자 정의 데이터
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
    private String imgLinkUrl;    //이미지링크URL
    private String attrib01;      //단말기사용안내
    private String attrib02;      //공지메시지
    private String attrib03;      //슬로건
    private String attrib04;      //Only You Y/N
    private String attrib05;      //Hot 기능
    private String attrib06;      //Highlight In Pad
    private String attrib07;      //프로모션 Y/N
    private String attrib08;      //제휴유형코드
    private String attrib09;      //상세슬로건

    private int subImgSize;       //이미지 용량
    private String subImagepath;  //이미지 경로
    private String subImgId;      //이미지 아이디
    private String chnlGuide; 	  //채널 가이드
    
    public int getSubImgSize() {
        return subImgSize;
    }
    public void setSubImgSize(int subImgSize) {
        this.subImgSize = subImgSize;
    }
    public String getSubImagepath() {
        return subImagepath;
    }
    public void setSubImagepath(String subImagepath) {
        this.subImagepath = subImagepath;
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
    public String getDescription() {
        return description;
    }
    public void setDescription(String description) {
        this.description = description;
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
    public String getContsPushSendTypeCode() {
        return contsPushSendTypeCode;
    }
    public void setContsPushSendTypeCode(String contsPushSendTypeCode) {
        this.contsPushSendTypeCode = contsPushSendTypeCode;
    }
    public String getContsPushAppTypeCode() {
        return contsPushAppTypeCode;
    }
    public void setContsPushAppTypeCode(String contsPushAppTypeCode) {
        this.contsPushAppTypeCode = contsPushAppTypeCode;
    }
    public String getContsPushParam() {
        return contsPushParam;
    }
    public void setContsPushParam(String contsPushParam) {
        this.contsPushParam = contsPushParam;
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
	public int getTextByteSize() {
		return textByteSize;
	}
	public void setTextByteSize(int textByteSize) {
		this.textByteSize = textByteSize;
	}
	public int getImgSize() {
		return imgSize;
	}
	public void setImgSize(int imgSize) {
		this.imgSize = imgSize;
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
	public String getModifyBy() {
		return modifyBy;
	}
	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
	}
	public String getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}
	public String getFilepath() {
		return filepath;
	}
	public void setFilepath(String filepath) {
		this.filepath = filepath;
	}
	public String getImagepath() {
		return imagepath;
	}
	public void setImagepath(String imagepath) {
		this.imagepath = imagepath;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public String getRealfileName() {
		return realfileName;
	}
	public void setRealfileName(String realfileName) {
		this.realfileName = realfileName;
	}
	public String getBarpath() {
		return barpath;
	}
	public void setBarpath(String barpath) {
		this.barpath = barpath;
	}
	public String getMerpath() {
		return merpath;
	}
	public void setMerpath(String merpath) {
		this.merpath = merpath;
	}
	public String getChnlId() {
		return chnlId;
	}
	public void setChnlId(String chnlId) {
		this.chnlId = chnlId;
	}
	public boolean isCampaignCehck() {	
		return campaignCehck;
	}
	public void setCampaignCehck(boolean campaignCehck) {
		this.campaignCehck = campaignCehck;
	}
	public String getContentsTypeCode() {
		return contentsTypeCode;
	}
	public void setContentsTypeCode(String contentsTypeCode) {
		this.contentsTypeCode = contentsTypeCode;
	}
	public String getMerId() {
		return merId;
	}
	public void setMerId(String merId) {
		this.merId = merId;
	}
	public String getBarId() {
		return barId;
	}
	public void setBarId(String barId) {
		this.barId = barId;
	}
	public String getImgId() {
		return imgId;
	}
	public void setImgId(String imgId) {
		this.imgId = imgId;
	}
	public String getBottom() {
		return bottom;
	}
	public void setBottom(String bottom) {
		this.bottom = bottom;
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
	public String getChnlGuide() {
		return chnlGuide;
	}
	public void setChnlGuide(String chnlGuide) {
		this.chnlGuide = chnlGuide;
	}
	
}
