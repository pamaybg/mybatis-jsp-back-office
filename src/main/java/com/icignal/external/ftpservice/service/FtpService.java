package com.icignal.external.ftpservice.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.GregorianCalendar;

import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPReply;
import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icignal.common.util.CommonUtil;
import com.icignal.common.util.LogUtil;
import com.icignal.common.workflow.service.WorkflowService;
import com.icignal.core.database.dto.request.MKTDBInfoDTO;
import com.icignal.external.ftpservice.mapper.FtpServiceMapper;
import com.icignal.loyalty.promotion.campaign.service.LoyCampaignService;
import com.icignal.loyalty.promotion.ruleset.service.LoyRuleSetService;
import com.jcraft.jsch.Channel;
import com.jcraft.jsch.ChannelSftp;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.Session;
@Service
public class FtpService {


	    @Autowired
	    LoyCampaignService loyCampaignService;

	    @Autowired
		FtpServiceMapper ftpServiceMapper;


	    @Autowired
	    LoyRuleSetService loyRuleSetService;

	    @Autowired
	    WorkflowService workflowService;
	    
	    @Autowired
	    WorkflowService mktWorkflowService;


	    /**
	     * @name : FTP 파일 업로드
	     * @date : 2016. 02. 03.
	     * @author : 장용
	     * @table : -
	     * @return : boolean
	     * @description : 쿼리 정보 조회
	     */
	    public String ftpFileUplaod(String filePath, String FileType, String fileName, String lang){

	        String rtnValue = "";

	        //FTP 접속 정보 조회
	        MKTDBInfoDTO dataBaseInfo = new MKTDBInfoDTO();
	        dataBaseInfo.setFileType(FileType);
	        dataBaseInfo = ftpServiceMapper.selectFTPInfo(dataBaseInfo);

	        //db 정보가 있을경우
	        if (dataBaseInfo != null) {

	            StandardPBEStringEncryptor encrypor = new StandardPBEStringEncryptor();
	            encrypor.setPassword("9pwc3dke");

	            dataBaseInfo.setConPw(encrypor.decrypt(dataBaseInfo.getConPw()));

	            // FTP 유형이 SFTP일경우
	            if ("SFTP".equals(dataBaseInfo.getFtpPortType())) {
	                rtnValue = sftpFileUplaod(filePath, FileType, fileName, lang);
	            }
	            // FTP 유형이 FTP일경우
	            else {

	                FTPClient ftp = new FTPClient();
	                ftp.setControlEncoding("euc-kr");

	                try {

	                    String SFTPHOST = dataBaseInfo.getConIp();
	                    int SFTPPORT = dataBaseInfo.getFtpPort();

	                    ftp.connect(SFTPHOST, SFTPPORT);

	                    LogUtil.debug("Connected to " + SFTPHOST + ".");
	                    LogUtil.debug(ftp.getReplyString());

	                    int reply = ftp.getReplyCode();

	                    if (!FTPReply.isPositiveCompletion(reply)) {
	                        ftp.disconnect();
	                        LogUtil.debug("FTP server refused connection.");
	                    }
	                    else {
	                    	FileInputStream input = null;
	                     try {
	                        ftp.login(dataBaseInfo.getConId(), dataBaseInfo.getConPw());

	                        LogUtil.debug("FTP logined~! :" + dataBaseInfo.getConId());
	                        ftp.enterLocalActiveMode();
	                        LogUtil.debug("FTP ActiveMode ~!");
	                        LogUtil.debug(ftp.getReplyString());
	                        ftp.setSoTimeout(10000); // Wait time - 10second

	                        LogUtil.debug("Connect successful");

	                        // ======================== 이미지 파일 전송 ====================================//

	                        ftp.setFileType(FTP.BINARY_FILE_TYPE);

	                        ftp.changeWorkingDirectory(dataBaseInfo.getConPath());

	                        String rootPath = CommonUtil.getInstance().getServletProp("context.rootPath");

	                        File file = new File(rootPath + filePath);
	                        input = new FileInputStream(file);

	                        GregorianCalendar calendar = new GregorianCalendar();
	                        SimpleDateFormat logTimeFt2 = new SimpleDateFormat("yyyyMMdd",java.util.Locale.KOREA);
	                        String curDate = logTimeFt2.format(calendar.getTime());

	                        String reFileName = curDate + "_" + fileName;
	                        boolean result = ftp.storeFile(reFileName, input);

	                        LogUtil.debug("FILE TRANSPORT STATUS  :" + result);

	                        // ======================== 이미지 파일 전송 ====================================//

	                        ftp.disconnect();
	                        LogUtil.debug("FILE URL  :" + rtnValue);
	                      } finally {
		                        input.close();
	                      }
	                    }
	                }
	                catch (IOException e) {
	                    LogUtil.error("FTP Upload Error :", e);
	                    rtnValue = "";
	                }
	                finally {
	                    if (ftp.isConnected()) {
	                        try {
	                            ftp.disconnect();
	                        }
	                        catch (IOException ioe) {
	                            LogUtil.error(ioe);
	                            ftp = null;
	                        }
	                    }
	                }
	            }
	        }

	        return rtnValue;
	    }

	    /**
	     * @programId :
	     * @name : sftpFileUplaod
	     * @date : 2016. 10. 19.
	     * @author : 류동균
	     * @table :
	     * @return :
	     * @description : SFTP 파일 업로드
	     */
	    public String sftpFileUplaod(String filePath, String FileType, String fileName, String lang){

	        String rtnValue = "";

	        //FTP 접속 정보 조회
	        MKTDBInfoDTO dataBaseInfo = new MKTDBInfoDTO();
	        dataBaseInfo.setFileType(FileType);
	        dataBaseInfo = ftpServiceMapper.selectFTPInfo(dataBaseInfo);

	        if(dataBaseInfo != null){
	            StandardPBEStringEncryptor encrypor = new StandardPBEStringEncryptor();
	            encrypor.setPassword("9pwc3dke");
	            dataBaseInfo.setConPw(encrypor.decrypt(dataBaseInfo.getConPw()));

	            String SFTPHOST = dataBaseInfo.getConIp();
	            int SFTPPORT = dataBaseInfo.getFtpPort();
	            String SFTPUSER = dataBaseInfo.getConId();
	            String SFTPPASS = dataBaseInfo.getConPw();
	            String SFTPWORKINGDIR = dataBaseInfo.getConPath();

	            Session session = null;
	            Channel channel = null;
	            ChannelSftp channelSftp = null;
	            LogUtil.debug("preparing the host information for sftp.");
	            try {
	                JSch jsch = new JSch();
	                session = jsch.getSession(SFTPUSER, SFTPHOST, SFTPPORT);
	                session.setPassword(SFTPPASS);

	                java.util.Properties config = new java.util.Properties();
	                config.put("StrictHostKeyChecking","no");

	                session.setConfig(config);
	                session.connect();
	                LogUtil.debug("Host connected.");

	                channel = session.openChannel("sftp");
	                channel.connect();
	                LogUtil.debug("sftp channel opened and connected.");

	                channelSftp = (ChannelSftp) channel;

	                //upload dir
	                channelSftp.cd(SFTPWORKINGDIR);

	                //get file
	                String rootPath = CommonUtil.getInstance().getServletProp("context.rootPath");
	                File file = new File(rootPath + filePath);
	                FileInputStream in = new FileInputStream(file);

	                //get fileName
	                GregorianCalendar calendar = new GregorianCalendar();
	                SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddss",java.util.Locale.KOREA);
	                String curDate = sdf.format(calendar.getTime());
	                String reFileName = curDate + "_" + fileName;

	                rtnValue = dataBaseInfo.getConPath() + reFileName;

	                //upload
	                channelSftp.put(in, reFileName);
	                in.close();
	            } catch (Exception ex) {
	                LogUtil.error("Exception found while tranfer the response. : " + ex.toString(), ex);
	                rtnValue = "";
	            }
	            finally{
	                channelSftp.exit();
	                LogUtil.debug("sftp Channel exited.");
	                channel.disconnect();
	                LogUtil.debug("Channel disconnected.");
	                session.disconnect();
	                LogUtil.debug("Host Session disconnected.");
	            }
	        }

	        return rtnValue;
	    }

		
	}


