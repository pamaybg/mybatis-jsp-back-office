package com.icignal.systemmanagement.unstruc.dto.request;

import org.apache.commons.lang.builder.ToStringBuilder;

import com.icignal.common.base.dto.request.MKTBaseReqDto;

/*
 * 1. 클래스명	: LoyUnstrucDetailReqDto
 * 2. 파일명	: LoyUnstrucDetailReqDto.java
 * 3. 패키지명	: com.icignal.systemmanagement.unstruc.dto.request
 * 4. 작성자명	: jh.kim
 * 5. 작성일자	: 2017. 6. 22.
 */
/**
 * <PRE>
 * 1. 설명
 *		이벤트 정형/비정형 상세정보 Request DTO
 * </PRE>
 */ 
public class SystemUnstrucDetailReqDto extends MKTBaseReqDto {
    
    private String rid;              //RID
    private String ridPgm;           //RID 프로그램
    private String ridNodeType;      //RID_NODE_TYPE
    private String nodeTypeCd;       //RID_NODE_TYPE
    private String subTypeCd;        //서브 유형 코드
    private String execCls;          //실행 클래스
    private String execMthd;         //실행 메쏘드
    private String inputScrn;        //이름
    private String desctxt;          //설명
    private String accntId;          //ACCNT_ID
    private String appServiceType;   //APP_SERVICE_TYPE
    private String flag;             //FLAG
    private String modNum;           //MOD_NUM
    
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
    
    public String getAccntId() {
        return accntId;
    }
    
    public void setAccntId(String accntId) {
        this.accntId = accntId;
    }
    
    public String getAppServiceType() {
        return appServiceType;
    }
    
    public void setAppServiceType(String appServiceType) {
        this.appServiceType = appServiceType;
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
    
    public String getNodeTypeCd() {
        return nodeTypeCd;
    }

    public void setNodeTypeCd(String nodeTypeCd) {
        this.nodeTypeCd = nodeTypeCd;
    }

    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }
}
