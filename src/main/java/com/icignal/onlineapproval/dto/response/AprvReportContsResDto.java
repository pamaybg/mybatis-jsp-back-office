package com.icignal.onlineapproval.dto.response;

import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;

/**
 * 승인레포트 : 캠페인 컨텐츠(채널발송) 정보 Response DTO
 * 
 * @name : infavor.marketing.elapproval.dto.response.MKTAprvReportContsResponseDTO
 * @date : 2018. 3. 1.
 * @author : jh.kim
 * @description :
 */
@CommCode
public class AprvReportContsResDto {
    
    private String contsId;            //컨텐츠ID 
    private String exeChnlTypeCd;      //실행유형 
    
    @MarkName(groupCode = "MKT_CAM_CHNL_TYPE_CD", codeField = "exeChnlTypeCd")
    private String exeChnlTypeNm;      //실행유형명
    private String contsTitle;         //제목   
    private String contsSbst;          //내용   
    private String contsHtml;          //html내
    private String contsPushTypeCd;    //푸시유형 
    private String contsBottom;        //수신거부번호
    private String imgId;
    private String subImgId;
    private String imgSrc;
    private String subImgSrc;
    private String attrib02;
    private String attrib03;
    
    public String getExeChnlTypeNm() {
        return exeChnlTypeNm;
    }
    public void setExeChnlTypeNm(String exeChnlTypeNm) {
        this.exeChnlTypeNm = exeChnlTypeNm;
    }
    public String getSubImgId() {
        return subImgId;
    }
    public void setSubImgId(String subImgId) {
        this.subImgId = subImgId;
    }
    public String getSubImgSrc() {
        return subImgSrc;
    }
    public void setSubImgSrc(String subImgSrc) {
        this.subImgSrc = subImgSrc;
    }
    public String getImgSrc() {
        return imgSrc;
    }
    public void setImgSrc(String imgSrc) {
        this.imgSrc = imgSrc;
    }
    public String getImgId() {
        return imgId;
    }
    public void setImgId(String imgId) {
        this.imgId = imgId;
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
    public String getContsId() {
        return contsId;
    }
    public void setContsId(String contsId) {
        this.contsId = contsId;
    }
    public String getExeChnlTypeCd() {
        return exeChnlTypeCd;
    }
    public void setExeChnlTypeCd(String exeChnlTypeCd) {
        this.exeChnlTypeCd = exeChnlTypeCd;
    }
    public String getContsTitle() {
        return contsTitle;
    }
    public void setContsTitle(String contsTitle) {
        this.contsTitle = contsTitle;
    }
    public String getContsSbst() {
        return contsSbst;
    }
    public void setContsSbst(String contsSbst) {
        this.contsSbst = contsSbst;
    }
    public String getContsHtml() {
        return contsHtml;
    }
    public void setContsHtml(String contsHtml) {
        this.contsHtml = contsHtml;
    }
    public String getContsPushTypeCd() {
        return contsPushTypeCd;
    }
    public void setContsPushTypeCd(String contsPushTypeCd) {
        this.contsPushTypeCd = contsPushTypeCd;
    }
    public String getContsBottom() {
        return contsBottom;
    }
    public void setContsBottom(String contsBottom) {
        this.contsBottom = contsBottom;
    }
}
