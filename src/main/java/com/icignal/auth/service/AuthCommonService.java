package com.icignal.auth.service;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import com.icignal.auth.exception.LoginWrongUserInfoException;
import com.icignal.common.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icignal.auth.dto.request.AuthorityReqDto;
import com.icignal.auth.dto.response.AuthorityDataListResDto;
import com.icignal.auth.dto.response.AuthorityGroupListResDto;
import com.icignal.auth.dto.response.AuthorityResDto;
import com.icignal.auth.mapper.AuthMapper;
import com.icignal.common.cache.dto.response.ProgramCache;
import com.icignal.common.cache.dto.response.ProgramChildResDto;
import com.icignal.common.cache.dto.response.ProgramObject;
import com.icignal.common.cache.service.CacheManagerService;
import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.CommonUtil.AUTH_DATA_TYPE;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.ObjectUtil;


@Service
public class AuthCommonService {

    @Autowired
    AuthMapper authMapper;

    @Autowired
    CacheManagerService cacheManagerService;

    /**
     * <pre>
     * infavor.Acon.enterprise.auth.service.impl.AuthCommonService.java
     *  |_ getAuthority()
     * </pre>
     * Method		: getAuthority
     * Method설명	: 권한 조회
     *
     * @param AuthorityReqDto
     * @return AuthorityResDto
     * @history =================================================================================
     * 변경일				작성자			변경내용
     * =================================================================================
     * 2017. 3. 13.			dg.ryu			신규 생성
     * =================================================================================
     * @SeeToOverriden        : @see infavor.Acon.enterprise.auth.service.IAuthCommonService#getAuthority(infavor.Acon.enterprise.auth.dto.request.AuthorityReqDto)
     */

    public AuthorityResDto getAuthority(AuthorityReqDto ar) {
        LogUtil.param(this.getClass(), ar);

        ar.setSVCAlias("t1");

        //메뉴 조회시 기기별 조건절 추가
        if (StringUtil.isNotEmpty(ar.getDeviceInfo())) {
            String deviceInto = ar.getDeviceInfo();
            if (deviceInto.equals("mobile") || deviceInto.equals("tablet")) {
                ar.setDeviceInfo("Y");
            } else {
                ar.setDeviceInfo("N");
            }
        }

        AuthorityResDto rtnValue = new AuthorityResDto();

        //기본값 설정
        rtnValue.setDefaultValue(ar);

        //권한그룹 목록 조회
        rtnValue.setAuthGroupList(authMapper.selectAuthGroupList(ar));

        for (AuthorityGroupListResDto authGroup : rtnValue.getAuthGroupList()) {
            AuthorityReqDto req = new AuthorityReqDto();
            req.setLang(ar.getLang());
            req.setEmpId(ar.getEmpId());
            req.setRidUser(ar.getRidUser());
            req.setAuthGroupId(authGroup.getId());
            authGroup.setAuthDataList(authMapper.selectAuthDataList(req));
        }

        //권한 목록 조회
        rtnValue.setAuthList(authMapper.selectAuthList(ar));

        //권한 데이터 목록 조회
        rtnValue.setAuthDataList(authMapper.selectAuthDataList(ar));

        //권한 데이터 IN 값
        rtnValue = getAuthorityDataInValue(rtnValue);

        //권한 메뉴 목록 조회
        rtnValue.setAuthMenuList(authMapper.selectAuthMenuList(ar));

        //권한 프로그램 목록 조회
        //rtnValue.setAuthProgList(authMapper.selectAuthProgramList(ar));

        //권한 오브젝트 목록 조회
        //rtnValue.setAuthObjList(authMapper.selectAuthObjectList(ar));

        return rtnValue;
    }

    /**
     *
     * <pre>
     * infavor.Acon.enterprise.auth.service.impl.AuthCommonService.java
     *  |_ getAuthority()
     * </pre>
     * Method		: getAuthority
     * Method설명	: 권한 조회
     * @param AuthorityReqDto, AuthorityResDto
     * @return AuthorityResDto
     * @history
     * =================================================================================
     * 변경일				작성자			변경내용
     * =================================================================================
     * 2017. 3. 13.			dg.ryu			신규 생성
     *
     * =================================================================================
     *
     * @SeeToOverriden        : @see infavor.Acon.enterprise.auth.service.IAuthCommonService#getAuthority(infavor.Acon.enterprise.auth.dto.request.AuthorityReqDto, infavor.Acon.enterprise.auth.dto.request.AuthorityResDto)
     */
	
	/*public AuthorityResDto getAuthority(AuthorityReqDto ar, AuthorityResDto arRes) {
		LogUtil.param(AuthCommonService.class,  ar);
		
		AuthorityResDto rtnValue = arRes;
		
		//기본값 설정
		rtnValue.setDefaultValue(ar);
		
		//권한 데이터 목록 조회
		rtnValue.setAuthDataList(authMapper.selectAuthDataList(ar));
		
		//권한 데이터 IN 값
		rtnValue = getAuthorityDataInValue(rtnValue);
		
		//권한 메뉴 목록 조회
		rtnValue.setAuthMenuList(authMapper.selectAuthMenuList(ar));
		
		//권한 프로그램 목록 조회
		rtnValue.setAuthProgList(authMapper.selectAuthProgramList(ar));
		
		//권한 오브젝트 목록 조회
		rtnValue.setAuthObjList(authMapper.selectAuthObjectList(ar));
		
		return rtnValue;
	}*/

    /**
     * <pre>
     * infavor.Acon.enterprise.auth.service.impl.AuthCommonService.java
     *  |_ getAuthority()
     * </pre>
     * Method		: setAuthorityDataInValue
     * Method설명	: 권한 데이터 IN 값 설정
     *
     * @param AuthorityResDto, String
     * @return AuthorityResDto
     * @history =================================================================================
     * 변경일				작성자			변경내용
     * =================================================================================
     * 2017. 3. 13.			dg.ryu			신규 생성
     * =================================================================================
     * @SeeToOverriden        : @see infavor.Acon.enterprise.auth.service.IAuthCommonService#setAuthorityDataInValue(infavor.Acon.enterprise.auth.dto.response.AuthorityResDto, String)
     */

    public AuthorityResDto setAuthorityDataInValue(AuthorityResDto ar, String dataTypeCd) {
        LogUtil.param(AuthCommonService.class, ar);
        AuthorityResDto rtnValue = ar;
        //기존 데이터 유형과 동일하지 않을 경우만 재설정
        if (!(ar.getDataTypeCd().equals(dataTypeCd))) {
            ar.setDataTypeCd(dataTypeCd);
            rtnValue = getAuthorityDataInValue(ar);
        }

        return rtnValue;
    }

    /**
     * @name : getAuthorityDataInList
     * @date : 2015. 12. 30.
     * @author : "류동균"
     * @description : 권한 데이터 IN 값
     */
    public AuthorityResDto getAuthorityDataInValue(AuthorityResDto ar) {
        LogUtil.param(AuthCommonService.class, ar);

        String authDataInValue = "";    //IN Value (account List)
        String authDataInQuery = "";    //IN Query

        if (ObjectUtil.isNotEmpty(ar.getAuthDataList())) {

            List<String> baseDeptList = new ArrayList<String>();
            boolean indept = true;
            boolean my = true;
            int idx = 1;

            for (AuthorityDataListResDto authData : ar.getAuthDataList()) {
                String dataTypeCd = authData.getDataTypeCd();

                //데이터유형코드를 받았다면 모든 데이터 유형 파라메터 값으로 설정
                if (ObjectUtil.isNotEmpty(ar.getDataTypeCd())) {
                    dataTypeCd = ar.getDataTypeCd();
                }

                ar.setDataTypeCd(dataTypeCd);

                /**
                 * 전체
                 */
                if (AUTH_DATA_TYPE.ALL.name().equals(dataTypeCd)) {
                    authDataInValue = "select rid from com.crm_division";
                    baseDeptList = new ArrayList<String>();

                    break;
                }
                /**
                 * 하위부서
                 */
//    	        else if (AUTH_DATA_TYPE.TEAM.name().equals(dataTypeCd)) {
//    	            if (ObjectUtil.isNotEmpty(authData.getAccountId())) {
//    	                baseDeptList.add(authData.getAccountId());
//    	            }
//                }
                /**
                 * 소속부서
                 */
//    	        else if (AUTH_DATA_TYPE.MY_TEAM.name().equals(dataTypeCd) && indept) {
//    	            //천 단위 구분자(":") 자르기 oracle in query 개수 제한으로 인하여 천단위 자름
//    	            if (idx % 1000 > 0) {
//                        authDataInValue += ", '" + ar.getAccountId() + "'";
//                    } else {
//                        authDataInValue += ":'" + ar.getAccountId() + "'";
//                    }
//    	            
//    	            indept = false;
//    	            idx++;
//    	        }
                /**
                 * 나
                 *
                 */
                else if (AUTH_DATA_TYPE.MY.name().equals(dataTypeCd) && my) {
                    authDataInQuery += CommonUtil.CREATE_BY_COLUMN + " = '" + ar.getEmpId() + "'";

                    my = false;
                }
            }

            /**
             * 기준부서의 하위부서 목록 조회
             */
            Set<String> set = new HashSet<String>();

            for (String id : baseDeptList) {
                List<String> rtn = new ArrayList<String>();
                rtn = authMapper.selectSubAccountList(id);

                //기준부서
                if (rtn != null) {
                    rtn.add(id);
                } else {
                    rtn = new ArrayList<String>();
                    rtn.add(id);
                }

                //기준부서 및 하위부서 in
                for (String account : rtn) {
                    if (set.add(account)) {
                        //천 단위 구분자(":") 자르기 oracle in query 개수 제한으로 인하여 천단위 자름
                        if (idx % 1000 > 0) {
                            authDataInValue += ", '" + account + "'";
                        } else {
                            authDataInValue += ":'" + account + "'";
                        }

                        idx++;
                    }
                }
            }

            if (ObjectUtil.isNotEmpty(authDataInValue)
                    && ",".equals(authDataInValue.substring(0, 1))) {
                authDataInValue = authDataInValue.substring(1);
            }

            ar.setAuthDataInValue(authDataInValue);
            ar.setAuthDataInQuery(authDataInQuery);
        }


        return ar;
    }

    /*
     * 1. 메소드명: getLoginAuthList
     * 2. 클래스명: AuthCommonService
     * 3. 작성자명: jh.seo
     * 4. 작성일자: 2020. 3. 13.
     */

    /**
     * <PRE>
     * 1. 설명
     * <p>
     * 2. 사용법
     *
     * </PRE>
     *
     * @param id
     * @return
     */

    public List<ProgramCache> getLoginAuthList(String id) {
        LogUtil.param(this.getClass(), id);
        List<String> authId = new ArrayList<>();
        List<ProgramCache> resDto = new ArrayList<>();
        List<ProgramObject> ObjectRes = new ArrayList<>();
        List<ProgramChildResDto> programChild = new ArrayList<>();
        try {
            authId = authMapper.selectGetAuthId(id);
            resDto = authMapper.getAuthProgram(authId);
            ObjectRes = authMapper.selectGetObject(authId);
            programChild = authMapper.getAuthProgramTabChild(authId);
        } catch (Exception e) {
            throw new LoginWrongUserInfoException("checkAuth");
        }


        int pgmSubIndex = 0;
        for (ProgramCache pgm : resDto) {
            if (pgm.getUrl().contains("?")) {
                resDto.get(pgmSubIndex).setUrl(pgm.getUrl().substring(0, pgm.getUrl().indexOf("?")));

            }
            pgmSubIndex++;
        }

        //가져온 프로그램과 오브젝트 목록을 순회하면서 오브젝트목록을 프로그램id값에 맞는 프로그램목록에 저장
        int pgmIndex = 0;
        for (ProgramCache pgm : resDto) {
            List<ProgramObject> objObject = new ArrayList<ProgramObject>();
            for (Iterator<ProgramObject> it = ObjectRes.iterator(); it.hasNext(); ) {
                ProgramObject obj = it.next();
                //오브젝트목록과 프로그램목록의 프로그램ID가 일치하면 해당 오브젝트 객체를 오브젝트객체 리스트에 저장
                if (obj.getProgRid().equals(pgm.getPgmRid())) {    //
                    objObject.add(obj);
                    //저장하고 난후의 오브젝트 객체는 리스트에서 삭제
                    it.remove();
                } else {
                    //프로그램ID값을 정렬하고 비교하기때문에 처음에 일치하는값이 없다면 바로 break로 오브젝트목록 순회를 빠져나감
                    break;
                }
            }
            //리스트에 담은 오브젝트 리스트 객체들을 프로그램객체의 오브젝트목록에 저장
            resDto.get(pgmIndex).setObjectCache(objObject);
            pgmIndex++;
        }

        int pgmChildIndex = 0;
        for (ProgramCache pgm : resDto) {
            List<ProgramChildResDto> objProgramChild = new ArrayList<ProgramChildResDto>();
            for (Iterator<ProgramChildResDto> it = programChild.iterator(); it.hasNext(); ) {
                ProgramChildResDto progChildObj = it.next();

                if (pgm.getPgmRid().equals(progChildObj.getParPgmRid())) {
                    objProgramChild.add(progChildObj);
                    it.remove();
                }
            }
            resDto.get(pgmChildIndex).setProgramChild(objProgramChild);
            pgmChildIndex++;
        }

//		for(ProgramCache pgm :resDto) {
//			if("loyalty/channel/chnlDetailNewPage.jsp".equals(pgm.getUrl())) {
//				
//				System.out.println(pgm.getUrl());
//			}
//		}

        return resDto;
    }

    /*
     * 1. 메소드명: getProgramAuth
     * 2. 클래스명: CacheMgtService
     * 3. 작성자명: jh.seo
     * 4. 작성일자: 2020. 2. 19.
     */

    /**
     * <PRE>
     * 1. 설명
     * 요청받은 URL정보를 가지고 프로그램권한 캐시에서 조회하여 해당 Url에 대한 캐시와 오브젝트를 가져오는 메소드
     * 2. 사용법
     * 로그인한 아이디와 요청받은 URL을 파라미터로 받아 CacheCommon에 Autowired인 cachemanger,
     * 로그인아이디,캐시저장소 이름,URL을 매개변수로 준다
     * </PRE>
     *
     * @param loginId
     * @param url
     * @return ProgramCache
     */
    public ProgramCache getProgramAuth(String loginId, String url) {
        LogUtil.param(this.getClass(), url);

        //프로그램 권한 관련 객체 선언
        ProgramCache resDto = new ProgramCache();

        //요청한 URL을 프로그램 캐시 저장소에서 가져와 존재하는지 체크
        resDto = cacheManagerService.getCacheValue(loginId, "ProgramCache", url);

        //가져온 프로그램 캐시 저장소 값 null여부 체크
        if (resDto.getPgmRid() != null) resDto.setSuccess(true);
        else resDto.setSuccess(false);

        return resDto;
    }


}
