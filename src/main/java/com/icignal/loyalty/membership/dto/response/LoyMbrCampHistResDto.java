/**
 * 회원 캠페인이력 응답 DTO
 */
package com.icignal.loyalty.membership.dto.response;

import com.icignal.common.base.dto.response.GridPagingItemResDto;
import com.icignal.core.annotation.commcode.CommCode;
import com.icignal.core.annotation.commcode.MarkName;




/**
  * @fileName : LoyMbrCampHistResponseDTO.java
  * @project : iCignal-Marketing-2.0
  * @date : 2017. 1. 6.
  * @author : knlee
  * @변경이력 :
  * @descripton : 회원 캠페인이력 응답 DTO
  */
@CommCode
public class LoyMbrCampHistResDto  extends GridPagingItemResDto {

	/**적용일자 */
	private String applyDate;

	/**캠페인번호 */
	private String camNo;

	/**캠페인명*/
	private String camNm;

	/**캠페인유형코드*/
	private String camTypeCd;

	/**캠페인유형명*/
	@MarkName(groupCode="MKT_CAM_TYPE_CD", codeField="camTypeCd")
	private String camTypeNm;

	/**오퍼명*/
	private String offerNm;

	/**프로모션유형코드*/
	private String promType;

	/**프로모션혜택*/
	@MarkName(groupCode="LOY_PROM_TYPE", codeField="promType")
	private String promTypeNm;

	/**프로모션서브유형*/
	private String promSubType;

	/**프로모션서브유형*/
	@MarkName(groupCode="LOY_PROM_SUB_TYPE", codeField="promSubType")
	private String promSubTypeNm;

	/**시작일*/
	private String camStartDd;

	/**종료일*/
	private String camEndDd;

	/**캠페인상태코드*/
	private String camStatusCd;

	/**캠페인상태코드*/
	@MarkName(groupCode="MKT_CAM_STAT", codeField="camStatusCd")
	private String camStatusNm;

	/**
	 * @return the camNo
	 */
	public String getCamNo() {
		return camNo;
	}

	/**
	 * @param camNo the camNo to set
	 */
	public void setCamNo(String camNo) {
		this.camNo = camNo;
	}

	/**
	 * @return the camNm
	 */
	public String getCamNm() {
		return camNm;
	}

	/**
	 * @param camNm the camNm to set
	 */
	public void setCamNm(String camNm) {
		this.camNm = camNm;
	}

	/**
	 * @return the camTypeCd
	 */
	public String getCamTypeCd() {
		return camTypeCd;
	}

	/**
	 * @param camTypeCd the camTypeCd to set
	 */
	public void setCamTypeCd(String camTypeCd) {
		this.camTypeCd = camTypeCd;
	}

	/**
	 * @return the camTypeNm
	 */
	public String getCamTypeNm() {
		return camTypeNm;
	}

	/**
	 * @param camTypeNm the camTypeNm to set
	 */
	public void setCamTypeNm(String camTypeNm) {
		this.camTypeNm = camTypeNm;
	}

	/**
	 * @return the offerNm
	 */
	public String getOfferNm() {
		return offerNm;
	}

	/**
	 * @param offerNm the offerNm to set
	 */
	public void setOfferNm(String offerNm) {
		this.offerNm = offerNm;
	}

	/**
	 * @return the promType
	 */
	public String getPromType() {
		return promType;
	}

	/**
	 * @param promType the promType to set
	 */
	public void setPromType(String promType) {
		this.promType = promType;
	}

	/**
	 * @return the promTypeNm
	 */
	public String getPromTypeNm() {
		return promTypeNm;
	}

	/**
	 * @param promTypeNm the promTypeNm to set
	 */
	public void setPromTypeNm(String promTypeNm) {
		this.promTypeNm = promTypeNm;
	}

	/**
	 * @return the promSubType
	 */
	public String getPromSubType() {
		return promSubType;
	}

	/**
	 * @param promSubType the promSubType to set
	 */
	public void setPromSubType(String promSubType) {
		this.promSubType = promSubType;
	}

	/**
	 * @return the promSubTypeNm
	 */
	public String getPromSubTypeNm() {
		return promSubTypeNm;
	}

	/**
	 * @param promSubTypeNm the promSubTypeNm to set
	 */
	public void setPromSubTypeNm(String promSubTypeNm) {
		this.promSubTypeNm = promSubTypeNm;
	}

	/**
	 * @return the camStartDd
	 */
	public String getCamStartDd() {
		return camStartDd;
	}

	/**
	 * @param camStartDd the camStartDd to set
	 */
	public void setCamStartDd(String camStartDd) {
		this.camStartDd = camStartDd;
	}

	/**
	 * @return the camEndDd
	 */
	public String getCamEndDd() {
		return camEndDd;
	}

	/**
	 * @param camEndDd the camEndDd to set
	 */
	public void setCamEndDd(String camEndDd) {
		this.camEndDd = camEndDd;
	}

	/**
	 * @return the camStatusCd
	 */
	public String getCamStatusCd() {
		return camStatusCd;
	}

	/**
	 * @param camStatusCd the camStatusCd to set
	 */
	public void setCamStatusCd(String camStatusCd) {
		this.camStatusCd = camStatusCd;
	}

	/**
	 * @return the camStatusNm
	 */
	public String getCamStatusNm() {
		return camStatusNm;
	}

	/**
	 * @param camStatusNm the camStatusNm to set
	 */
	public void setCamStatusNm(String camStatusNm) {
		this.camStatusNm = camStatusNm;
	}

	/**
	 * @return the applyDate
	 */
	public String getApplyDate() {
		return applyDate;
	}

	/**
	 * @param applyDate the applyDate to set
	 */
	public void setApplyDate(String applyDate) {
		this.applyDate = applyDate;
	}







}
