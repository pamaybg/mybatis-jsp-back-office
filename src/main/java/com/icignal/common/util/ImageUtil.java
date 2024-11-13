package com.icignal.common.util;

import java.awt.Transparency;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Calendar;

import javax.imageio.ImageIO;

import org.imgscalr.Scalr;
import org.imgscalr.Scalr.Mode;
import org.imgscalr.Scalr.Rotation;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.oned.Code128Writer;
import com.icignal.common.base.dto.request.RotateImageReqDto;
import com.icignal.common.base.dto.response.MultiImage;
import com.icignal.common.base.dto.response.MultiImageResDto;

@Component
public class ImageUtil {
	static final Logger logger = LoggerFactory.getLogger(ImageUtil.class);

	public static void makeCouponImage(String couponNo, String realPath){
		logger.debug("ImageUtility : makeCouponImage");
		BitMatrix bitMatrix;
		try {
			Calendar cl = Calendar.getInstance();
			int year = cl.get(Calendar.YEAR);
			int month = cl.get(Calendar.MONTH) + 1;
			int day = cl.get(Calendar.DATE);
			File yearDic = new File(realPath+ File.separator 
					+ BeansUtil.getApplicationProperty("icignal.context.resource.imageUploadPath") 
					+ File.separator + "Coupon" + File.separator + year);
			if(!yearDic.isDirectory()) {
				yearDic.mkdirs();
			}

			File monthDic = new File(yearDic.getAbsolutePath() + File.separator + month);
			if(!monthDic.isDirectory()) {
				monthDic.mkdirs();
			}

			File dayDic = new File(monthDic.getAbsolutePath() + File.separator + day);
			if(!dayDic.isDirectory()) {
				dayDic.mkdirs();
			}

			String path = dayDic.getAbsolutePath().toString();

			File dir = new File(path);
			if(!dir.isDirectory()) {
				dir.mkdirs();
			}

			bitMatrix = new Code128Writer().encode(couponNo, BarcodeFormat.CODE_128, 774, 225, null);
			MatrixToImageWriter.writeToStream(bitMatrix, "png", new FileOutputStream(new File(dir.getAbsolutePath() + File.separator + couponNo + ".png")));

		} catch (WriterException e) {
			LogUtil.error(e);
		} catch (FileNotFoundException e) {
			LogUtil.error(e);
		} catch (IOException e) {
			LogUtil.error(e);
		}

	} 

	public static void setMultiImages(String orgImageUrl, MultiImageResDto multiImageResDto){
		if(orgImageUrl.length() > 0){ //image 테이블의 praentId 가 null 일 경우 예외처리 수정
			String fullPath = orgImageUrl.substring(0, orgImageUrl.lastIndexOf('.'));
			String imageServerUrl = CommonUtil.getInstance().getImageServerUrl() + "/";
	
			if(!orgImageUrl.contains(imageServerUrl)) {
				multiImageResDto.setImgOrgUrl(imageServerUrl + orgImageUrl);
				multiImageResDto.setImgWebDetailUrl(imageServerUrl + fullPath + "_W_D.png");
				multiImageResDto.setImgWebThumbUrl(imageServerUrl + fullPath + "_W_T.png");
				multiImageResDto.setImgWebNormalUrl(imageServerUrl + fullPath + "_W_N.png");
				multiImageResDto.setImgMobileLargeDetailUrl(imageServerUrl + fullPath + "_M_L_D.png");
				multiImageResDto.setImgMobileLargeThumbUrl(imageServerUrl + fullPath + "_M_L_T.png");
				multiImageResDto.setImgMobileLargeNormalUrl(imageServerUrl + fullPath + "_M_L_N.png");
				multiImageResDto.setImgMobileSmallDetailUrl(imageServerUrl + fullPath + "_M_S_D.png");
				multiImageResDto.setImgMobileSmallThumbUrl(imageServerUrl + fullPath + "_M_S_T.png");
				multiImageResDto.setImgMobileSmallNormalUrl(imageServerUrl + fullPath + "_M_S_N.png");
			}
		}
	}
	
	public static void setMultiImages(String orgImageUrl, MultiImage multiImage){
		if(orgImageUrl.length() > 0){ //image 테이블의 praentId 가 null 일 경우 예외처리 수정
			String fullPath = orgImageUrl.substring(0, orgImageUrl.lastIndexOf('.'));
			String ext = orgImageUrl.substring(orgImageUrl.lastIndexOf('.'), orgImageUrl.length());
			String imageServerUrl = CommonUtil.getInstance().getImageServerUrl() + "/";
	
			//multiImage.setWImageUrl(imageServerUrl + fullPath + "_W..png");
			//multiImage.setAImageUrl(imageServerUrl + fullPath + "_A..png");
			//multiImage.setTImageUrl(imageServerUrl + fullPath + "_T..png");
			if(!orgImageUrl.contains(imageServerUrl)) {
				multiImage.setImgOrgUrl(imageServerUrl + orgImageUrl);
				multiImage.setImgWebDetailUrl(imageServerUrl + fullPath + "_W_D.png");
				multiImage.setImgWebThumbUrl(imageServerUrl + fullPath + "_W_T.png");
				multiImage.setImgWebNormalUrl(imageServerUrl + fullPath + "_W_N.png");
				multiImage.setImgMobileLargeDetailUrl(imageServerUrl + fullPath + "_M_L_D.png");
				multiImage.setImgMobileLargeThumbUrl(imageServerUrl + fullPath + "_M_L_T.png");
				multiImage.setImgMobileLargeNormalUrl(imageServerUrl + fullPath + "_M_L_N.png");
				multiImage.setImgMobileSmallDetailUrl(imageServerUrl + fullPath + "_M_S_D.png");
				multiImage.setImgMobileSmallThumbUrl(imageServerUrl + fullPath + "_M_S_T.png");
				multiImage.setImgMobileSmallNormalUrl(imageServerUrl + fullPath + "_M_S_N.png");
			}
		}
	} 

	public static void deleteMImageFiles(String realPath, String delFileUrl){
		String filePath = delFileUrl.split(
				BeansUtil.getApplicationProperty("icignal.context.resource.imageUploadPath")
				)[1].replace("/", File.separator);

		String wd  = filePath.substring(0, filePath.lastIndexOf('.')) + "_W_D.png";
		String wt = filePath.substring(0, filePath.lastIndexOf('.')) + "_W_T.png";
		String wn = filePath.substring(0, filePath.lastIndexOf('.')) + "_W_N.png";
		String mld = filePath.substring(0, filePath.lastIndexOf('.')) + "_M_L_D.png";
		String mlt = filePath.substring(0, filePath.lastIndexOf('.')) + "_M_L_T.png";
		String mln = filePath.substring(0, filePath.lastIndexOf('.')) + "_M_L_N.png";
		String msd = filePath.substring(0, filePath.lastIndexOf('.')) + "_M_S_D.png";
		String mst = filePath.substring(0, filePath.lastIndexOf('.')) + "_M_S_T.png";
		String msn = filePath.substring(0, filePath.lastIndexOf('.')) + "_M_S_N.png";

		//delFile(realPath + Common.getInstance().getImageUploadPath() + filePath);
		delFile(realPath + BeansUtil.getApplicationProperty("icignal.context.resource.imageUploadPath") + wd);
		delFile(realPath + BeansUtil.getApplicationProperty("icignal.context.resource.imageUploadPath") + wt);
		delFile(realPath + BeansUtil.getApplicationProperty("icignal.context.resource.imageUploadPath") + wn);
		delFile(realPath + BeansUtil.getApplicationProperty("icignal.context.resource.imageUploadPath") + mld);
		delFile(realPath + BeansUtil.getApplicationProperty("icignal.context.resource.imageUploadPath") + mlt);
		delFile(realPath + BeansUtil.getApplicationProperty("icignal.context.resource.imageUploadPath") + mln);
		delFile(realPath + BeansUtil.getApplicationProperty("icignal.context.resource.imageUploadPath") + msd);
		delFile(realPath + BeansUtil.getApplicationProperty("icignal.context.resource.imageUploadPath") + mst);
		delFile(realPath + BeansUtil.getApplicationProperty("icignal.context.resource.imageUploadPath") + msn);
	}

	private static void delFile(String path){
		File deleteFile = new File(path);
		try{
			deleteFile.delete();
		}
		catch(Exception e){
			LogUtil.error(e.getMessage(), e);
		}
		
	}
	public  final static void createScaledImage(File sourceFile,
			File file, int maxSize) throws IOException {
		//cmyk이미지 업로드일 경우 상용 라이브러리 사용 ex : ImageMagic 
		//http://kin.naver.com/qna/detail.nhn?d1id=1&dirId=1040201&docId=155683601&qb=amF2YSBpbWFnZWlv&enc=utf8&section=kin&rank=3&search_sort=0&spq=0&pid=RiwZIU5Y7vKssvUJvvKssssssuR-268842&sid=UZwDt3JvLCIAAH8jCHU

		BufferedImage srcImage = ImageIO.read(sourceFile);
		BufferedImage dstImage = null;

		int srcWidth = srcImage.getWidth();
		int srcHeight = srcImage.getHeight();

		if (srcWidth > maxSize) {
			dstImage = Scalr.resize(srcImage, Mode.FIT_TO_WIDTH, maxSize, srcHeight, Scalr.OP_ANTIALIAS);
		}
		else{ 
			dstImage = srcImage;
		}

		ImageIO.write(dstImage, "png", file);

		//		try {
		//			BufferedImage srcImage = ImageIO.read(sourceFile);
		//			if (srcImage == null) {
		//				throw new IOException();
		//			}
		//			int type = (srcImage.getTransparency() == Transparency.OPAQUE) ? BufferedImage.TYPE_INT_RGB
		//					: BufferedImage.TYPE_INT_ARGB;
		//
		//			int srcWidth = srcImage.getWidth();
		//			int srcHeight = srcImage.getHeight();
		//
		//			double scale = 1;
		//
		//			if (srcWidth > maxSize) {
		//				scale = Math.pow(
		//						2,
		//						(int) Math.round(Math.log(maxSize
		//								/ (double) Math.max(srcHeight, srcWidth))
		//								/ Math.log(0.5)));
		//			}
		//
		//			//			if (srcWidth > maxSize){
		//			//				scale = srcWidth / maxSize;
		//			//			}
		//
		//			int desWidht = (int) (srcWidth / scale);
		//			int desHeight = (int) (srcHeight / scale);
		//
		//			BufferedImage dstImage = new BufferedImage(desWidht, desHeight,
		//					type);
		//			dstImage.getGraphics().drawImage(srcImage, 0, 0, desWidht,
		//					desHeight, null);
		//
		//			ImageIO.write(dstImage, "png", file);// 안드로이드 및 아이폰에서 사용때문에 png를
		//			// 사용해야 이미지 손실이 적기 때문입니다.
		//			// 웹에서 jpg 를 원한다면 문구만 바꿔주면
		//			// 됩니다.
		//			// 즉, 모바일 단말에서는 무조건 png 로
		//			// 주셔야 합니다.
		//
		//		} catch (Exception e) {// 사용자 Exception 처리하세요.
		//			LogUtil.error(e);
		//		}
	}

	@Async
	public void createScaledImageAsync(File sourceFile,File file, int maxSize) throws IOException {

		//cmyk이미지 업로드일 경우 상용 라이브러리 사용 ex : ImageMagic 
		//http://kin.naver.com/qna/detail.nhn?d1id=1&dirId=1040201&docId=155683601&qb=amF2YSBpbWFnZWlv&enc=utf8&section=kin&rank=3&search_sort=0&spq=0&pid=RiwZIU5Y7vKssvUJvvKssssssuR-268842&sid=UZwDt3JvLCIAAH8jCHU

		BufferedImage srcImage = ImageIO.read(sourceFile);
		BufferedImage dstImage = null;

		int srcWidth = srcImage.getWidth();
		int srcHeight = srcImage.getHeight();

		if (srcWidth > maxSize) {
			dstImage = Scalr.resize(srcImage, Mode.FIT_TO_WIDTH, maxSize, srcHeight, Scalr.OP_ANTIALIAS);
		}
		else{
			dstImage = srcImage;
		}

		ImageIO.write(dstImage, "png", file);

		//		try {
		//			BufferedImage srcImage = ImageIO.read(sourceFile);
		//			if (srcImage == null) {
		//				throw new IOException();
		//			}
		//			int type = (srcImage.getTransparency() == Transparency.OPAQUE) ? BufferedImage.TYPE_INT_RGB
		//					: BufferedImage.TYPE_INT_ARGB;
		//
		//			int srcWidth = srcImage.getWidth();
		//			int srcHeight = srcImage.getHeight();
		//
		//			double scale = 1;
		//
		//			if (srcWidth > maxSize){
		//				scale = srcWidth / maxSize;
		//			}
		//
		//			int desWidht = (int) (srcWidth / scale);
		//			int desHeight = (int) (srcHeight / scale);
		//
		//			BufferedImage dstImage = new BufferedImage(desWidht, desHeight,
		//					type);
		//			dstImage.getGraphics().drawImage(srcImage, 0, 0, desWidht,
		//					desHeight, null);
		//
		//			ImageIO.write(dstImage, "png", file);// 안드로이드 및 아이폰에서 사용때문에 png를
		//			// 사용해야 이미지 손실이 적기 때문입니다.
		//			// 웹에서 jpg 를 원한다면 문구만 바꿔주면
		//			// 됩니다.
		//			// 즉, 모바일 단말에서는 무조건 png 로
		//			// 주셔야 합니다.
		//
		//		} catch (Exception e) {// 사용자 Exception 처리하세요.
		//			LogUtil.error(e);
		//		}
	}

	public  final static void createScaledImageTemp(File sourceFile,
			File file, int maxSize) {
		try {
			BufferedImage srcImage = ImageIO.read(sourceFile);
			if (srcImage == null) {
				throw new IOException();
			}
			int type = (srcImage.getTransparency() == Transparency.OPAQUE) ? BufferedImage.TYPE_INT_RGB
					: BufferedImage.TYPE_INT_ARGB;

			int srcWidth = srcImage.getWidth();
			int srcHeight = srcImage.getHeight();

			double scale = 1;// 1,2,4,8,16
			//			if (srcHeight > maxSize || srcWidth > maxSize) {
			//				scale = Math.pow(
			//						2,
			//						(int) Math.round(Math.log(maxSize
			//								/ (double) Math.max(srcHeight, srcWidth))
			//								/ Math.log(0.5)));
			//			}
			//
			//			int desWidht = (int) (srcWidth / scale);
			//			int desHeight = (int) (srcHeight / scale);

			if (srcWidth > maxSize){
				scale = srcWidth / maxSize;
			}

			int desWidht = (int) (srcWidth / scale);
			int desHeight = (int) (srcHeight / scale);

			BufferedImage dstImage = new BufferedImage(desWidht, desHeight,
					type);
			dstImage.getGraphics().drawImage(srcImage, 0, 0, desWidht,
					desHeight, null);

			ImageIO.write(dstImage, "png", file);// 안드로이드 및 아이폰에서 사용때문에 png를
			// 사용해야 이미지 손실이 적기 때문입니다.
			// 웹에서 jpg 를 원한다면 문구만 바꿔주면
			// 됩니다.
			// 즉, 모바일 단말에서는 무조건 png 로
			// 주셔야 합니다.

		} catch (Exception e) {// 사용자 Exception 처리하세요.
			LogUtil.error(e);
		}
	}

	public  final static Boolean rotateImage(RotateImageReqDto rir){
		Boolean rtnValue = false;
 
		try{
			File sourceFile = new File(rir.getFilePath());

			if(rir.getIsRight()) {
				rotate90CCW(sourceFile);
			} else {
				rotate90CW(sourceFile);
			}

			rtnValue = true;
		} catch (Exception e) {// 사용자 Exception 처리하세요.
			LogUtil.error(e);
		}

		return rtnValue;
	}

	@Async
	public Boolean rotateAsync(File sourceFile,File targetFile,  int rotation, String ext) throws IOException{
		Boolean rtnValue = false;
		File s = sourceFile;
		BufferedImage srcImage = null;
		BufferedImage newImage = null;
		
		
		
		try {
			srcImage = ImageIO.read(sourceFile);
		} catch (IOException e) {// 사용자 Exception 처리하세요.
			LogUtil.error(e);
			srcImage = ImageIO.read(targetFile);
			s = targetFile;
		}

		switch (rotation) {
		case 1:
			newImage = Scalr.rotate(srcImage, Rotation.CW_90);
			break;
		case 2:
			newImage = Scalr.rotate(srcImage, Rotation.CW_180);
			break;
		case 3:
			newImage = Scalr.rotate(srcImage, Rotation.CW_270);
			break;
		default:
            break;
		}

		if(rotation != 0) {
			ImageIO.write(newImage, ext, s);
		}
		rtnValue = true;

		return rtnValue;
	}

	public  final static Boolean rotate(File sourceFile,File targetFile,  int rotation, String ext) throws IOException{
		Boolean rtnValue = false;
		File s = sourceFile;
		BufferedImage srcImage = null;
		BufferedImage newImage = null;
		try {
			srcImage = ImageIO.read(sourceFile);

		} catch (IOException e) {// 사용자 Exception 처리하세요.
			LogUtil.error(e);
			srcImage = ImageIO.read(targetFile);
			s = targetFile;
		}

		switch (rotation) {
		case 1:
			newImage = Scalr.rotate(srcImage, Rotation.CW_90);
			break;
		case 2:
			newImage = Scalr.rotate(srcImage, Rotation.CW_180);
			break;
		case 3:
			newImage = Scalr.rotate(srcImage, Rotation.CW_270);
			break;
		default:
            break;
		}

		if(rotation != 0) {
			ImageIO.write(newImage, ext, s);
		}
		rtnValue = true;

		return rtnValue;
	}


	public  final static Boolean rotate90CCW(File sourceFile)
	{
		Boolean rtnValue = false;
		try {
			BufferedImage srcImage = ImageIO.read(sourceFile);
			if (srcImage == null) {
				throw new IOException();
			}

			int width = srcImage.getWidth();
			int height = srcImage.getHeight();

			BufferedImage biFlip = new BufferedImage(height, width, srcImage.getType());

			for(int i=0; i<width; i++) {
				for(int j=0; j<height; j++) {
					biFlip.setRGB(j, width-1-i, srcImage.getRGB(i, j));
				}
			}

			rtnValue = true;
		} catch (IOException e) {// 사용자 Exception 처리하세요.
			LogUtil.error(e);
		}
		return rtnValue;
	}

	public  final static Boolean rotate90CW(File sourceFile)
	{
		Boolean rtnValue = false;
		try {
			BufferedImage srcImage = ImageIO.read(sourceFile);
			if (srcImage == null) {
				throw new IOException();
			}

			int width = srcImage.getWidth();
			int height = srcImage.getHeight();

			BufferedImage biFlip = new BufferedImage(height, width, srcImage.getType());

			for(int i=0; i<width; i++) {
				for(int j=0; j<height; j++) {
					biFlip.setRGB(height-1-j, i, srcImage.getRGB(i, j));
				}
			}

			rtnValue = true;

		} catch (IOException e) {// 사용자 Exception 처리하세요.
			LogUtil.error(e);
		}
		return rtnValue;
	}

}
