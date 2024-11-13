package com.icignal.kepler.operation.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;

/**
 * @name : infavor.kepler.operation.dto.response
 * @date : 2016. 7. 18.
 * @author : 이원준
 * @description : 주제영역 목록 ResponseDTO
 */
public class KprSubjectAreaListResDto extends GridPagingItemResDto {
	
    private String subjectAreaId;     //아이디
    private String createByName;     //생성자명
    private String createDate;     //생성일시
    private String subjectAreaNm;     	//주제영역명
    private String subjectDesc;    //주제영역설명
    
    private String id;    //db정보아이디
    private String text;    //db정보아이디
    private String parentId;    //db정보아이디
    private Integer seq;    //순서
    
    private String delFlag;    //삭제여부
	private int cnt;    //주제영역명 중복 카운터
	public String getSubjectAreaId() {
		return subjectAreaId;
	}
	public void setSubjectAreaId(String subjectAreaId) {
		this.subjectAreaId = subjectAreaId;
	}
	public String getCreateByName() {
		return createByName;
	}
	public void setCreateByName(String createByName) {
		this.createByName = createByName;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getSubjectAreaNm() {
		return subjectAreaNm;
	}
	public void setSubjectAreaNm(String subjectAreaNm) {
		this.subjectAreaNm = subjectAreaNm;
	}
	public String getSubjectDesc() {
		return subjectDesc;
	}
	public void setSubjectDesc(String subjectDesc) {
		this.subjectDesc = subjectDesc;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public String getParentId() {
		return parentId;
	}
	public void setParentId(String parentId) {
		this.parentId = parentId;
	}
	public Integer getSeq() {
		return seq;
	}
	public void setSeq(Integer seq) {
		this.seq = seq;
	}
	public String getDelFlag() {
		return delFlag;
	}
	public void setDelFlag(String delFlag) {
		this.delFlag = delFlag;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
    

}
