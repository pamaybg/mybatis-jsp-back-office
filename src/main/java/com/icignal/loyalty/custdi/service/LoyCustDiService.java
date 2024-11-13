package com.icignal.loyalty.custdi.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.core.annotation.handler.AnnotationHelper.AnnotationType;
import com.icignal.loyalty.custdi.dto.request.LoyCustDiDetailReqDto;
import com.icignal.loyalty.custdi.dto.request.LoyCustDiListReqDto;
import com.icignal.loyalty.custdi.dto.response.LoyCustDiDetailResDto;
import com.icignal.loyalty.custdi.dto.response.LoyCustDiListResDto;
import com.icignal.loyalty.custdi.dto.response.LoyCustDiValListResDto;
import com.icignal.loyalty.custdi.dto.response.LoyCustDupRstDetailResDto;
import com.icignal.loyalty.custdi.dto.response.LoyCustDupRstResDto;
import com.icignal.loyalty.custdi.mapper.LoyCustDiMapper;


@Service
public class LoyCustDiService {
	
	@Autowired
	LoyCustDiMapper loyCustDiMapper;

	 /*
	  * 1. 메소드명: getCustDiList
	  * 2. 클래스명: LoyCustDiService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 2.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		고객 식별 관리 리스트
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public GridPagingResDto<LoyCustDiListResDto> getCustDiList(LoyCustDiListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return new GridPagingResHelper<LoyCustDiListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), loyCustDiMapper.selectCustDiList(reqDto), AnnotationType.CommCode);
	}

	 /*
	  * 1. 메소드명: getCustDiDetail
	  * 2. 클래스명: LoyCustDiService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 3.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		중복룰 상세
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public LoyCustDiDetailResDto getCustDiDetail(LoyCustDiDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return loyCustDiMapper.selectCustDiDetail(reqDto);
	}

	 /*
	  * 1. 메소드명: getCustDiValList
	  * 2. 클래스명: LoyCustDiService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 3.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		중복룰 식별값 리스트
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public GridPagingResDto<LoyCustDiValListResDto> getCustDiValList(LoyCustDiDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return new GridPagingResHelper<LoyCustDiValListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), loyCustDiMapper.selectCustDiValList(reqDto), AnnotationType.CommCode);
	}

	 /*
	  * 1. 메소드명: saveCustDiDetail
	  * 2. 클래스명: LoyCustDiService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 4.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		중복룰 상세 저장
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public LoyCustDiDetailResDto saveCustDiDetail(LoyCustDiDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoyCustDiDetailResDto rtnValue = new LoyCustDiDetailResDto();
		rtnValue.setSuccess(false);
		reqDto.setRid(CommonUtil.newRid());
		loyCustDiMapper.insertCustDiDetail(reqDto);
		rtnValue.setRid(reqDto.getRid());
		rtnValue.setSuccess(true);
		return rtnValue;
	}
	
	 /*
	  * 1. 메소드명: modifyCustDiDetail
	  * 2. 클래스명: LoyCustDiService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 4.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		중복룰 상세 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public LoyCustDiDetailResDto modifyCustDiDetail(LoyCustDiDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoyCustDiDetailResDto rtnValue = new LoyCustDiDetailResDto();
		rtnValue.setSuccess(false);
		loyCustDiMapper.updateCustDiDetail(reqDto);
		rtnValue.setRid(reqDto.getRid());
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getCustDiValDetail
	  * 2. 클래스명: LoyCustDiService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 4.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		식별값 상세
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public LoyCustDiDetailResDto getCustDiValDetail(LoyCustDiDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return loyCustDiMapper.selectCustDiValDetail(reqDto);
	}

	 /*
	  * 1. 메소드명: saveCustDiValDetail
	  * 2. 클래스명: LoyCustDiService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 4.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		식별값 상세 저장
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto saveCustDiValDetail(LoyCustDiDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		int check  = fieldValCheck(reqDto);
		if(check>0) {
			rtnValue.setMessage("이미 동일한 항목이 있습니다.");
			rtnValue.setSuccess(false);
		}else {
			reqDto.setRid(CommonUtil.newRid());
			loyCustDiMapper.insertCustDiValDetail(reqDto);
			rtnValue.setSuccess(true);
		}
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: modifyCustDiValDetail
	  * 2. 클래스명: LoyCustDiService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 4.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		식별값 상세 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto modifyCustDiValDetail(LoyCustDiDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		int check  = fieldValCheck(reqDto);
		if(check>0) {
			rtnValue.setMessage("이미 동일한 항목이 있습니다.");
			rtnValue.setSuccess(false);
		}else {
			loyCustDiMapper.updateCustDiValDetail(reqDto);
			rtnValue.setSuccess(true);
		}
		return rtnValue;
	}

	public int fieldValCheck(LoyCustDiDetailReqDto reqDto) {
		return loyCustDiMapper.fieldValCheck(reqDto);
	}
	 /*
	  * 1. 메소드명: getCustDupRstList
	  * 2. 클래스명: LoyCustDiService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 5.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		중복결과 리스트
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public GridPagingResDto<LoyCustDupRstResDto> getCustDupRstList(LoyCustDiDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return new GridPagingResHelper<LoyCustDupRstResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), loyCustDiMapper.selectCustDupRstList(reqDto), AnnotationType.ALL);
	}

	 /*
	  * 1. 메소드명: removeCustDiVal
	  * 2. 클래스명: LoyCustDiService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 5.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		식별값 삭제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto removeCustDiVal(LoyCustDiDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		loyCustDiMapper.deleteCustDiVal(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getDupRstDetail
	  * 2. 클래스명: LoyCustDiService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 8.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		고객중복체크 결과 상세 - I: 개인, C: 단체(사업자)
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public GridPagingResDto<LoyCustDupRstDetailResDto>  getDupRstDetail(LoyCustDiDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		GridPagingResDto<LoyCustDupRstDetailResDto> rtnValue = new GridPagingResDto<LoyCustDupRstDetailResDto>();
		if("I".equals(reqDto.getCustTypeCd())) {
			rtnValue = new GridPagingResHelper<LoyCustDupRstDetailResDto>().newGridPagingResDto(
					reqDto.init(CommonUtil.getInstance().getDBType()), loyCustDiMapper.selectDupRstDetailI(reqDto), AnnotationType.ALL);
		} 
		else if("C".equals(reqDto.getCustTypeCd())){
			rtnValue = new GridPagingResHelper<LoyCustDupRstDetailResDto>().newGridPagingResDto(
					reqDto.init(CommonUtil.getInstance().getDBType()), loyCustDiMapper.selectDupRstDetailC(reqDto), AnnotationType.ALL);
		}
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: custMergePrcs
	  * 2. 클래스명: LoyCustDiService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 9.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		중복 결과 병합 처리 (작업상태만 완료로 바뀌게 해놨음 - 추후 개발 필요)
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto custMergePrcs(LoyCustDiDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		loyCustDiMapper.custMergePrcs(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: removeCustDi
	  * 2. 클래스명: LoyCustDiService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 9.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		고객 식별 정책 삭제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto removeCustDi(LoyCustDiListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		loyCustDiMapper.deleteCustDi(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	public LoyCustDiDetailResDto getMaxSeq(LoyCustDiDetailReqDto reqDto) {
		LoyCustDiDetailResDto rtnValue = new LoyCustDiDetailResDto();
		rtnValue.setSuccess(false);
		int seq = loyCustDiMapper.selectMaxSeq(reqDto);
		rtnValue.setSeq(seq);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

}
