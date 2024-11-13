package com.icignal.qpid.ftp;

import java.io.*;
import java.util.Properties;

import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.helper.IFVMErrorHelper;
import com.icignal.common.util.BeansUtil;
import com.icignal.common.util.LogUtil;
import com.jcraft.jsch.Channel;
import com.jcraft.jsch.ChannelSftp;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.Session;
import com.jcraft.jsch.SftpException;
import org.apache.commons.logging.Log;
import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;

/**
 * Qpid FTP Excel 요청 클래스
 * 
 * @author jskim
 * 
 */
public class FTPManager {
	public final String PRODUCTION_IP = "www.qpid.co.kr";
	public final int PRODUCTION_PORT = 22;

	public final int DEVELOPMENT_PORT = 60022;
	public final String DEVELOPMENT_IP = BeansUtil.getApplicationProperty("qpid.ftp.ip");
	public final String DEFAULT_IMAGE_NAME = "photo_def.jpg";

	private String connectID;
	private String connectPWD;
	private String connectPATH;
            
	private String confirmExt = ".ok";
             
	private ChannelSftp chSftp;
	private Session ses;
	private Channel ch;

	public FTPManager() {

	}

	public boolean initializeConnection(String id, String pwd, String path, String customIP, int customPort, boolean encryption) {
		StandardPBEStringEncryptor encrypor = new StandardPBEStringEncryptor();
		encrypor.setPassword("9pwc3dke");
		boolean rtnValue = false;

		this.connectID = encryption? encrypor.decrypt(id) : id;
		this.connectPWD =  encryption? encrypor.decrypt(pwd) : pwd;
		this.connectPATH = path;

		JSch jsch = new JSch();

		try {
			ses = jsch.getSession(this.connectID,  encryption? encrypor.decrypt(customIP) : customIP, customPort);

			ses.setPassword(this.connectPWD);

			Properties p = new Properties();

			// 호스트 정보를 검사하지 않음
			p.put("StrictHostKeyChecking", "no");
			ses.setConfig(p);

			ses.connect();

			ch = ses.openChannel("sftp");

			ch.connect();

			chSftp = (ChannelSftp) ch;

			rtnValue = true;
			LogUtil.info("initializeConnection : Success");
		} catch (Exception e) {
			if (chSftp != null)
				chSftp.quit();

			if (ch != null)
				ch.disconnect();

			if (ses != null)
				ses.disconnect();
			LogUtil.info("initializeConnection : Fail");
		}

		return rtnValue;
	}

	public boolean initializeConnection(String id, String pwd, String path, boolean production) {
		return this.initializeConnection(id, pwd, path, production ? PRODUCTION_IP : DEVELOPMENT_IP, production ? PRODUCTION_PORT : DEVELOPMENT_PORT, false);
	}

	public StatusResDto sendNotifications(String filePath) {
		StatusResDto result = new StatusResDto();
		result.setSuccess(true);


		File file = new File(filePath);
		//File emptyFile = new File(filePath + confirmExt);
		FileInputStream fi = null;
		//FileInputStream emptyFi = null;
		try {
			//writeEmptyFile(filePath);

			fi = new FileInputStream(file);
			chSftp.cd(this.connectPATH);
			chSftp.put(fi, file.getName());
			LogUtil.info("FTPManager : success save image file to " + this.connectPATH + file.getName());

			/*emptyFi = new FileInputStream(emptyFile);
			chSftp.put(emptyFi, emptyFile.getName());*/

		} catch (SftpException e) {
			result.setSuccess(false);
			result.setErrorType(IFVMErrorHelper.PUSH_SFTP_EXCEPTION);
			result.setMessage(e.getMessage());
		} catch (FileNotFoundException e) {
			result.setSuccess(false);
			result.setErrorType(IFVMErrorHelper.PUSH_SFTP_FILENOTFOUND);
			result.setMessage(e.getMessage());
		} finally {
			try {
				result.setSuccess(true);

				if (fi != null)
					fi.close();
				/*if (emptyFi != null)
					emptyFi.close();*/

				if (chSftp != null)
					chSftp.quit();

				if (ch != null)
					ch.disconnect();

				if (ses != null)
					ses.disconnect();

				removeEmptyFile(filePath + confirmExt);
			} catch (IOException e) {
				LogUtil.error(e);
			}
		}

		return result;
	}

	private void writeEmptyFile(String filePath) {
		BufferedWriter out = null;
		try {
			out = new BufferedWriter(new FileWriter(filePath + confirmExt));
		} catch (IOException e) {
			LogUtil.error(e);
		}finally {
			try {
				if(out!=null)
				out.close();
			} catch (IOException e) {
				LogUtil.error(e);
			}
		}

	}

	private void removeEmptyFile(String filePath) {
		File f = new File(filePath);
		f.delete();
	}

	public void removeFile(String middlePath, String fileName){
		try{
			chSftp.cd(this.connectPATH + "/" + middlePath);
			chSftp.rm(fileName);
			LogUtil.info("FTPManager : success remove file to " + this.connectPATH + "/" + middlePath);
		}catch (SftpException e){
			LogUtil.error(e);
		}
	}

	public String mkdirMiddlePath(String currentDataPath) {
		try{
			String[] pathArray = currentDataPath.split("/");
			chSftp.cd(this.connectPATH);
			String currentDirectory = chSftp.pwd();

			String toPathArray = "";
			String currentPath = "";
			for(int i=0; i< pathArray.length; i++) {
				toPathArray += pathArray[i] + "/";
				currentPath = currentDirectory + "/" + toPathArray;
				try {
					chSftp.mkdir(currentPath);
					chSftp.cd(currentPath);
				} catch (SftpException tempE) {
					chSftp.cd(currentPath);
				}
			}
			this.connectPATH = currentDirectory + "/" + toPathArray;
			LogUtil.info("FTPManager : success make date directory and move that path - " + this.connectPATH);
			return currentDirectory + "/" + toPathArray;
		}catch(SftpException e){
			try{
				chSftp.cd(this.connectPATH);
				return this.connectPATH;
			}catch(SftpException se){
				LogUtil.error(se);
				return this.connectPATH;
			}
		}
	}

	public InputStream getFile(String datePath, String fileName){
		InputStream in = null;
		try {
			String customPath = this.connectPATH + "/" + datePath;
			chSftp.cd(customPath);
			in = chSftp.get(fileName);
			LogUtil.info("FTPManager : success get image file from " + customPath + "/" + fileName);
		} catch (SftpException e){
			try{
				chSftp.cd(this.connectPATH);
				in = chSftp.get(DEFAULT_IMAGE_NAME);
				LogUtil.info("FTPManager : success get default image file from " + this.connectPATH + "/" + DEFAULT_IMAGE_NAME);
			}catch (SftpException se){
				LogUtil.error(se);
			}
		} finally {
			return in;
		}
	}


	public void disconnection() {
		if (chSftp != null) chSftp.quit();
		if (ch != null) ch.disconnect();
		if (ses != null) ses.disconnect();
		LogUtil.info("FTPManager : success connection disconnect");
	}
}
