package com.icignal.kepler.analysis.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.icignal.common.util.BeansUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.common.util.ObjectUtil;
import com.icignal.core.database.dto.request.MKTDBInfoDTO;
import com.icignal.kepler.analysis.common.service.KprAnalysisCommonSerivce;
import com.icignal.kepler.analysis.dto.request.KprAnalysisListByCustTierReqDto;
import com.icignal.kepler.analysis.dto.request.KprAnalysisListByCustTypeReqDto;
import com.icignal.kepler.analysis.dto.response.KprAnalysisListByCustTierResDto;
import com.icignal.kepler.analysis.dto.response.KprAnalysisListByCustTypeResDto;


/*
 * 1. 클래스명	: KPRCustomerAnalysisService
 * 2. 파일명	: KPRCustomerAnalysisService.java
 * 3. 패키지명	: com.icignal.kepler.analysis.service
 * 4. 작성자명	: hr.noh
 * 5. 작성일자	: 2020. 3. 17.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
@Service("KprCustomerAnalysisService")
public class KprCustomerAnalysisService extends KprAnalysisCommonSerivce{

	 /*
	  * 1. 메소드명: getAnalysisListByCustType
	  * 2. 클래스명: KPRCustomerAnalysisService
	  * 3. 작성자명: hr.noh 
	  * 4. 작성일자: 2020. 3. 17.
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
	public List getAnalysisListByCustType(KprAnalysisListByCustTypeReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		List rtnValue = new ArrayList();
		StringBuilder sqlQuery = new StringBuilder();
		//접속DB정보 설정
		MKTDBInfoDTO dbInfo = new MKTDBInfoDTO();

//		String classNmae =   encrypor.decrypt(CommonUtil.getInstance().getServletProp("jdbc.postgre.driverClassName"));
//	    String url = encrypor.decrypt(CommonUtil.getInstance().getServletProp("jdbc.postgre.url"));
//	    String username = encrypor.decrypt(CommonUtil.getInstance().getServletProp("jdbc.postgre.username"));
// 	    String password = encrypor.decrypt(CommonUtil.getInstance().getServletProp("jdbc.postgre.password"));
//	    String condType = encrypor.decrypt(CommonUtil.getInstance().getServletProp("jdbc.postgre.condDbType"));
	    String classNmae =   BeansUtil.getApplicationProperty("jdbc.postgre.driverClassName");
	    String url = BeansUtil.getApplicationProperty("jdbc.postgre.url");
	    String username = BeansUtil.getApplicationProperty("jdbc.postgre.username");
	    String password = BeansUtil.getApplicationProperty("jdbc.postgre.password");
	    String condType = BeansUtil.getApplicationProperty("jdbc.postgre.condDbType");
	    
	    
		dbInfo.setDriverClassName(classNmae);
	    dbInfo.setUrl(url);
		dbInfo.setUserName(username);
		dbInfo.setPassword(password);
		dbInfo.setConDbType(condType);

		sqlQuery.append(" select ")
				.append(" t2.ymonth_cd AS ymonthcd ")
				.append(" , t2.mem_type_cd AS memtypecd ")
				.append(" , t3.mem_type_nm AS memtypenm ")
				.append(" , t2.mem_active_cnt AS memactivecnt ")
				.append(" , (case when t2.ymonth_cd ='" + reqDto.getYearMonth() + "' then 0 else t2.base_cnt2 - t2.mem_active_cnt end) AS memactivecnt2 ")
				.append(" , t2.mem_active_cnt + (case when t2.ymonth_cd ='" + reqDto.getYearMonth() + "' then 0 else t2.base_cnt2 - t2.mem_active_cnt end) AS totactivecnt ")
				.append(" , round(cast(((t2.mem_active_cnt  - case when t2.ymonth_cd ='" + reqDto.getYearMonth() + "' then 0 else t2.base_cnt2 - t2.mem_active_cnt end)) as numeric) / cast(t2.mem_active_cnt as numeric) * 100, 1) AS rate ")
				.append(" , round(t2.fill_vol_t,0) AS fillvolt ")
				.append(" from ( ")
				.append(" select ymonth_cd ")
				.append(" , mem_type_cd ")
				.append(" , mem_active_cnt ")
				.append(" ,  case when ymonth_cd = '" + reqDto.getYearMonth() + "' then base_cnt ")
				.append(" else case when ymonth_cd =to_char(to_date('" + reqDto.getYearMonth() + "','yyyymmdd')+interval '1 months','yyyymm') ")
				.append(" then coalesce(lag(mem_active_cnt,2) over(order by ymonth_cd, mem_type_cd),base_cnt) ")
				.append(" else case when ymonth_cd =to_char(to_date('" + reqDto.getYearMonth() + "','yyyymmdd')+interval '2 months','yyyymm')  ")
				.append(" then coalesce(lag(mem_active_cnt,4) over(order by ymonth_cd, mem_type_cd),base_cnt)  ")
				.append(" end ")
				.append(" end ")
				.append(" end as base_cnt2 ")
				.append(" , fill_vol_t ")
				.append(" from ( ")
				.append(" select ymonth_cd ")
				.append(" , mem_type_cd as mem_type_cd ")
				.append(" , sum(mem_active_cnt) as mem_active_cnt ")
				.append(" , sum(case when ymonth_cd ='" + reqDto.getYearMonth() + "' then mem_active_cnt else 0 end) as base_cnt ")
				.append(" , sum(fill_vol_t) as fill_vol_t ")
				.append(" from mart.FT_MEM_ACTIVE_RATE_M ")
				.append(" where ymonth_cd between '" + reqDto.getYearMonth() + "' and to_char(to_date('" + reqDto.getYearMonth() + "','yyyymmdd')+interval '2 months','yyyymm')  ")
				.append(" group by ymonth_cd ")
				.append(" , mem_type_cd ")
				.append(" order by ymonth_cd ) t1 ) t2 ")
				.append(" , mart.d_mem_type t3 ")
				.append(" where t2.mem_type_cd = t3.mem_type_cd ")
				.append(" order by t2.ymonth_cd ");
		
	   if (ObjectUtil.isNotEmpty(dbInfo) && ObjectUtil.isNotEmpty(sqlQuery)) {
           //쿼리 실행
           rtnValue = mktCallQuery.callSelectForList("KPRCustomerAnalysisDAO.getAnalysisListByCustType", sqlQuery.toString(), new ArrayList<String>(), dbInfo, KprAnalysisListByCustTypeResDto.class);
       }

		return rtnValue;
	}

	 /*
	  * 1. 메소드명: getAnalysisListByCustTier
	  * 2. 클래스명: KPRCustomerAnalysisService
	  * 3. 작성자명: 
	  * 4. 작성일자: 2020. 3. 17.
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
	public List getAnalysisListByCustTier(KprAnalysisListByCustTierReqDto reqDto) {
		LogUtil.param(this.getClass(), reqDto);
		List rtnValue = new ArrayList();
		StringBuilder sqlQuery = new StringBuilder();
		//접속DB정보 설정
		MKTDBInfoDTO dbInfo = new MKTDBInfoDTO();

//		String classNmae =   encrypor.decrypt(CommonUtil.getInstance().getServletProp("jdbc.postgre.driverClassName"));
//	    String url = encrypor.decrypt(CommonUtil.getInstance().getServletProp("jdbc.postgre.url"));
//	    String username = encrypor.decrypt(CommonUtil.getInstance().getServletProp("jdbc.postgre.username"));
// 	    String password = encrypor.decrypt(CommonUtil.getInstance().getServletProp("jdbc.postgre.password"));
//	    String condType = encrypor.decrypt(CommonUtil.getInstance().getServletProp("jdbc.postgre.condDbType"));
		String classNmae =   BeansUtil.getApplicationProperty("jdbc.postgre.driverClassName");
	    String url = BeansUtil.getApplicationProperty("jdbc.postgre.url");
	    String username = BeansUtil.getApplicationProperty("jdbc.postgre.username");
	    String password = BeansUtil.getApplicationProperty("jdbc.postgre.password");
	    String condType = BeansUtil.getApplicationProperty("jdbc.postgre.condDbType");
	    
		dbInfo.setDriverClassName(classNmae);
	    dbInfo.setUrl(url);
		dbInfo.setUserName(username);
		dbInfo.setPassword(password);
		dbInfo.setConDbType(condType);

		sqlQuery.append(" select ")
				.append(" t2.ymonth_cd AS ymonthcd ")
				.append(" , t2.mem_type_cd AS memtypecd ")
				.append(" , t3.mem_type_nm AS memtypenm ")
				.append(" , t2.mem_grade_cd AS memgradecd ")
				.append(" , t4.mem_grade_nm AS memgradenm ")
				.append(" , t2.mem_active_cnt AS memactivecnt  ")
				.append(" , (case when t2.ymonth_cd ='" + reqDto.getYearMonth() + "' then 0 else t2.base_cnt2 - t2.mem_active_cnt end) as memactivecnt2  ")
				.append(" ,  t2.mem_active_cnt + (case when t2.ymonth_cd ='" + reqDto.getYearMonth() + "' then 0 else t2.base_cnt2 - t2.mem_active_cnt end) as totactivecnt   ")
				.append(" , round(cast(((t2.mem_active_cnt  - case when t2.ymonth_cd ='" + reqDto.getYearMonth() + "' then 0 else t2.base_cnt2 - t2.mem_active_cnt end)) as numeric) / cast(t2.mem_active_cnt as numeric) * 100, 1) as rate  ")
				.append(" , round(fill_vol_t,0) AS fillvolt  ")
				.append(" from ( ")
				.append(" select ymonth_cd ")
				.append(" , mem_type_cd ")
				.append(" , mem_grade_cd ")
				.append(" , mem_active_cnt ")
				.append(" , case when ymonth_cd = '" + reqDto.getYearMonth() + "' then base_cnt ")
				.append(" else case when ymonth_cd =to_char(to_date('" + reqDto.getYearMonth() + "','yyyymmdd')+interval '1 months','yyyymm')  ")
				.append(" then coalesce(lag(mem_active_cnt,4) over(order by ymonth_cd, mem_type_cd, mem_grade_cd),base_cnt)  ")
				.append(" else case when ymonth_cd =to_char(to_date('" + reqDto.getYearMonth() + "','yyyymmdd')+interval '2 months','yyyymm')  ")
				.append(" then coalesce(lag(mem_active_cnt,8) over(order by ymonth_cd, mem_type_cd, mem_grade_cd),base_cnt)  ")
				.append(" end ")
				.append(" end ")
				.append(" end as base_cnt2 ")
				.append(" , fill_vol_t ")
				.append(" from ( ")
				.append(" select ymonth_cd ")
				.append(" , mem_type_cd as mem_type_cd ")
				.append(" , mem_grade_cd as mem_grade_cd ")
				.append(" , sum(mem_active_cnt) as mem_active_cnt  ")
				.append(" , sum(case when ymonth_cd ='" + reqDto.getYearMonth() + "' then mem_active_cnt else 0 end) as base_cnt ")
				.append(" , sum(fill_vol_t) as fill_vol_t ")
				.append(" from mart.FT_MEM_ACTIVE_RATE_M ")
				.append(" where ymonth_cd between '" + reqDto.getYearMonth() + "' and to_char(to_date('" + reqDto.getYearMonth() + "','yyyymmdd')+interval '2 months','yyyymm')  ")
				.append(" group by ymonth_cd ")
				.append(" , mem_type_cd ")
				.append(" , mem_grade_cd ")
				.append(" order by ymonth_cd ) t1 ) t2 ")
				.append(" , mart.d_mem_type t3 ")
				.append(" , mart.d_mem_grade t4 ")
				.append(" where t2.mem_type_cd = t3.mem_type_cd ")
				.append(" and t2.mem_grade_cd = t4.mem_grade_cd ")
				.append(" order by t2.ymonth_cd ");
		
	   if (ObjectUtil.isNotEmpty(dbInfo) && ObjectUtil.isNotEmpty(sqlQuery)) {
           //쿼리 실행
           rtnValue = mktCallQuery.callSelectForList("KPRCustomerAnalysisDAO.getAnalysisListByCustTier", sqlQuery.toString(), new ArrayList<String>(), dbInfo, KprAnalysisListByCustTierResDto.class);
       }

		return rtnValue;
	}
	
}
