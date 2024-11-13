package com.icignal.loyalty.channel.service;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

import com.icignal.loyalty.channel.dto.response.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.icignal.auth.dto.response.LoginResDto;
import com.icignal.common.base.dto.response.GridPagingResDto;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.helper.GridPagingResHelper;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.ObjectUtil;
import com.icignal.core.annotation.handler.AnnotationHelper;
import com.icignal.core.annotation.handler.AnnotationHelper.AnnotationType;
import com.icignal.loyalty.channel.dto.request.LoyChnlAddInfoDetailResDto;
import com.icignal.loyalty.channel.dto.request.LoyChnlAddInfoReqDto;
import com.icignal.loyalty.channel.dto.request.LoyChnlChangeHistListReqDto;
import com.icignal.loyalty.channel.dto.request.LoyChnlDetailReqDto;
import com.icignal.loyalty.channel.dto.request.LoyChnlInsertChangeHistReqDto;
import com.icignal.loyalty.channel.dto.request.LoyChnlListReqDto;
import com.icignal.loyalty.channel.dto.request.LoyChnlLoyProgramReqDto;
import com.icignal.loyalty.channel.dto.request.LoyChnlMasterReqDto;
import com.icignal.loyalty.channel.dto.request.LoyChnlMbrRelListReqDto;
import com.icignal.loyalty.channel.dto.request.LoyChnlNewDetailReqDto;
import com.icignal.loyalty.channel.dto.request.LoyChnlPointChangeHistListReqDto;
import com.icignal.loyalty.channel.dto.request.LoyChnlReqDto;
import com.icignal.loyalty.channel.dto.request.LoyChnlSearchHelpListReqDto;
import com.icignal.loyalty.channel.dto.request.LoyChnlSettleMasterReqDto;
import com.icignal.loyalty.channel.dto.request.LoyChnlSettleReqDto;
import com.icignal.loyalty.channel.dto.request.LoyChnlSubTxnHistListReqDto;
import com.icignal.loyalty.channel.dto.request.LoyChnlTxnHistListReqDto;
import com.icignal.loyalty.channel.dto.request.LoyProgramListReqDto;
import com.icignal.loyalty.channel.mapper.LoyChannelMapper;
import com.icignal.loyalty.membership.service.LoyMbrService;

/*
 * 1. 클래스명	: LoyChannelService
 * 2. 파일명	: LoyChannelService.java
 * 3. 패키지명	: com.icignal.loyalty.channel.service
 * 4. 작성자명	: hr.noh
 * 5. 작성일자	: 2020. 2. 19.
 */
/**
 * <PRE>
 * 1. 설명
 *		기준정보 - 채널 Service
 * </PRE>
 */
@Service
public class LoyChannelService {

	@Autowired
	LoyChannelMapper loyChannelMapper;

	@Autowired
	LoyMbrService loyMbrService;

	/*
	 * 1. 메소드명: getChannelSearchHelp 
	 * 2. 클래스명: LoyChannelService 
	 * 3. 작성자명: 이성원 
	 * 4. 작성일자: 2017. 10. 17.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param param
	 * @return
	 */
	public GridPagingResDto<LoyChnlSearchHelpListReqDto> getChannelSearchHelp(LoyChnlSearchHelpListReqDto param) {
		LogUtil.param(LoyChannelService.class, param);

		return new GridPagingResHelper<LoyChnlSearchHelpListReqDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()), loyChannelMapper.getChannelSearchHelp(param), AnnotationType.PersonalData);
	}

	/*
	 * 1. 메소드명: getChannelList 
	 * 2. 클래스명: LoyChannelService 
	 * 3. 작성자명: 이성원 
	 * 4. 작성일자: 2017. 10. 17.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param param
	 * @return
	 */
	public GridPagingResDto<LoyChnlListResDto> getChannelList(LoyChnlListReqDto param) {
		LogUtil.param(LoyChannelService.class, param);

		return new GridPagingResHelper<LoyChnlListResDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()), loyChannelMapper.getChannelList(param));
	}

	/*
	 * 1. 메소드명: getChannelDetail 
	 * 2. 클래스명: LoyChannelService
	 * 3. 작성자명: 이성원 
	 * 4. 작성일자: 2017. 10. 17.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param param
	 * @return
	 */
	public LoyChnlDetailResDto getChannelDetail(LoyChnlDetailResDto param) {
		LogUtil.param(LoyChannelService.class, param);

		return loyChannelMapper.getChannelDetail(param);
	}

	/*
	 * 1. 메소드명: getChnlTxnMemList 
	 * 2. 클래스명: LoyChannelService 
	 * 3. 작성자명: 이성원 
	 * 4. 작성일자: 2017. 10. 17.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param param
	 * @return
	 */
	public GridPagingResDto<LoyChnlDetailReqDto> getChnlTxnMemList(LoyChnlDetailReqDto param) {
		LogUtil.param(LoyChannelService.class, param);

		return new GridPagingResHelper<LoyChnlDetailReqDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()), loyChannelMapper.getChnlTxnMemList(param), AnnotationType.CommCode);
	}

	/*
	 * 1. 메소드명: getChnlSubList 
	 * 2. 클래스명: LoyChannelService 
	 * 3. 작성자명: 이성원 
	 * 4. 작성일자: 2017. 10. 17.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param param
	 * @return
	 */
	public GridPagingResDto<LoyChnlDetailReqDto> getChnlSubList(LoyChnlDetailReqDto param) {
		LogUtil.param(LoyChannelService.class, param);

		return new GridPagingResHelper<LoyChnlDetailReqDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()), loyChannelMapper.getChnlSubList(param), AnnotationType.CommCode);
	}

	/*
	 * 1. 메소드명: getChnlAcrlInfoList 
	 * 2. 클래스명: LoyChannelService 
	 * 3. 작성자명: 이성원 
	 * 4. 작성일자: 2017. 10. 17.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param param
	 * @return
	 */
	public GridPagingResDto<LoyChnlDetailReqDto> getChnlAcrlInfoList(LoyChnlDetailReqDto param) {
		LogUtil.param(LoyChannelService.class, param);

		return new GridPagingResHelper<LoyChnlDetailReqDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()), loyChannelMapper.getChnlAcrlInfoList(param));
	}

	/*
	 * 1. 메소드명: getChnlRdmInfoList 
	 * 2. 클래스명: LoyChannelService 
	 * 3. 작성자명: 이성원 
	 * 4. 작성일자: 2020. 10. 17.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param param
	 * @return
	 */
	public GridPagingResDto<LoyChnlDetailReqDto> getChnlRdmInfoList(LoyChnlDetailReqDto param) {
		LogUtil.param(LoyChannelService.class, param);

		return new GridPagingResHelper<LoyChnlDetailReqDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()), loyChannelMapper.getChnlRdmInfoList(param));
	}

	/*
	 * 1. 메소드명: getChnlStlInfoList 
	 * 2. 클래스명: LoyChannelService 
	 * 3. 작성자명: 이성원 
	 * 4. 작성일자: 2017. 10. 17.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param param
	 * @return
	 */
	public GridPagingResDto<LoyChnlDetailReqDto> getChnlStlInfoList(LoyChnlDetailReqDto param) {
		LogUtil.param(LoyChannelService.class, param);

		return new GridPagingResHelper<LoyChnlDetailReqDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()), loyChannelMapper.getChnlStlInfoList(param));
	}

	/*
	 * 1. 메소드명: getChnlAddInfo 
	 * 2. 클래스명: LoyChannelService 
	 * 3. 작성자명: 이성원 
	 * 4. 작성일자: 2017. 10. 17.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param param
	 * @return
	 */
	public LoyChnlAddInfoResDto getChnlAddInfo(LoyChnlDetailReqDto param) {
		LogUtil.param(LoyChannelService.class, param);

		return loyChannelMapper.getChnlAddInfo(param);
	}

	/*
	 * 1. 메소드명: editChnlAddInfo 
	 * 2. 클래스명: LoyChannelService 
	 * 3. 작성자명: 이성원 
	 * 4. 작성일자: 2017. 10. 27.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param param
	 * @return
	 */
	public StatusResDto editChnlAddInfo(LoyChnlAddInfoReqDto param) {
		LogUtil.param(LoyChannelService.class, param);
		StatusResDto reqDto = new StatusResDto();
		loyChannelMapper.editChnlAddInfo(param);
		reqDto.setSuccess(true);
		return reqDto;
	}

	/*
	 * 1. 메소드명: changeChannelValueHist 
	 * 2. 클래스명: LoyChannelService 
	 * 3. 작성자명: 이성원 
	 * 4. 작성일자: 2017. 10. 31.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param srcDTO
	 * @param tgtDTO
	 * @param rid
	 * @param userRid
	 * @param loginInfo
	 */
	public void changeChannelValueHist(Object srcDTO, Object tgtDTO, String rid, String userRid,
			LoginResDto loginInfo) {
		Class srcClass = srcDTO.getClass();
		Class tgtClass = tgtDTO.getClass();

		boolean changed;
		Method srcMethods[] = srcClass.getMethods();
		Method tgtMethods[] = tgtClass.getMethods();

		for (int i = 0; i < srcMethods.length; i++) {
			Method srcMethod = srcMethods[i];
			String srcMethodName = srcMethod.getName();
			for (int j = 0; j < tgtMethods.length; j++) {
				Method tgtMethod = tgtMethods[j];
				String tgtMethodName = tgtMethod.getName();
				if (srcMethodName.equals(tgtMethodName)) {
					if (srcMethodName.equals("getClass")) {
						continue;
					}
					Object[] args = null;
					Class[] paras = new Class[1];
					Object[] args2 = new Object[1];
					LoyChnlInsertChangeHistReqDto histReq = new LoyChnlInsertChangeHistReqDto();
					histReq.setRidParent(rid);
					histReq.setLoginInfo(loginInfo);
					histReq.setCreateBy(userRid);
					histReq.setModifyBy(userRid);

					if (srcMethodName.length() >= 3 && srcMethodName.substring(0, 3).equals("get")) {
						try {

							Object returnSrcObj = srcMethod.invoke(srcDTO, args);
							Object returnTgtObj = tgtMethod.invoke(tgtDTO, args);
							Class returnType = srcMethod.getReturnType();
							String field = srcMethodName.substring(3, srcMethodName.length());

							if (ObjectUtil.isEmpty(returnSrcObj) && ObjectUtil.isNotEmpty(returnTgtObj) && !returnTgtObj.toString().equals("")) {
								// 다른값
								histReq.setChgItem(tableColName(field));
								histReq.setBchngVal(null);
								histReq.setAchngVal(returnTgtObj.toString());
								loyChannelMapper.insertChnlChangeHist(histReq);
								changed = true;

							} else if (ObjectUtil.isNotEmpty(returnSrcObj) && !returnSrcObj.toString().equals("") && (ObjectUtil.isEmpty(returnTgtObj) || returnTgtObj.toString().equals(""))) {
								// 다른값
								histReq.setChgItem(tableColName(field));
								histReq.setBchngVal(returnSrcObj.toString());
								histReq.setAchngVal(null);
								loyChannelMapper.insertChnlChangeHist(histReq);
							} else if (ObjectUtil.isNotEmpty(returnSrcObj != null) && ObjectUtil.isNotEmpty(returnTgtObj) && !returnSrcObj.equals(returnTgtObj)) {
								// 둘다 널이 아닐때
								histReq.setChgItem(tableColName(field));
								histReq.setBchngVal(returnSrcObj.toString());
								histReq.setAchngVal(returnTgtObj.toString());
								StatusResDto rtnValue = new StatusResDto();
								loyChannelMapper.insertChnlChangeHist(histReq);
								rtnValue.setSuccess(true);
								changed = true;
							}
						} catch (IllegalAccessException e) {
							e.printStackTrace();
						} catch (IllegalArgumentException e) {
							e.printStackTrace();
						} catch (InvocationTargetException e) {
							e.printStackTrace();
						}
					}

					break;
				}
			}
		}

	}

	/*
	 * 1. 메소드명: tableColName 
	 * 2. 클래스명: LoyChannelService 
	 * 3. 작성자명: 이성원 
	 * 4. 작성일자: 2017. 10. 31.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param colNm
	 * @return
	 */
	public String tableColName(String colNm) {

		String replaceString = colNm.replaceAll("([A-Z]+)", "\\_$1").toLowerCase();
		replaceString = replaceString.substring(1, replaceString.length());

		return replaceString.toUpperCase();

	}

	/*
	 * 1. 메소드명: changeChannelPointValueHist 
	 * 2. 클래스명: LoyChannelService 
	 * 3. 작성자명: 
	 * 4. 작성일자: 2020. 2. 19.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param oldData
	 * @param newData
	 * @param rid
	 * @param userRid
	 * @param loginInfo
	 */
	public void changeChannelPointValueHist(LoyChnlAddInfoResDto oldData, LoyChnlAddInfoResDto newData, String rid,
			String userRid, LoginResDto loginInfo) {

		if (ObjectUtil.isEmpty(oldData.getRidAcrlRule()) && ObjectUtil.isNotEmpty(newData.getRidAcrlRule())) {

		} else if (ObjectUtil.isEmpty(oldData.getRidAdjRule()) && ObjectUtil.isNotEmpty(newData.getRidAdjRule())) {

		}
		
		if (ObjectUtil.isNotEmpty(oldData.getRidAcrlRule()) && ObjectUtil.isEmpty(newData.getRidAcrlRule())) {

		} else if (ObjectUtil.isNotEmpty(oldData.getRidAdjRule()) && ObjectUtil.isEmpty(newData.getRidAdjRule())) {

		} else if (!oldData.getRidAcrlRule().equals(newData.getRidAcrlRule())) {

		} else if (!oldData.getRidAdjRule().equals(newData.getRidAdjRule())) {

		} else {
			// 변경 사항 없음
			return;
		}

		// 이전 변경이력 업데이트
		loyChannelMapper.updateChnlChangePointHist(newData);

		// 변경이력 생성
		loyChannelMapper.insertChnlChangePointHist(newData);

		return;

	}

	/*
	 * 1. 메소드명: getChnlChangeHistList 
	 * 2. 클래스명: LoyChannelService 
	 * 3. 작성자명: 이성원 
	 * 4. 작성일자: 2017. 10. 31.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param param
	 * @return
	 */
	public GridPagingResDto<LoyChnlChangeHistListReqDto> getChnlChangeHistList(LoyChnlChangeHistListReqDto param) {
		LogUtil.param(LoyChannelService.class, param);

		return new GridPagingResHelper<LoyChnlChangeHistListReqDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()), loyChannelMapper.getChnlChangeHistList(param), AnnotationType.CommCode);
	}

	/*
	 * 1. 메소드명: getChnlPointChangeHistList 
	 * 2. 클래스명: LoyChannelService 
	 * 3. 작성자명: 
	 * 4. 작성일자: 2020. 2. 19.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param param
	 * @return
	 */
	public GridPagingResDto<LoyChnlPointChangeHistListReqDto> getChnlPointChangeHistList(
			LoyChnlPointChangeHistListReqDto param) {
		LogUtil.param(LoyChannelService.class, param);

		return new GridPagingResHelper<LoyChnlPointChangeHistListReqDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()), loyChannelMapper.getChnlPointChangeHistList(param));
	}

	/*
	 * 1. 메소드명: getChnlTxnHistList 
	 * 2. 클래스명: LoyChannelService 
	 * 3. 작성자명: 이성원 
	 * 4. 작성일자: 2017. 10. 31.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param param
	 * @return
	 */
	public GridPagingResDto<LoyChnlTxnHistListReqDto> getChnlTxnHistList(LoyChnlTxnHistListReqDto param) {
		LogUtil.param(LoyChannelService.class, param);

		param.setSVCAlias("a");

		Integer cnt = loyChannelMapper.getChnlSubTxnHistListCnt(param);

		if (cnt > 0) {
			return new GridPagingResHelper<LoyChnlTxnHistListReqDto>().newGridPagingResDto(
					param.init(CommonUtil.getInstance().getDBType()), loyChannelMapper.getChnlTxnHistList(param), AnnotationType.ALL);
		}

		return null;
	}

	/*
	 * 1. 메소드명: getChnlSubTxnHistList 
	 * 2. 클래스명: LoyChannelService 
	 * 3. 작성자명: 이성원 
	 * 4. 작성일자: 2017. 11. 2.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param param
	 * @return
	 */
	public GridPagingResDto<LoyChnlSubTxnHistListReqDto> getChnlSubTxnHistList(LoyChnlSubTxnHistListReqDto param) {
		LogUtil.param(LoyChannelService.class, param);

		return new GridPagingResHelper<LoyChnlSubTxnHistListReqDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()), loyChannelMapper.getChnlSubTxnHistList(param), AnnotationType.ALL);

	}

	/*
	 * 1. 메소드명: saveChannelDetail 
	 * 2. 클래스명: LoyChannelService 
	 * 3. 작성자명: hy.jun 
	 * 4. 작성일자: 2018. 10. 8.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param param
	 * @return
	 */
	public StatusResDto saveChannelDetail(LoyChnlMasterReqDto param) {
		LogUtil.param(LoyChannelService.class, param);
		StatusResDto rtnValue = new StatusResDto();
		String rid = CommonUtil.newRid();
		param.setRid(rid);
		if (ObjectUtil.isEmpty(param.getChnlRealNm())) {
			param.setChnlRealNm(param.getChnlNm());
		}
		param.setChnlOpenTime(param.getChnlOpenTime().replaceAll(":", ""));
		param.setChnlCloseTime(param.getChnlCloseTime().replaceAll(":", ""));
		
		loyChannelMapper.saveChannelDetail(param);
        rtnValue.setSuccess(true);
        rtnValue.setMessage(param.getRid());
        
		 return rtnValue;
	}

	/*
	 * 1. 메소드명: editChannelDetail 
	 * 2. 클래스명: LoyChannelService 
	 * 3. 작성자명: hy.jun 
	 * 4. 작성일자: 2018. 10. 8.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param param
	 * @return
	 */
	public StatusResDto editChannelDetail(LoyChnlMasterReqDto param) {
		LogUtil.param(LoyChannelService.class, param);
		if (ObjectUtil.isEmpty(param.getChnlRealNm())) {
			param.setChnlRealNm(param.getChnlNm());
		}

		param.setChnlOpenTime(param.getChnlOpenTime().replaceAll(":", ""));
		param.setChnlCloseTime(param.getChnlCloseTime().replaceAll(":", ""));
		
		StatusResDto rtnValue = new StatusResDto();
		loyChannelMapper.editChannelDetail(param);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/*
	 * 1. 메소드명: removeChannel 
	 * 2. 클래스명: LoyChannelService 
	 * 3. 작성자명: hy.jun 
	 * 4. 작성일자: 2018. 10. 8.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param param
	 * @return
	 */
	public StatusResDto removeChannel(LoyChnlMasterReqDto param) {
		LogUtil.param(LoyChannelService.class, param);
		StatusResDto rtnValue = new StatusResDto();
		loyChannelMapper.removeChannel(param);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/*
	 * 1. 메소드명: getChannelDefaultInfo 
	 * 2. 클래스명: LoyChannelService 
	 * 3. 작성자명: hy.jun 
	 * 4. 작성일자: 2018. 10. 10.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param param
	 * @return
	 */
	public LoyChnlDefaultInfoResDto getChannelDefaultInfo(LoyChnlMasterReqDto param) {
		LogUtil.param(LoyChannelService.class, param);
		LoyChnlDefaultInfoResDto rtnValue = new LoyChnlDefaultInfoResDto();
		rtnValue = loyChannelMapper.getChannelDefaultInfo(param);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	/*
	 * 1. 메소드명: setChnlMbr 
	 * 2. 클래스명: LoyChannelService 
	 * 3. 작성자명: seony.lee 
	 * 4. 작성일자: 2019. 9. 6.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		채널에 관련회원 추가
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param reqDTO
	 * @return
	 */
	public StatusResDto setChnlMbr(LoyChnlMasterReqDto reqDTO) {

		LoyChnlDefaultInfoResDto chnlInfo = loyChannelMapper.getChannelDefaultInfo(reqDTO);
		reqDTO.setChnlTypeSubCd(chnlInfo.getChnlTypeSubCd());

		Integer mbrChk = loyChannelMapper.setChnlMbr(reqDTO);
		if (mbrChk == 0) {
			loyChannelMapper.insertChnlMbr(reqDTO);
		} else {
			LogUtil.debug("이미 존재하는 회원입니다.");
		}

		return null;

	}

	/*
	 * 1. 메소드명: removeChnlMbr 
	 * 2. 클래스명: LoyChannelService 
	 * 3. 작성자명: seony.lee 
	 * 4. 작성일자: 2019. 10. 10.
	 */
	/**
	 * <PRE>
	 * 1. 설명
	 *		채널에 관련회원 삭제
	 * 2. 사용법
	 * 
	 * </PRE>
	 * 
	 * @param reqDto
	 * @return
	 */
	public StatusResDto removeChnlMbr(LoyChnlMasterReqDto reqDto) {
		StatusResDto rtnValue = new StatusResDto();
		loyChannelMapper.removeChnlMbr(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getStoreCd
	  * 2. 클래스명: LoyChannelService
	  * 3. 작성자명: seony.lee
	  * 4. 작성일자: 2019. 9. 6.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDTO
	 *   @return	
	 */
	public StatusResDto getStoreCd(LoyChnlMasterReqDto reqDTO) {
		StatusResDto rtnValue = new StatusResDto();
    	rtnValue.setSuccess(false);
    	
		//스토어 코드값 구하기
		LoyChnlDefaultInfoResDto storeCd = loyChannelMapper.selectStoreCd(reqDTO);
		reqDTO.setStoreCd(storeCd.getStoreCd());
		
		//스토어 코드값 채널상세에 값 추가하기
		loyChannelMapper.insertStroeCd(reqDTO);
		
		//스토어코드 사용처리
		loyChannelMapper.updateStoreCd(reqDTO);
		
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getChnlListPage
	  * 2. 클래스명: LoyChannelService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 15.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	
	public GridPagingResDto<LoyChannelListPageResDto> getChnlListPage(LoyChnlSubTxnHistListReqDto param) {
		LogUtil.param(LoyChannelService.class, param);

		return new GridPagingResHelper<LoyChannelListPageResDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()),
				loyChannelMapper.selectChnlListPage(param), AnnotationType.CommCode);
	}

	 /*
	  * 1. 메소드명: saveChnlDetail
	  * 2. 클래스명: LoyChannelService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 18.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	
	public StatusResDto saveChnlDetail(LoyChnlNewDetailReqDto param) {
		LogUtil.param(LoyChannelService.class, param);
		StatusResDto reqDto = new StatusResDto();
		param.setRid(CommonUtil.newRid());
		loyChannelMapper.insertChnlDetail(param);
		LoyChnlLoyProgramReqDto paramPgm = new LoyChnlLoyProgramReqDto();
		paramPgm.setRid(CommonUtil.newRid());
		paramPgm.setCreateBy(param.getCreateBy());
		paramPgm.setModifyBy(param.getModifyBy());
		paramPgm.setChnlRid(param.getRid());
		LoyProgramListResDto pgmData = loyChannelMapper.selectLoyPgmTopDesc();
		paramPgm.setPgmRid(pgmData.getRid());
		paramPgm.setPntAcrlYn("Y");
		paramPgm.setPntRdmYn("Y");
		paramPgm.setEvtYn("Y");
		paramPgm.setUseYn("Y");
		loyChannelMapper.insertChnlLoyPgm(paramPgm);
		loyChannelMapper.insertChnlLoyPgmHist(paramPgm);
		reqDto.setSuccess(true);
		reqDto.setMessage(param.getRid());
		return reqDto;
	}

	 /*
	  * 1. 메소드명: getParentChnlTList
	  * 2. 클래스명: LoyChannelService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 18.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	
	public GridPagingResDto<LoyChannelListPageResDto> getParentChnlTList(LoyChnlReqDto param) {
		LogUtil.param(LoyChannelService.class, param);

		return new GridPagingResHelper<LoyChannelListPageResDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()),
				loyChannelMapper.selectParentChnlTList(param), AnnotationType.CommCode);
	}

	 /*
	  * 1. 메소드명: getChnlDetailNew
	  * 2. 클래스명: LoyChannelService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 18.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	
	public LoyChnlDetailNewResDto getChnlDetailNew(LoyChnlNewDetailReqDto param) {
		LogUtil.param(this.getClass(), param);
		
		LoyChnlDetailNewResDto res = loyChannelMapper.selectChnlDetailNew(param);
		return new AnnotationHelper<LoyChnlDetailNewResDto>(AnnotationType.CommCode, res).getItem();
	}

	 /*
	  * 1. 메소드명: modifyChnlDetail
	  * 2. 클래스명: LoyChannelService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 18.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	
	public StatusResDto modifyChnlDetail(LoyChnlNewDetailReqDto param) {
		LogUtil.param(LoyChannelService.class, param);
		StatusResDto reqDto = new StatusResDto();
		loyChannelMapper.updateChnlDetail(param);
		reqDto.setSuccess(true);
		return reqDto;
	}

	 /*
	  * 1. 메소드명: getChnlAddInfoDetailNew
	  * 2. 클래스명: LoyChannelService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	
	public LoyChnlAddInfoDetailNewResDto getChnlAddInfoDetailNew(LoyChnlNewDetailReqDto param) {
		LogUtil.param(this.getClass(), param);
		
		LoyChnlAddInfoDetailNewResDto res = loyChannelMapper.selectChnlAddInfoDetailNew(param);
		return new AnnotationHelper<LoyChnlAddInfoDetailNewResDto>(AnnotationType.Nothing, res).getItem();
	}

	 /*
	  * 1. 메소드명: saveChnlAddInfoDetail
	  * 2. 클래스명: LoyChannelService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	
	public StatusResDto saveChnlAddInfoDetail(LoyChnlAddInfoDetailResDto param) {
		LogUtil.param(LoyChannelService.class, param);
		StatusResDto reqDto = new StatusResDto();
		param.setRid(CommonUtil.newRid());
		loyChannelMapper.insertChnlAddInfoDetail(param);
		reqDto.setSuccess(true);
		return reqDto;
	}

	 /*
	  * 1. 메소드명: modifyChnlAddInfoDetail
	  * 2. 클래스명: LoyChannelService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	
	public StatusResDto modifyChnlAddInfoDetail(LoyChnlAddInfoDetailResDto param) {
		LogUtil.param(LoyChannelService.class, param);
		StatusResDto reqDto = new StatusResDto();
		loyChannelMapper.updateChnlAddInfoDetail(param);
		reqDto.setSuccess(true);
		return reqDto;
	}

	 /*
	  * 1. 메소드명: getChnlLoyPgmList
	  * 2. 클래스명: LoyChannelService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	
	public GridPagingResDto<LoyChnlLoyPgmListResDto> getChnlLoyPgmList(LoyChnlReqDto param) {
		LogUtil.param(LoyChannelService.class, param);

		return new GridPagingResHelper<LoyChnlLoyPgmListResDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()),
				loyChannelMapper.selectChnlLoyPgmList(param), AnnotationType.CommCode);
	}

	 /*
	  * 1. 메소드명: getLoyPgmListNew
	  * 2. 클래스명: LoyChannelService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 20.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	
	public GridPagingResDto<LoyProgramListResDto> getLoyPgmListNew(LoyProgramListReqDto param) {
		LogUtil.param(LoyChannelService.class, param);

		return new GridPagingResHelper<LoyProgramListResDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()),
				loyChannelMapper.selectLoyPgmListNew(param), AnnotationType.CommCode);
	}

	 /*
	  * 1. 메소드명: saveChnlLoyPgm
	  * 2. 클래스명: LoyChannelService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 20.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	@Transactional
	public StatusResDto saveChnlLoyPgm(LoyChnlLoyProgramReqDto param) {
		LogUtil.param(LoyChannelService.class, param);
		StatusResDto reqDto = new StatusResDto();
		param.setRid(CommonUtil.newRid());
		loyChannelMapper.insertChnlLoyPgm(param);
		loyChannelMapper.insertChnlLoyPgmHist(param);
		reqDto.setSuccess(true);
		return reqDto;
	}

	 /*
	  * 1. 메소드명: modifyChnlLoyPgm
	  * 2. 클래스명: LoyChannelService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 20.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	@Transactional
	public StatusResDto modifyChnlLoyPgm(LoyChnlLoyProgramReqDto param) {
		LogUtil.param(LoyChannelService.class, param);
		StatusResDto reqDto = new StatusResDto();
		loyChannelMapper.updateChnlLoyPgm(param);
		param.setRid(CommonUtil.newRid());
		loyChannelMapper.insertChnlLoyPgmHist(param);
		reqDto.setSuccess(true);
		return reqDto;
	}

	 /*
	  * 1. 메소드명: getLoyPgmDetailNew
	  * 2. 클래스명: LoyChannelService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 20.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	
	public LoyChnlPgmDetailResDto getLoyPgmDetailNew(LoyChnlLoyProgramReqDto param) {
		LogUtil.param(this.getClass(), param);
		
		LoyChnlPgmDetailResDto res = loyChannelMapper.selectLoyPgmDetailNew(param);
		return new AnnotationHelper<LoyChnlPgmDetailResDto>(AnnotationType.Nothing, res).getItem();
	}

	 /*
	  * 1. 메소드명: getChnlMbrRelList
	  * 2. 클래스명: LoyChannelService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 21.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	
	public GridPagingResDto<LoyChnlMbrRelResDto> getChnlMbrRelList(LoyChnlMbrRelListReqDto param) {
		LogUtil.param(LoyChannelService.class, param);

		return new GridPagingResHelper<LoyChnlMbrRelResDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()),
				loyChannelMapper.selectChnlMbrRelList(param), AnnotationType.ALL);
	}

	 /*
	  * 1. 메소드명: getChnlSettleList
	  * 2. 클래스명: LoyChannelService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 21.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	
	public GridPagingResDto<LoyChnlSettleListResDto> getChnlSettleList(LoyChnlSettleMasterReqDto param) {
		LogUtil.param(LoyChannelService.class, param);

		return new GridPagingResHelper<LoyChnlSettleListResDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()),
				loyChannelMapper.selectChnlSettleList(param), AnnotationType.CommCode);
	}

	 /*
	  * 1. 메소드명: getChnlLoyPgmListNew
	  * 2. 클래스명: LoyChannelService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 25.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	
	public GridPagingResDto<LoyChnlLoyPgmListResDto> getChnlLoyPgmListNew(LoyProgramListReqDto param) {
		LogUtil.param(LoyChannelService.class, param);

		return new GridPagingResHelper<LoyChnlLoyPgmListResDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()),
				loyChannelMapper.selectChnlLoyPgmListNew(param), AnnotationType.Nothing);
	}

	 /*
	  * 1. 메소드명: saveChnlSettle
	  * 2. 클래스명: LoyChannelService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 25.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	@Transactional 
	public StatusResDto saveChnlSettle(LoyChnlSettleReqDto param) {
		LogUtil.param(LoyChannelService.class, param);
		StatusResDto reqDto = new StatusResDto();
		param.setRid(CommonUtil.newRid());
		loyChannelMapper.insertChnlSettle(param);
		loyChannelMapper.insertChnlSettleHist(param);
		reqDto.setSuccess(true);
		return reqDto;
	}

	 /*
	  * 1. 메소드명: modifyChnlSettle
	  * 2. 클래스명: LoyChannelService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 25.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	@Transactional 
	public StatusResDto modifyChnlSettle(LoyChnlSettleReqDto param) {
		LogUtil.param(LoyChannelService.class, param);
		StatusResDto reqDto = new StatusResDto();
		loyChannelMapper.updateChnlSettle(param);
		param.setRid(CommonUtil.newRid());
		loyChannelMapper.insertChnlSettleHist(param);
		reqDto.setSuccess(true);
		return reqDto;
	}

	 /*
	  * 1. 메소드명: getLoyChnlPgmDetailNew
	  * 2. 클래스명: LoyChannelService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 25.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	
	public LoyChnlSettleResDto getLoyChnlPgmDetailNew(LoyChnlLoyProgramReqDto param) {
		LogUtil.param(this.getClass(), param);
		
		LoyChnlSettleResDto res = loyChannelMapper.selectLoyChnlPgmDetailNew(param);
		return new AnnotationHelper<LoyChnlSettleResDto>(AnnotationType.CommCode, res).getItem();
	}

	 /*
	  * 1. 메소드명: getChnlLoyPgmHist
	  * 2. 클래스명: LoyChannelService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 25.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	
	public GridPagingResDto<LoyChnlLoyPgmListResDto> getChnlLoyPgmHist(LoyProgramListReqDto param) {
		LogUtil.param(LoyChannelService.class, param);

		return new GridPagingResHelper<LoyChnlLoyPgmListResDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()),
				loyChannelMapper.selectChnlLoyPgmHist(param), AnnotationType.Nothing);
	}

	 /*
	  * 1. 메소드명: getChnlSettleHist
	  * 2. 클래스명: LoyChannelService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 25.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	
	public GridPagingResDto<LoyChnlSettleListResDto> getChnlSettleHist(LoyChnlSettleMasterReqDto param) {
		LogUtil.param(LoyChannelService.class, param);

		return new GridPagingResHelper<LoyChnlSettleListResDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()),
				loyChannelMapper.selectChnlSettleHist(param), AnnotationType.CommCode);
	}

	 /*
	  * 1. 메소드명: removeChnlChannel
	  * 2. 클래스명: LoyChannelService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	
	public StatusResDto removeChnlChannel(LoyChnlReqDto param) {
		LogUtil.param(LoyChannelService.class, param);
		StatusResDto rtnValue = new StatusResDto();
		loyChannelMapper.deleteChnlChannel(param);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: removeChnlLoyPgm
	  * 2. 클래스명: LoyChannelService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	
	public StatusResDto removeChnlLoyPgm(LoyChnlReqDto param) {
		LogUtil.param(LoyChannelService.class, param);
		StatusResDto rtnValue = new StatusResDto();
		loyChannelMapper.deleteChnlLoyPgm(param);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	 /*
	  * 1. 메소드명: removeChnlSettle
	  * 2. 클래스명: LoyChannelService
	  * 3. 작성자명: 서정환 
	  * 4. 작성일자: 2020. 5. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param param
	 *   @return	
	 */
	
	public StatusResDto removeChnlSettle(LoyChnlReqDto param) {
		LogUtil.param(LoyChannelService.class, param);
		StatusResDto rtnValue = new StatusResDto();
		loyChannelMapper.deleteChnlSettle(param);
		rtnValue.setSuccess(true);
		return rtnValue;
	}


	public GridPagingResDto<LoyChnlLoyPgmListResDto> getChnlLoyImgInfoList(LoyChnlReqDto param) {
		LogUtil.param(LoyChannelService.class, param);

		return new GridPagingResHelper<LoyChnlLoyPgmListResDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()),
				loyChannelMapper.selectChnlLoyImgInfoList(param), AnnotationType.CommCode);
	}

	public GridPagingResDto<LoyChnlLoyPgmListResDto> getLoyImgDesc(LoyChnlReqDto param) {
		LogUtil.param(LoyChannelService.class, param);

		return new GridPagingResHelper<LoyChnlLoyPgmListResDto>().newGridPagingResDto(
				param.init(CommonUtil.getInstance().getDBType()),
				loyChannelMapper.selectLoyImgDesc(param), AnnotationType.CommCode);
	}

	public StatusResDto getLoyImgDel(LoyChnlReqDto param) {
		LogUtil.param(LoyChannelService.class, param);
		StatusResDto rtnValue = new StatusResDto();
		loyChannelMapper.deleteChnlImg(param);
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	public StatusResDto addChnlImgInfo(LoyChnlReqDto param) {
		LogUtil.param(LoyChannelService.class, param);
		StatusResDto rtnValue = new StatusResDto();
		param.setRid(CommonUtil.newRid());
		//Integer seq =loyChannelMapper.selectChnlImgSeq(param);
		//seq++;
		//String seqno = Integer.toString(seq);
		Integer isSeqNo =loyChannelMapper.selectChnlImgIsSeqNo(param);
		
		if(isSeqNo>=1) {
			rtnValue.setSuccess(true);
			rtnValue.setMessage("dupSeqNo"); //순번 중복
			return rtnValue;
		}
		
		loyChannelMapper.insertChnlImgInfo(param);
		rtnValue.setSuccess(true);
		rtnValue.setMessage("저장되었습니다.");
		return rtnValue;
	}

	public StatusResDto saveImgDetail(LoyChnlReqDto param) {
		LogUtil.param(LoyChannelService.class, param);
		StatusResDto rtnValue = new StatusResDto();
		rtnValue.setSuccess(false);
		String seqNo = loyChannelMapper.selectChnlImgSeqNo(param);
		Integer isSeqNo =loyChannelMapper.selectChnlImgIsSeqNo(param);


		if(param.getSeqNo().equals(seqNo)) {
			loyChannelMapper.updateImgDetail(param);
			rtnValue.setSuccess(true);
			rtnValue.setMessage("저장 되었습니다.");
			return rtnValue;
		}
		
		if(isSeqNo>=1) {
			rtnValue.setSuccess(true);
			rtnValue.setMessage("dupSeqNo");
			return rtnValue;
		}
		
		loyChannelMapper.updateImgDetail(param);
		rtnValue.setMessage("저장 되었습니다.");
		rtnValue.setSuccess(true);
		return rtnValue;
	}

	public GridPagingResDto<LoyChnlExcelDnDto> getChnlListExcelDown(LoyChnlReqDto reqDto) {
		LogUtil.param(LoyChannelService.class, reqDto);

		return new GridPagingResHelper<LoyChnlExcelDnDto>().newGridPagingResDto(
				reqDto.init(CommonUtil.getInstance().getDBType()),
				loyChannelMapper.selectChnlListExcelDown());
	}

	public StatusResDto updateChnlList(LoyChnlReqDto reqDto) {
		StatusResDto rtnValue = new StatusResDto();
		loyChannelMapper.updateChnlList(reqDto);
		rtnValue.setSuccess(true);
		return rtnValue;
	}
}
