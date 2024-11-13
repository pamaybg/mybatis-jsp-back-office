package com.icignal.kepler.analysis.common.service;

import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icignal.common.base.mapper.CommonMapper;
import com.icignal.core.database.dao.MKTCallQueryDao;
import com.icignal.kepler.analysis.mapper.KprAnalysisChartSettingMapper;
import com.icignal.kepler.analysis.mapper.KprAnalysisColumnMapper;
import com.icignal.kepler.analysis.mapper.KprAnalysisDataMapper;
import com.icignal.kepler.analysis.mapper.KprAnalysisFilterMapper;
import com.icignal.kepler.analysis.mapper.KprAnalysisMapper;
import com.icignal.kepler.analysis.mapper.KprAnalysisPromptMapper;
import com.icignal.kepler.analysis.mapper.KprAnalysisTableSettingMapper;
import com.icignal.kepler.common.mapper.KprCommonMapper;
import com.icignal.kepler.dashboard.mapper.KprDashboardMapper;
import com.icignal.kepler.dashboard.mapper.KprDashboardPromptMapper;

/*
 * 1. 클래스명	: KPRAnalysisCommonSerivce
 * 2. 파일명	: KPRAnalysisCommonSerivce.java
 * 3. 패키지명	: com.icignal.kepler.analysis.common.service
 * 4. 작성자명	: 
 * 5. 작성일자	: 2020. 3. 16.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
@Service
public class KprAnalysisCommonSerivce  {

	@Autowired
	public KprAnalysisMapper kprAnalysisMapper;

	@Autowired
	public KprAnalysisColumnMapper kprAnalysisColumnMapper;

	@Autowired
	public KprAnalysisPromptMapper kprAnalysisPromptMapper;

	@Autowired
	public KprAnalysisFilterMapper kprAnalysisFilterMapper;

	@Autowired
	public KprAnalysisChartSettingMapper kprAnalysisChartSettingMapper;

	@Autowired
	public KprAnalysisDataMapper kprAnalysisDataMapper;

	@Autowired
	public KprCommonMapper kprCommonMapper;

	@Autowired
	public MKTCallQueryDao mktCallQuery;

	@Autowired
	public StandardPBEStringEncryptor encrypor;

	@Autowired
	public CommonMapper CommonMapper;

	@Autowired
	public KprAnalysisTableSettingMapper kprAnalysisTableSettingMapper;
	
	@Autowired
	public KprDashboardMapper kprDashboardMapper;
	
	@Autowired
	public KprDashboardPromptMapper kprDashboardPromptMapper;

}