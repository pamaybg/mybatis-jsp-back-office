package com.icignal.marketing.contents.dto.response;

/**
 * @name : MKTEmailDtlResponseDTO
 * @date : 2015. 09. 21.
 * @author : 박지열
 * @description : 이메일 상세 조회
 */
public class MktMmsDtlResDto {
    
	private String id ;			 //아이디
	private String contentsName; //콘텐츠명
	private String contentsType; //타입
	private String title;		 //제목
	private String txtMsgObject; //유형
	private String contents;	 //내용
	private String description;	 //설명
	private String html;		 //html
	private String textByteSize; //텍스트 사이즈
	private String imgSize;		 //이미지 사이즈
	private String imgCnt;		 //이미지 갯수
	private String fileName;	 //파일 이름
	private String filePath;	 //파일 경로
	private String imagepath;	 //이미지 경로
	private String imagename;    //이미지 이름
	private String imgId;		 //이미지 아이디
	private String barpath;		 //바코드 경로
	private String barId;		 //바코드 아이디
	private String merpath;		 //머지 이미지 경로
	private String merId;	     //머지 아이디
	private String bottom;
	private String imgLinkUrl;
	private String chnlGuide;	//채널 가이드
	
	private String attrib01;
	private String attrib02;
	private String attrib03;
	private String attrib04;
	private String attrib05;
	private String attrib06;
	private String attrib07;
	private String attrib08;
	private String attrib09;
	private String attrib10;
	
    private String exeDt;		// 실행일자
    private String exeTm;		// 실행시간
	
    private String contsTypeCd;

	private String ridOfr;
    private String ofrNm;

    private String toCallbackNo;	// 송신자번호

	private String ridSurv;
	private String comOfrType;
	private String surveyNm;


	public String getContsTypeCd() {
		return contsTypeCd;
	}
	public void setContsTypeCd(String contsTypeCd) {
		this.contsTypeCd = contsTypeCd;
	}
	public String getChnlGuide() {
		return chnlGuide;
	}
	public void setChnlGuide(String chnlGuide) {
		this.chnlGuide = chnlGuide;
	}
	public String getImgLinkUrl() {
        return imgLinkUrl;
    }
    public void setImgLinkUrl(String imgLinkUrl) {
        this.imgLinkUrl = imgLinkUrl;
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
    public String getAttrib10() {
        return attrib10;
    }
    public void setAttrib10(String attrib10) {
        this.attrib10 = attrib10;
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
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getHtml() {
		return html;
	}
	public void setHtml(String html) {
		this.html = html;
	}
	public String getTextByteSize() {
		return textByteSize;
	}
	public void setTextByteSize(String textByteSize) {
		this.textByteSize = textByteSize;
	}
	public String getImgSize() {
		return imgSize;
	}
	public void setImgSize(String imgSize) {
		this.imgSize = imgSize;
	}
	public String getImgCnt() {
		return imgCnt;
	}
	public void setImgCnt(String imgCnt) {
		this.imgCnt = imgCnt;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public String getImagepath() {
		return imagepath;
	}
	public void setImagepath(String imagepath) {
		this.imagepath = imagepath;
	}
	public String getImagename() {return imagename;}
	public void setImagename(String imagename) {this.imagename = imagename;}
	public String getImgId() {
		return imgId;
	}
	public void setImgId(String imgId) {
		this.imgId = imgId;
	}
	public String getBarpath() {
		return barpath;
	}
	public void setBarpath(String barpath) {
		this.barpath = barpath;
	}
	public String getBarId() {
		return barId;
	}
	public void setBarId(String barId) {
		this.barId = barId;
	}
	public String getMerpath() {
		return merpath;
	}
	public void setMerpath(String merpath) {
		this.merpath = merpath;
	}
	public String getMerId() {
		return merId;
	}
	public void setMerId(String merId) {
		this.merId = merId;
	}
	public String getBottom() {
		return bottom;
	}
	public void setBottom(String bottom) {
		this.bottom = bottom;
	}
	public String getExeDt() {
		return exeDt;
	}
	public void setExeDt(String exeDt) {
		this.exeDt = exeDt;
	}
	public String getExeTm() {
		return exeTm;
	}
	public void setExeTm(String exeTm) {
		this.exeTm = exeTm;
	}

	public String getRidOfr() {
		return ridOfr;
	}

	public void setRidOfr(String ridOfr) {
		this.ridOfr = ridOfr;
	}

	public String getOfrNm() {
		return ofrNm;
	}

	public void setOfrNm(String ofrNm) {
		this.ofrNm = ofrNm;
	}

	public String getToCallbackNo() {
		return toCallbackNo;
	}

	public void setToCallbackNo(String toCallbackNo) {
		this.toCallbackNo = toCallbackNo;
	}

	public String getRidSurv() {
		return ridSurv;
	}

	public void setRidSurv(String ridSurv) {
		this.ridSurv = ridSurv;
	}

	public String getComOfrType() {
		return comOfrType;
	}

	public void setComOfrType(String comOfrType) {
		this.comOfrType = comOfrType;
	}

	public String getSurveyNm() {
		return surveyNm;
	}

	public void setSurveyNm(String surveyNm) {
		this.surveyNm = surveyNm;
	}
}
