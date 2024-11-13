package com.icignal.loyalty.family.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.logging.helper.LoggingHelper;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.core.annotation.handler.AnnotationHelper;
import com.icignal.core.annotation.handler.AnnotationHelper.AnnotationType;
import com.icignal.loyalty.family.dto.request.LoyFamilyListReqDto;
import com.icignal.loyalty.family.dto.response.LoyFamilyCallbackResDto;
import com.icignal.loyalty.family.dto.response.LoyFamilyListResDto;
import com.icignal.loyalty.family.mapper.LoyFamilyMapper;

/*
 * 1. 클래스명	: LoyFamilyService
 * 2. 파일명	: LoyFamilyService.java
 * 3. 패키지명	: com.icignal.loyalty.famaily.service
 * 4. 작성자명	: hr.noh
 * 5. 작성일자	: 2020. 6. 22.
 */
/**
 * <PRE>
 * 1. 설명
 *		패밀리 Service
 * </PRE>
 */ 
@Service
public class LoyFamilyService {

	@Autowired
	LoyFamilyMapper loyFamilyMapper;

	@Autowired
	LoggingHelper loggingHelper;
	
	 /*
	  * 1. 메소드명: getFamilyList
	  * 2. 클래스명: LoyFamilyService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 22.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		패밀리 리스트
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public GridPagingResDto<LoyFamilyListResDto> getFamilyList(LoyFamilyListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return new GridPagingResHelper<LoyFamilyListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), loyFamilyMapper.selectFamilyList(reqDto), AnnotationType.ALL);
	}

	 /*
	  * 1. 메소드명: clearMaskFamilyList
	  * 2. 클래스명: LoyFamilyService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 22.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		패밀리 회원 마스킹해제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public LoyFamilyListResDto clearMaskFamilyList(LoyFamilyListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		loggingHelper.insertCustReleaLog(reqDto, "loy_family"); // 이력 저장
	    return new AnnotationHelper<LoyFamilyListResDto>(AnnotationType.ALL, loyFamilyMapper.clearMaskFamilyList(reqDto)).getItem();
	}

	 /*
	  * 1. 메소드명: saveApprProcess
	  * 2. 클래스명: LoyFamilyService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		패밀리 승인처리
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto saveApprProcess(LoyFamilyListReqDto reqDto) {
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		loyFamilyMapper.updateApprProcess(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: saveCanlProcess
	  * 2. 클래스명: LoyFamilyService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 23.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		패밀리 해제처리
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	@Transactional
	public StatusResDto saveCanlProcess(LoyFamilyListReqDto reqDto) {
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		//패밀리 활성해지
		loyFamilyMapper.updateCanlProcess(reqDto);
		//탈퇴이력남기기
		reqDto.setRid(CommonUtil.newRid());
		loyFamilyMapper.insertFmlyMbrHist(reqDto);
		//패밀리 구성원 탈퇴처리
		loyFamilyMapper.updateMbrCanlProcess(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: saveNewFmly
	  * 2. 클래스명: LoyFamilyService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		패밀리 신규 가입(프로시저 사용)
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public LoyFamilyCallbackResDto saveNewFmly(LoyFamilyListReqDto reqDto) {
		LoyFamilyCallbackResDto rtnValue = new LoyFamilyCallbackResDto();
		loyFamilyMapper.saveNewFmly(reqDto);
		
		rtnValue.setRst(reqDto.getRst());
		rtnValue.setRstMsg(reqDto.getRstMsg());
		rtnValue.setRstCd(reqDto.getRstCd());
		rtnValue.setSuccess(true);
		if (!rtnValue.getRst().equals("S")) {
			rtnValue.setSuccess(false);
			rtnValue.setMessage(rtnValue.getRstMsg());
		}
		return rtnValue;
	}
	
	 /*
	  * 1. 메소드명: addMbr
	  * 2. 클래스명: LoyFamilyService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 8. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원가입 TYPE으로 만들어 본것 (현재 사용 안함)
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return
	 *   @throws SQLException	
	 */
	public LoyFamilyCallbackResDto addMbr(LoyFamilyListReqDto reqDto) throws SQLException {
		LogUtil.param(this.getClass(), reqDto);
		LoyFamilyCallbackResDto rtnValue = new LoyFamilyCallbackResDto();
		// fmly
		Map<String,Object> fmlyTbl = new HashMap<String,Object>();
		
		fmlyTbl.put("REP_MBR_NO", reqDto.getRepMbrNo());
		fmlyTbl.put("FMLY_NM", reqDto.getFmlyNm());
		Object  tyFmlyTbl = fmlyTbl;

		
		// fmlyMbr
		Object [] arg2 = new Object []{
			reqDto.getMbrNo(),
			reqDto.getRelCd(),
			reqDto.getRepMbrNo()
		};


		if(fmlyTbl.size() == 0 || arg2.length == 0){
			rtnValue.setSuccess(false);
			if(fmlyTbl.size() == 0){
				rtnValue.setMessage("패밀리정보가 누락 되었습니다.");
			}else if(arg2.length == 0){
				rtnValue.setMessage("패밀리 회원정보가 누락 되었습니다.");
			}
			return rtnValue;
		}		

		Map<String,Object> map = new HashMap<String,Object>();
		map.put("tyFmlyTbl",tyFmlyTbl); // 패밀리

		loyFamilyMapper.addFmly(map);
		
		rtnValue.setRst((String)map.get("rst"));
		rtnValue.setRstMsg((String)map.get("rstMsg"));
		rtnValue.setRstCd((String)map.get("rstCd"));
		rtnValue.setSuccess(true);
		if (!rtnValue.getRst().equals("S")) {
			rtnValue.setSuccess(false);
			rtnValue.setMessage((String)map.get("rstMsg"));
		}
		return rtnValue;
	}
	
}
