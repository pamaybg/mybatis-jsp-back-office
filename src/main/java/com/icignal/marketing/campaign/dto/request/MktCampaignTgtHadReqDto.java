package com.icignal.marketing.campaign.dto.request;

import java.util.List;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.request.MKTBaseReqDto;


/**
 * @name : setSegment
 * @date : 2015. 10. 01.
 * @author : 장  용
 * @description : 세그먼트 저장
 */
public class MktCampaignTgtHadReqDto extends MKTBaseReqDto {

	private String empId;			//직원 아이디
	private String camId;			//캠페인 아이디
	private String accountId;		//어카운트 아이디

	//타겟팅 헤더 저장
	private String targetId;		//대상자 헤더 아이디
	private int allUploadCnt;		//전체 대상 목록
	private String segName;			//세그먼트 명
	private String segType;			//세그먼트 유형 (파일업로드, 템플릿)
	private String calType;			//연산 유형
	private String empName;			//직원명
	private String accountName;		//부서명
	private String memType;			//회원 유형 (내부고객 / 외부고객)

	private int targetCustCnt;		//전체 타겟 고객 수
	private int addTargetCustCnt;   //추가된 전체 타겟 고객 수
	private int agreeCust;			//채널 수신 동의 고객 수
	private int fatiCnt;			//피로도 카운트
	private int prmsCnt;			//퍼미션 카운트
	private int dupCnt;				//중복 건수

	//세그먼트 저장
	private String chnlType;		//채널 유형

	//업로드 대상자 저장
	private String fileName;		//파일 명
	private String fileType;		//파일 유형
	private int successCnt;			//성공 카운트
	private int failCnt;			//실패 카운트

	//캠페인 대상자 상세
	private List<MktMemberItemReqDto> memIds;	//회원 정보

	private String targetGroupId;       //타겟그룹 아이디

	private String ctrlGroupUnitCd;		//비교군 유형코드
	private String ctrlGroupAmt;		//비교율/건
	private String ctrlGroupCnt;		//비교군 수
	private String ctrlGroupId;			//비교군 그룹 아이디

	private String addData = "0"; //추가데이터

	//파일 업로드 헤더 / 대상자 복사 여부
	private boolean copyFlag;	//복사여부
		
	public int getAddTargetCustCnt() {
        return addTargetCustCnt;
    }

    public void setAddTargetCustCnt(int addTargetCustCnt) {
        this.addTargetCustCnt = addTargetCustCnt;
    }

    public String getAddData() {
        return addData;
    }

    public void setAddData(String addData) {
        this.addData = addData;
    }

    public String getEmpId() {
		return empId;
	}

	public void setEmpId(String empId) {
		this.empId = empId;
	}

	public String getSegName() {
		return segName;
	}

	public void setSegName(String segName) {
		this.segName = segName;
	}

	public String getSegType() {
		return segType;
	}

	public void setSegType(String segType) {
		this.segType = segType;
	}

	public String getTargetId() {
		return targetId;
	}

	public void setTargetId(String targetId) {
		this.targetId = targetId;
	}

	public int getDupCnt() {
		return dupCnt;
	}

	public void setDupCnt(int dupCnt) {
		this.dupCnt = dupCnt;
	}

	public int getAllUploadCnt() {
		return allUploadCnt;
	}

	public void setAllUploadCnt(int allUploadCnt) {
		this.allUploadCnt = allUploadCnt;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public List<MktMemberItemReqDto> getMemIds() {
		return memIds;
	}

	public void setMemIds(List<MktMemberItemReqDto> memIds) {
		this.memIds = memIds;
	}

	public String getFileType() {
		return fileType;
	}

	public void setFileType(String fileType) {
		this.fileType = fileType;
	}

	public int getSuccessCnt() {
		return successCnt;
	}

	public void setSuccessCnt(int successCnt) {
		this.successCnt = successCnt;
	}

	public int getFailCnt() {
		return failCnt;
	}

	public void setFailCnt(int failCnt) {
		this.failCnt = failCnt;
	}

	public String getCalType() {
		return calType;
	}

	public void setCalType(String calType) {
		this.calType = calType;
	}

	public String getCamId() {
		return camId;
	}

	public void setCamId(String camId) {
		this.camId = camId;
	}

	public String getEmpName() {
		return empName;
	}

	public void setEmpName(String empName) {
		this.empName = empName;
	}

	public String getAccountName() {
		return accountName;
	}

	public void setAccountName(String accountName) {
		this.accountName = accountName;
	}

	public String getMemType() {
		return memType;
	}

	public void setMemType(String memType) {
		this.memType = memType;
	}

	public String getChnlType() {
		return chnlType;
	}

	public void setChnlType(String chnlType) {
		this.chnlType = chnlType;
	}

	public int getTargetCustCnt() {
		return targetCustCnt;
	}

	public void setTargetCustCnt(int targetCustCnt) {
		this.targetCustCnt = targetCustCnt;
	}

	public int getAgreeCust() {
		return agreeCust;
	}

	public void setAgreeCust(int agreeCust) {
		this.agreeCust = agreeCust;
	}

	public int getFatiCnt() {
		return fatiCnt;
	}

	public void setFatiCnt(int fatiCnt) {
		this.fatiCnt = fatiCnt;
	}

	public int getPrmsCnt() {
		return prmsCnt;
	}

	public void setPrmsCnt(int prmsCnt) {
		this.prmsCnt = prmsCnt;
	}

	public String getAccountId() {
		return accountId;
	}

	public void setAccountId(String accountId) {
		this.accountId = accountId;
	}

    public String getTargetGroupId() {
        return targetGroupId;
    }

    public void setTargetGroupId(String targetGroupId) {
        this.targetGroupId = targetGroupId;
    }

	public String getCtrlGroupUnitCd() {
		return ctrlGroupUnitCd;
	}

	public void setCtrlGroupUnitCd(String ctrlGroupUnitCd) {
		this.ctrlGroupUnitCd = ctrlGroupUnitCd;
	}

	public String getCtrlGroupAmt() {
		return ctrlGroupAmt;
	}

	public void setCtrlGroupAmt(String ctrlGroupAmt) {
		this.ctrlGroupAmt = ctrlGroupAmt;
	}

	public String getCtrlGroupCnt() {
		return ctrlGroupCnt;
	}

	public void setCtrlGroupCnt(String ctrlGroupCnt) {
		this.ctrlGroupCnt = ctrlGroupCnt;
	}

    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

	public boolean isCopyFlag() {
		return copyFlag;
	}

	public void setCopyFlag(boolean copyFlag) {
		this.copyFlag = copyFlag;
	}

	public String getCtrlGroupId() {
		return ctrlGroupId;
	}

	public void setCtrlGroupId(String ctrlGroupId) {
		this.ctrlGroupId = ctrlGroupId;
	}
}
