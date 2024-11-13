package com.icignal.systemmanagement.intact.dto.response;

import org.apache.commons.lang.builder.ToStringBuilder;

/*
 * 1. 클래스명	: SystemIntactDetailResDto
 * 2. 파일명	: SystemIntactDetailResDto.java
 * 3. 패키지명	: com.icignal.systemmanagement.intact.dto.response
 * 4. 작성자명	: jh.kim
 * 5. 작성일자	: 2017. 6. 26.
 */
/**
 * <PRE>
 * 1. 설명
 *		인터렉션 유형 상세 Response DTO
 * </PRE>
 */ 
public class SystemIntactDetailResDto {
    
    private String rid;               //RID
    private String ridPgm;            //RID_PGM
    private String intactType1Cd;     //인터렉션 유형 1 코드
    private String intactType2Cd;     //인터렉션 유형 2 코드
    private String saveTblNm;         //저장 테이블 명
    private String flag;              //FLAG
    private String modNum;            //MOD_NUM
    private String createDate;        //CREATE_DATE
    private String createBy;          //CREATE_BY
    private String modifyDate;        //수정일시
    private String modifyBy;          //MODIFY_BY

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
    
    public String getIntactType1Cd() {
        return intactType1Cd;
    }
    
    public void setIntactType1Cd(String intactType1Cd) {
        this.intactType1Cd = intactType1Cd;
    }
    
    public String getIntactType2Cd() {
        return intactType2Cd;
    }
    
    public void setIntactType2Cd(String intactType2Cd) {
        this.intactType2Cd = intactType2Cd;
    }
    
    public String getSaveTblNm() {
        return saveTblNm;
    }
    
    public void setSaveTblNm(String saveTblNm) {
        this.saveTblNm = saveTblNm;
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
    
    @Override
    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }
}
