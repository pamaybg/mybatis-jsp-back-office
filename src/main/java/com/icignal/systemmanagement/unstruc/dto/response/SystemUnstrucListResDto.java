package com.icignal.systemmanagement.unstruc.dto.response;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/*
 * 1. 클래스명	: LoyUnstrucListResDto
 * 2. 파일명	: LoyUnstrucListResDto.java
 * 3. 패키지명	: com.icignal.systemmanagement.unstruc.dto.response
 * 4. 작성자명	: jh.kim
 * 5. 작성일자	: 2017. 6. 15.
 */
/**
 * <PRE>
 * 1. 설명
 *		이벤트 정형/비정형 목록 Response DTO
 * </PRE>
 */ 
@CommCode
public class SystemUnstrucListResDto extends GridPagingItemResDto {
    
    private String nodeTypeCd;       //유형 코드 
    private String nodeTypeNm;
    private String dspVal;           //유형 명(사용x) -> typeMarkName 사용 
    private String createrName;      //등록자이름
    private String rid;              //RID
    private String ridPgm;           //RID 프로그램
    private String ridNodeType;      //RID_NODE_TYPE
    private String subTypeCd;        //서브 유형 코드
    private String subTypeNm;
    private String execCls;          //실행 클래스
    private String execMthd;         //실행 메쏘드
    private String inputScrn;        //이름
    private String desctxt;          //설명
    private String flag;             //FLAG
    private String modNum;           //MOD_NUM
    private String createDate;       //생성일시
    private String createBy;         //CREATE_BY
    private String modifyDate;       //수정일시
    private String modifyBy;         //MODIFY_BY
    private String userId;
    @MarkName(groupCode = "MKT_NODE_TYPE_CD", codeField = "nodeTypeCd")
    private String subTypeMarkName;  //서브 유형 명
    @MarkName(groupCode = "MKT_CAM_NODE_TYPE", codeField = "subTypeCd")
    private String typeMarkName;     //유형 명
    
    public String getTypeMarkName() {
        return typeMarkName;
    }
    
    public void setTypeMarkName(String typeMarkName) {
        this.typeMarkName = typeMarkName;
    }
    
    public String getNodeTypeCd() {
        return nodeTypeCd;
    }
    
    public void setNodeTypeCd(String nodeTypeCd) {
        this.nodeTypeCd = nodeTypeCd;
    }
    
    public String getRid() {
        return rid;
    }
    
    public void setRid(String rid) {
        this.rid = rid;
    }
    
    public String getRidPgm() {
        return ridPgm;
    }
    
    public void setRidPgm(String ridPgm) {
        this.ridPgm = ridPgm;
    }
    
    public String getRidNodeType() {
        return ridNodeType;
    }
    
    public void setRidNodeType(String ridNodeType) {
        this.ridNodeType = ridNodeType;
    }
    
    public String getSubTypeCd() {
        return subTypeCd;
    }
    
    public void setSubTypeCd(String subTypeCd) {
        this.subTypeCd = subTypeCd;
    }
    
    public String getExecCls() {
        return execCls;
    }
    
    public void setExecCls(String execCls) {
        this.execCls = execCls;
    }
    
    public String getExecMthd() {
        return execMthd;
    }
    
    public void setExecMthd(String execMthd) {
        this.execMthd = execMthd;
    }
    
    public String getInputScrn() {
        return inputScrn;
    }
    
    public void setInputScrn(String inputScrn) {
        this.inputScrn = inputScrn;
    }
    
    public String getDesctxt() {
        return desctxt;
    }
    
    public void setDesctxt(String desctxt) {
        this.desctxt = desctxt;
    }
    
    public String getFlag() {
        return flag;
    }
    
    public void setFlag(String flag) {
        this.flag = flag;
    }
    
    public String getModNum() {
        return modNum;
    }
    
    public void setModNum(String modNum) {
        this.modNum = modNum;
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
    
    public String getModifyDate() {
        return modifyDate;
    }
    
    public void setModifyDate(String modifyDate) {
        this.modifyDate = modifyDate;
    }
    
    public String getModifyBy() {
        return modifyBy;
    }
    
    public void setModifyBy(String modifyBy) {
        this.modifyBy = modifyBy;
    }
    
    public String getUserId() {
        return userId;
    }
    
    public void setUserId(String userId) {
        this.userId = userId;
    }
    
    public String getDspVal() {
        return dspVal;
    }
    
    public void setDspVal(String dspVal) {
        this.dspVal = dspVal;
    }
    
    public String getSubTypeMarkName() {
        return subTypeMarkName;
    }
    
    public void setSubTypeMarkName(String subTypeMarkName) {
        this.subTypeMarkName = subTypeMarkName;
    }
    
    public String getCreaterName() {
        return createrName;
    }

    public void setCreaterName(String createrName) {
        this.createrName = createrName;
    }

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

	public String getSubTypeNm() {
		return subTypeNm;
	}

	public void setSubTypeNm(String subTypeNm) {
		this.subTypeNm = subTypeNm;
	}

	public String getNodeTypeNm() {
		return nodeTypeNm;
	}

	public void setNodeTypeNm(String nodeTypeNm) {
		this.nodeTypeNm = nodeTypeNm;
	}
}
