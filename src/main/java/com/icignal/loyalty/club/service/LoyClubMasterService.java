package com.icignal.loyalty.club.service;

import java.io.File;
import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.icignal.common.base.dto.response.FileUploadResDto;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.LoyMbrListPopResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.logging.helper.LoggingHelper;
import com.icignal.common.util.BeansUtil;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.core.annotation.handler.AnnotationHelper;
import com.icignal.core.annotation.handler.AnnotationHelper.AnnotationType;
import com.icignal.loyalty.club.dto.request.LoyClubAttrDetailReqDto;
import com.icignal.loyalty.club.dto.request.LoyClubDetailReqDto;
import com.icignal.loyalty.club.dto.request.LoyClubListReqDto;
import com.icignal.loyalty.club.dto.request.LoyClubMbrDetailReqDto;
import com.icignal.loyalty.club.dto.request.LoyClubOfferDetailReqDto;
import com.icignal.loyalty.club.dto.response.LoyClubAttrListResDto;
import com.icignal.loyalty.club.dto.response.LoyClubDetailResDto;
import com.icignal.loyalty.club.dto.response.LoyClubListResDto;
import com.icignal.loyalty.club.dto.response.LoyClubMbrAttrDetailResDto;
import com.icignal.loyalty.club.dto.response.LoyClubMbrListResDto;
import com.icignal.loyalty.club.dto.response.LoyClubOfferListResDto;
import com.icignal.loyalty.club.mapper.LoyClubMasterMapper;

/*
 * 1. 클래스명	: LoyClubMasterService
 * 2. 파일명	: LoyClubService.java
 * 3. 패키지명	: com.icignal.loyalty.club.service
 * 4. 작성자명	: hr.noh
 * 5. 작성일자	: 2020. 5. 13.
 */
/**
 * <PRE>
 * 1. 설명
 *		멤버십 클럽 - Service
 * </PRE>
 */ 
@Service
public class LoyClubMasterService {
	
	@Autowired
	LoyClubMasterMapper loyClubMasterMapper;
	
	@Autowired
	LoggingHelper loggingHelper;

	 /*
	  * 1. 메소드명: getClubList
	  * 2. 클래스명: LoyClubMasterService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클럽 리스트
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public GridPagingResDto<LoyClubListResDto> getClubList(LoyClubListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return new GridPagingResHelper<LoyClubListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), loyClubMasterMapper.selectClubList(reqDto), AnnotationType.CommCode);
	}

	 /*
	  * 1. 메소드명: getClubAttrList
	  * 2. 클래스명: LoyClubMasterService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 15.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클럽 속성 리스트
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public GridPagingResDto<LoyClubAttrListResDto> getClubAttrList(LoyClubListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return new GridPagingResHelper<LoyClubAttrListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), loyClubMasterMapper.selectClubAttrList(reqDto), AnnotationType.CommCode);
	}

	 /*
	  * 1. 메소드명: getClubDetail
	  * 2. 클래스명: LoyClubMasterService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 15.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클럽 상세
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public LoyClubDetailResDto getClubDetail(LoyClubDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return loyClubMasterMapper.selectClubDetail(reqDto);
	}

	 /*
	  * 1. 메소드명: saveClubDetail
	  * 2. 클래스명: LoyClubMasterService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 15.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클럽 상세 저장
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public LoyClubDetailResDto saveClubDetail(LoyClubDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoyClubDetailResDto rtnValue = new LoyClubDetailResDto();
		String rid = CommonUtil.newRid();
		rtnValue.setSuccess(false);
		reqDto.setRid(rid);
		rtnValue.setRid(rid);
		loyClubMasterMapper.insertClubDetail(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}
	
	 /*
	  * 1. 메소드명: modifyClubDetail
	  * 2. 클래스명: LoyClubMasterService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 18.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클럽 상세 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public LoyClubDetailResDto modifyClubDetail(LoyClubDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoyClubDetailResDto rtnValue = new LoyClubDetailResDto();
		rtnValue.setSuccess(false);
		loyClubMasterMapper.updateClubDetail(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: removeClub
	  * 2. 클래스명: LoyClubMasterService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 18.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클럽 삭제 (FLAG = 0)
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto removeClub(LoyClubListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		loyClubMasterMapper.deleteClub(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getClubAttrDetail
	  * 2. 클래스명: LoyClubMasterService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 18.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클럽 속성 상세
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public LoyClubDetailResDto getClubAttrDetail(LoyClubAttrDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return loyClubMasterMapper.selectClubAttrDetail(reqDto);
	}

	 /*
	  * 1. 메소드명: saveClubAttrDetail
	  * 2. 클래스명: LoyClubMasterService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 18.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클럽 속성 상세 저장
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto saveClubAttrDetail(LoyClubAttrDetailReqDto reqDto) {
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		reqDto.setRid(CommonUtil.newRid());
		loyClubMasterMapper.insertClubAttrDetail(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: modifyClubAttrDetail
	  * 2. 클래스명: LoyClubMasterService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 18.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클럽 속성 상세 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto modifyClubAttrDetail(LoyClubAttrDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		loyClubMasterMapper.updateClubAttrDetail(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}
	
	 /*
	  * 1. 메소드명: removeClubAttr
	  * 2. 클래스명: LoyClubMasterService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 18.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클럽 속성정보 삭제 (FLAG = 0)
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto removeClubAttr(LoyClubAttrDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		loyClubMasterMapper.deleteClubAttr(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getClubOfferList
	  * 2. 클래스명: LoyClubMasterService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 18.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클럽 혜택 리스트
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public GridPagingResDto<LoyClubOfferListResDto> getClubOfferList(LoyClubListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return new GridPagingResHelper<LoyClubOfferListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), loyClubMasterMapper.selectClubOfferList(reqDto), AnnotationType.CommCode);
	}

	 /*
	  * 1. 메소드명: saveClubOfferDetail
	  * 2. 클래스명: LoyClubMasterService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클럽 오퍼 상세 저장
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto saveClubOfferDetail(LoyClubOfferDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		reqDto.setRid(CommonUtil.newRid());
		loyClubMasterMapper.insertClubOfferDetail(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: modifyClubOfferDetail
	  * 2. 클래스명: LoyClubMasterService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클럽 오퍼 상세 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto modifyClubOfferDetail(LoyClubOfferDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		loyClubMasterMapper.updateClubOfferDetail(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: removeClubOffer
	  * 2. 클래스명: LoyClubMasterService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클럽 오퍼 삭제(FLAG = 0)
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto removeClubOffer(LoyClubOfferDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		loyClubMasterMapper.deleteClubOffer(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getClubOfferDetail
	  * 2. 클래스명: LoyClubMasterService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클럽 오퍼(혜택)상세
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public LoyClubDetailResDto getClubOfferDetail(LoyClubOfferDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return loyClubMasterMapper.selectClubOfferDetail(reqDto);
	}

	 /*
	  * 1. 메소드명: getClubMbrList
	  * 2. 클래스명: LoyClubMasterService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클럽 회원 리스트
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public GridPagingResDto<LoyClubMbrListResDto> getClubMbrList(LoyClubListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return new GridPagingResHelper<LoyClubMbrListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), loyClubMasterMapper.selectClubMbrList(reqDto), AnnotationType.ALL);
	}

	 /*
	  * 1. 메소드명: getClubAttrInMbr
	  * 2. 클래스명: LoyClubMasterService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 20.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클럽 회원 -> 속성정보 가져오기
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public GridPagingResDto<LoyClubAttrListResDto> getClubAttrInMbr(LoyClubListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return new GridPagingResHelper<LoyClubAttrListResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), loyClubMasterMapper.selectClubAttrInMbr(reqDto),AnnotationType.CommCode);
	}
	
	 /*
	  * 1. 메소드명: getMbrListPop
	  * 2. 클래스명: LoyClubMasterService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 22.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원 리스트 팝업
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public GridPagingResDto<LoyMbrListPopResDto> getClubMbrListPop(LoyClubListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		return new GridPagingResHelper<LoyMbrListPopResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()), loyClubMasterMapper.selectClubMbrListPop(reqDto), AnnotationType.ALL);
	}
	
	 /*
	  * 1. 메소드명: clearMaskMbrNew
	  * 2. 클래스명: LoyClubMasterService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 27.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		고객 리스트 마스킹 해제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public LoyMbrListPopResDto clearMaskMbrNew(LoyClubListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		loggingHelper.insertCustReleaLog(reqDto, "loy_club_mbr"); // 이력 저장

		LoyMbrListPopResDto loyMbrListPopResDto =  loyClubMasterMapper.clearMaskMbrNew(reqDto);
		return new AnnotationHelper<LoyMbrListPopResDto>(AnnotationType.PersonalData, loyMbrListPopResDto).getItem();
	}


	 /*
	  * 1. 메소드명: saveClubMbrDetail
	  * 2. 클래스명: LoyClubMasterService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 22.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클럽 회원 상세 저장
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */

    @Transactional
	public LoyClubDetailResDto saveClubMbrDetail(LoyClubMbrDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		LoyClubDetailResDto rtnValue = new LoyClubDetailResDto();
		rtnValue.setSuccess(false);
		String clubMbrRid = CommonUtil.newRid();
		reqDto.setRidClubMbr(clubMbrRid);
		//LOY_CLUB_MEM_STAT_CD - (접수 : R), (반려 : C), (탈퇴 : W), (승인 : A)
		reqDto.setStatCd("R");
		if(reqDto.getFileNameText().equals("")) setFileVal(reqDto);
		loyClubMasterMapper.insertClubMbr(reqDto);
		if(reqDto.getMbrAttrList() != null) loyClubMasterMapper.insertClubMbrAttrDetail(reqDto);
		rtnValue.setRid(clubMbrRid);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: modifyClubMbrDetail
	  * 2. 클래스명: LoyClubMasterService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 22.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클럽 회원 상세 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
    @Transactional
	public StatusResDto modifyClubMbrDetail(LoyClubMbrDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		if(!reqDto.getStayFile()) {
			int fileValCnt = loyClubMasterMapper.selectFileValueCnt(reqDto);
			if(fileValCnt > 0) {
				//기존의 파일을 삭해주기위해 파일 정보 가져오기
				LoyClubDetailResDto rtnFile = loyClubMasterMapper.selectFileValue(reqDto);
				//String pastFilePName = rtnFile.getFilePName();
				String pastFileLName = rtnFile.getFileLName();
				//저장된 파일중 동일 한 파일이 있는지 확인(Logical Name)
				File pastFile = new File(BeansUtil.getApplicationProperty("icignal.context.resource.excelFileUploadImgPath") + File.separator + "clubMbrFile/" + pastFileLName);
				if (pastFile.exists()) {
					pastFile.delete();
				}
				setFileVal(reqDto);
			}
		}
//		List<LoyClubMbrDetailReqDto> param = new ArrayList<LoyClubMbrDetailReqDto>();
		LoyClubMbrDetailReqDto param = new LoyClubMbrDetailReqDto();
//		param = reqDto.getArray();
		if(reqDto.getMbrAttrList().size() > 0) {
			for(int i=0; i< reqDto.getMbrAttrList().size(); i++) {
				param.setRid(reqDto.getRid());
				param.setEmpId(reqDto.getEmpId());
				param.setRidClub(reqDto.getRidClub());
				param.setRidAttr(reqDto.getMbrAttrList().get(i).getRidAttr());
				param.setVal(reqDto.getMbrAttrList().get(i).getVal());
				if(reqDto.getFileNameText().equals("")) setFileVal(reqDto);
				param.setFileLName(reqDto.getMbrAttrList().get(i).getFileLName());
				param.setFilePName(reqDto.getMbrAttrList().get(i).getFilePName());
				param.setFileName(reqDto.getMbrAttrList().get(i).getFileName());
				
				loyClubMasterMapper.mergeClubMbrDetail(param);
			}
		}else {
			loyClubMasterMapper.updateClubMbrDetail(reqDto);
		}
		
		rtnValue.setSuccess(true);
		return rtnValue;
	}
	
	 /*
	  * 1. 메소드명: setFileVal
	  * 2. 클래스명: LoyClubMasterService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		서버 파일 저장 위치를 DB - val 컬럼에 넣어주기
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 */
	public void setFileVal(LoyClubMbrDetailReqDto reqDto) {
		for(int i = 0; i<reqDto.getMbrAttrList().size(); i++) {
			if(reqDto.getMbrAttrList().get(i).getFileName() != null) {
				reqDto.getMbrAttrList().get(i).setVal(BeansUtil.getApplicationProperty("icignal.context.resource.excelFileUploadImgPath") + File.separator + "clubMbrFile/");
			}
		}
	}

	 /*
	  * 1. 메소드명: getClubMbrDetail
	  * 2. 클래스명: LoyClubMasterService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 22.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클럽 회원 상세(속성값 가져와서 뿌려주기)
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public GridPagingResDto<LoyClubMbrAttrDetailResDto> getClubMbrDetail(LoyClubMbrDetailReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		
		return new GridPagingResHelper<LoyClubMbrAttrDetailResDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),  loyClubMasterMapper.selectClubMbrDetail(reqDto), AnnotationType.PersonalData);
	}


	 /*
	  * 1. 메소드명: clubMbrFileupload
	  * 2. 클래스명: LoyClubMasterService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클럽 회원 증빙서류 파일 업로드
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param realPath
	 *   @param sessionId
	 *   @param file
	 *   @return	
	 */
	@Transactional
	public FileUploadResDto clubMbrFileupload(String sessionId, MultipartFile file, String clubMbrRid,String ridAttr) {
			FileUploadResDto rtnValue = new FileUploadResDto();
			rtnValue.setSuccess(false);
			if (file.getSize() != 0 && file.getSize() < 102400000) { //100MB 제한
				try {
					String id = CommonUtil.newRid(); // 아이디
					String oriFileName = new String(file.getOriginalFilename().getBytes("8859_1"), "UTF-8").toLowerCase(); // 파일명 얻기
					String[] fileTypeArr = oriFileName.split("\\.");

					String fileType = fileTypeArr[fileTypeArr.length - 1].toLowerCase(); // 파일 유형

					if("jpg".equals(fileType) || "jpeg".equals(fileType) || "png".equals(fileType) || "gif".equals(fileType)) {
						String fileName = id + "." + fileType; // 업로드 파일명
						//String fileName = file.getOriginalFilename().toLowerCase(); // 업로드 파일명

						long fileSize = file.getSize(); // 파일 크기

						String uploadPath = BeansUtil.getApplicationProperty("icignal.context.resource.excelFileUploadImgPath") + File.separator + "clubMbrFile/"; // 파일 경로
						
					//String uploadPath = /* realPath + File.separator + */ filePath; // 업로드 경로

						LogUtil.info("파라미터이름:" + file.getName());
						LogUtil.info("파일명:" + file.getOriginalFilename());
						LogUtil.info("파일사이즈:" + file.getSize());
						LogUtil.info("실제 파일 업로드 경로 : " + uploadPath);

						// 업로드 디렉토리 확인
						File uploadfile = new File(uploadPath);
						if (!uploadfile.isDirectory()) {
							uploadfile.mkdirs();
						}

						// 지정한주소에 파일 저장
						file.transferTo(new File(uploadPath + fileName));

						// 반환값
						rtnValue = new FileUploadResDto(id, fileName, oriFileName, uploadPath, fileSize, fileType);
						
						
						loyClubMasterMapper.updateLogicalFileName(fileName, clubMbrRid, ridAttr);
						
						
						rtnValue.setMessage("저장되었습니다.");
						rtnValue.setSuccess(true);
					}else {
						LogUtil.error("비인가된 파일확장자 오류: " + fileType);
						rtnValue.setMessage("비인가된 파일확장자 오류:"+fileType);
					}

				} catch (IllegalStateException e) {

					LogUtil.error(e);
					rtnValue.setMessage("IllegalStateException 오류");
				} catch (IOException e) {

					LogUtil.error(e);
					rtnValue.setMessage("IOException 오류");
				}
			}

			return rtnValue;
	}

	 /*
	  * 1. 메소드명: clearMaskClubMbr
	  * 2. 클래스명: LoyClubMasterService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클럽 회원 마스킹 해제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public LoyMbrListPopResDto clearMaskClubMbr(LoyClubListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		loggingHelper.insertCustReleaLog(reqDto, "loy_club_mbr"); // 이력 저장
		LoyMbrListPopResDto loyClubMbrListResDto = loyClubMasterMapper.clearMaskClubMbr(reqDto);
		return new AnnotationHelper<LoyMbrListPopResDto>(AnnotationType.PersonalData, loyClubMbrListResDto).getItem();
	}
	
	 /*
	  * 1. 메소드명: apprClubMbr
	  * 2. 클래스명: LoyClubMasterService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클럽 회원 - 승인(상태 STAT_CD : A)
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto apprClubMbr(LoyClubListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		loyClubMasterMapper.apprClubMbr(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: saveResnRgst
	  * 2. 클래스명: LoyClubMasterService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클럽 회원 (반려, 탈뢰)사유 등록
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto saveResnRgst(LoyClubListReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		loyClubMasterMapper.saveResnRgst(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getClubMbrListCheck
	  * 2. 클래스명: LoyClubMasterService
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 2.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클러 회원 신청 여부 체크
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	public StatusResDto getClubMbrValidCheck(LoyClubMbrDetailReqDto reqDto) {
		StatusResDto rtnValue = new StatusResDto();
		int num = loyClubMasterMapper.selectClubMbrValidCheck(reqDto);	
		if(num>0) {
			rtnValue.setSuccess(false);
			rtnValue.setMessage("이미 가입한 회원 입니다.");
		}else {
			rtnValue.setSuccess(true);
		}
		return rtnValue;
	}

}
