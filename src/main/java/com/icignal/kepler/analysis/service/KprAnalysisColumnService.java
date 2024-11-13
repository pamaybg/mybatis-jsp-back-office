package com.icignal.kepler.analysis.service;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.ObjectUtil;
import com.icignal.core.component.Messages;
import com.icignal.kepler.analysis.common.dto.request.KprAnalysisCommonReqDto;
import com.icignal.kepler.analysis.common.service.KprAnalysisCommonSerivce;
import com.icignal.kepler.analysis.dto.request.KprAnalysisColumnDetailReqDto;
import com.icignal.kepler.analysis.dto.response.KprAnalysisAtribGroupColumnDetailResDto;
import com.icignal.kepler.analysis.dto.response.KprAnalysisColumnDetailResDto;

/*
 * 1. 클래스명	: KPRAnalysisColumnService
 * 2. 파일명	: KPRAnalysisColumnService.java
 * 3. 패키지명	: com.icignal.kepler.analysis.service
 * 4. 작성자명	: hr.noh
 * 5. 작성일자	: 2020. 3. 16.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
@Service("KprAnalysisColumnService")
public class KprAnalysisColumnService extends KprAnalysisCommonSerivce {
	
	 /*
	  * 1. 메소드명: getAnalysisColumnList
	  * 2. 클래스명: KPRAnalysisColumnService
	  * 3. 작성자명: 
	  * 4. 작성일자: 2020. 3. 16.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param acr
	 *   @return	
	 */
	public List<KprAnalysisColumnDetailResDto> getAnalysisColumnList(KprAnalysisColumnDetailReqDto acr) {
		LogUtil.param(this.getClass(), acr);
		acr.setSVCAlias("arc");
		return this.kprAnalysisColumnMapper.selectAnalysisColumnList(acr);
	}

	 /*
	  * 1. 메소드명: getAnalysisColumnDetail
	  * 2. 클래스명: KPRAnalysisColumnService
	  * 3. 작성자명: 
	  * 4. 작성일자: 2020. 3. 16.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param acr
	 *   @return	
	 */
	public KprAnalysisColumnDetailResDto getAnalysisColumnDetail(KprAnalysisColumnDetailReqDto acr) {
		LogUtil.param(this.getClass(), acr);
		acr.setSVCAlias("arc");
		KprAnalysisColumnDetailResDto resDto = this.kprAnalysisColumnMapper.selectAnalysisColumnDetailInst(acr);
		String orderDetail = resDto.getOrderDetail();
		if (ObjectUtil.isNotEmpty(orderDetail)) {
			Pattern pattern = Pattern.compile("when '([\\S]*)' then");
			Matcher matcher = pattern.matcher(orderDetail);

			List<String> orderDetailList = new ArrayList<String>();

			while (matcher.find()) {
				String orderValue = matcher.group(1);
				orderDetailList.add(orderValue);
			}

			resDto.setOrderDetailList(orderDetailList);
			resDto.setOrderDetail("");
		}
		
		resDto.setSuccess(true);

		return resDto;
	}

	 /*
	  * 1. 메소드명: addAnalysisColumnDetail
	  * 2. 클래스명: KPRAnalysisColumnService
	  * 3. 작성자명: 
	  * 4. 작성일자: 2020. 3. 16.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param acr
	 *   @return	
	 */
	@Transactional
	public List<KprAnalysisColumnDetailResDto> addAnalysisColumnDetail(KprAnalysisColumnDetailReqDto acr) {
		LogUtil.param(this.getClass(), acr);
		acr.setSVCAlias("");
		List<KprAnalysisColumnDetailReqDto> columnList = acr.getColumnList();
		List<KprAnalysisColumnDetailResDto> resList = new ArrayList<KprAnalysisColumnDetailResDto>();

//		this.startTransaction();

		if (ObjectUtil.isNotEmpty(columnList)) {
			for (KprAnalysisColumnDetailReqDto columnReqDto : columnList) {
				String columnDisplayName = columnReqDto.getColumnDisplayName();

				columnReqDto.setLikeFlag("Y");
				
				Integer columnDisplayCount = this.kprAnalysisColumnMapper.selectAnalysisColumnDisplayNameCount(columnReqDto);
				if (columnDisplayCount.intValue() > 0) {
					columnDisplayName = columnDisplayName + "_" + (columnDisplayCount.intValue() + 1);
					columnReqDto.setColumnDisplayName(columnDisplayName);
				}

				columnReqDto.setEmpId(acr.getEmpId());
				this.kprAnalysisColumnMapper.insertAnalysisColumnDetailInst(columnReqDto);

				KprAnalysisColumnDetailResDto resDto = new KprAnalysisColumnDetailResDto();
				resDto.setColumnId(columnReqDto.getColumnId());
				resDto.setColumnDisplayName(columnDisplayName);
				resList.add(resDto);
			}
		}

//		this.commitTransaction();
//		this.endTransaction();
		return resList;
	}

	 /*
	  * 1. 메소드명: editAnalysisColumnDetail
	  * 2. 클래스명: KPRAnalysisColumnService
	  * 3. 작성자명: 
	  * 4. 작성일자: 2020. 3. 16.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param acr
	 *   @return	
	 */
	public StatusResDto editAnalysisColumnDetail(KprAnalysisColumnDetailReqDto acr) {
		LogUtil.param(this.getClass(), acr);
		acr.setSVCAlias("");
		String orderAtribGroupColumnId = acr.getOrderAtribGroupColumnId();
		if (ObjectUtil.isNotEmpty(orderAtribGroupColumnId)) {
			KprAnalysisCommonReqDto analysisCommonReqDto = new KprAnalysisCommonReqDto();
			analysisCommonReqDto.setAtribGroupColumnId(orderAtribGroupColumnId);
			analysisCommonReqDto.setLang(acr.getLang());
			List<KprAnalysisAtribGroupColumnDetailResDto> atribGroupColumnList = this.kprAnalysisMapper.selectAnalysisAtribGroupColumnDetail(analysisCommonReqDto);
			KprAnalysisAtribGroupColumnDetailResDto atribGroupColumnResDto = atribGroupColumnList.get(0);
			boolean singQuoteFlag = "Y".equals(atribGroupColumnResDto.getSingleQuoteFlag()) ? false : true;

			List<KprAnalysisColumnDetailReqDto> orderDetailList = acr.getOrderDetailList();
			if (ObjectUtil.isNotEmpty(orderDetailList)) {
				StringBuilder orderDetail = new StringBuilder();

				for (KprAnalysisColumnDetailReqDto orderDetailDto : orderDetailList) {
					String orderValue = orderDetailDto.getOrderValue();

					if (singQuoteFlag) {
						orderValue = "'" + orderValue + "'";
					}

					orderDetail.append(" when " + orderValue + " then " + orderDetailDto.getOrderIndex());
				}

				acr.setOrderDetail(orderDetail.toString());
			}
		}

		acr.setLikeFlag("N");
		Integer columnDisplayCount = this.kprAnalysisColumnMapper.selectAnalysisColumnDisplayNameCount(acr);

		StatusResDto rstValue = new StatusResDto();
		if (columnDisplayCount.intValue() == 0) {
			this.kprAnalysisColumnMapper.updateAnalysisColumnDetailInst(acr);

			rstValue.setSuccess(true);
		} else {
			rstValue.setSuccess(false);
			rstValue.setMessage(Messages.getMessage("M01468", acr.getLang()));
		}

		return rstValue;
	}

	 /*
	  * 1. 메소드명: editAnalysisColumnAllSequence
	  * 2. 클래스명: KPRAnalysisColumnService
	  * 3. 작성자명: 
	  * 4. 작성일자: 2020. 3. 16.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param acr
	 *   @return	
	 */
	public StatusResDto editAnalysisColumnAllSequence(KprAnalysisColumnDetailReqDto acr) {
		LogUtil.param(this.getClass(), acr);
		acr.setSVCAlias("");
		StatusResDto rtnValue = new StatusResDto();
		this.kprAnalysisColumnMapper.updateAnalysisColumnAllSequenceInst(acr);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: editAnalysisColumnTypeCodeChange
	  * 2. 클래스명: KPRAnalysisColumnService
	  * 3. 작성자명: 
	  * 4. 작성일자: 2020. 3. 16.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param acr
	 *   @return	
	 */
	public StatusResDto editAnalysisColumnTypeCodeChange(KprAnalysisColumnDetailReqDto acr) {
		LogUtil.param(this.getClass(), acr);
		acr.setSVCAlias("");
		StatusResDto rtnValue = new StatusResDto();
		this.kprAnalysisColumnMapper.updateAnalysisColumnTypeCodeChangeInst(acr);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: editAnalysisColumnCombTypeChange
	  * 2. 클래스명: KPRAnalysisColumnService
	  * 3. 작성자명: 
	  * 4. 작성일자: 2020. 3. 16.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param acr
	 *   @return	
	 */
	public StatusResDto editAnalysisColumnCombTypeChange(KprAnalysisColumnDetailReqDto acr) {
		LogUtil.param(this.getClass(), acr);
		acr.setSVCAlias("");
		StatusResDto rtnValue = new StatusResDto();
		this.kprAnalysisColumnMapper.updateAnalysisColumnCombTypeChangeInst(acr);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: removeAnalysisColumnDetail
	  * 2. 클래스명: KPRAnalysisColumnService
	  * 3. 작성자명: 
	  * 4. 작성일자: 2020. 3. 16.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param acr
	 *   @return	
	 */
	@Transactional
	public StatusResDto removeAnalysisColumnDetail(KprAnalysisColumnDetailReqDto acr) {
		LogUtil.param(this.getClass(), acr);
		acr.setSVCAlias("arc");
		KprAnalysisColumnDetailResDto columnDetail = this.kprAnalysisColumnMapper.selectAnalysisColumnDetailInst(acr);
		acr.setSeq(columnDetail.getSeq());

		StatusResDto rstValue = new StatusResDto();
//		this.startTransaction();
		acr.setSVCAlias("");
		this.kprAnalysisColumnMapper.deleteAnalysisColumnDetailInst(acr);

		this.kprAnalysisColumnMapper.updateAnalysisColumnSequenceInst(acr);

//		this.commitTransaction();
//		this.endTransaction();
		rstValue.setSuccess(true);

		return rstValue;
	}

	 /*
	  * 1. 메소드명: getAnalysisSameTableColumnList
	  * 2. 클래스명: KPRAnalysisColumnService
	  * 3. 작성자명: 
	  * 4. 작성일자: 2020. 3. 16.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public List<KprAnalysisColumnDetailResDto> getAnalysisSameTableColumnList(KprAnalysisColumnDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		reqDto.setSVCAlias("");
		return this.kprAnalysisColumnMapper.selectAnalysisSameTableColumnList(reqDto);
	}
}