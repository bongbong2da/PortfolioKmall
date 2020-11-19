package com.kmall.util;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;

import org.imgscalr.Scalr;
import org.springframework.http.ResponseEntity;

public class FileUtils {
	
	private static String uploadPath = "D:\\dev\\upload";
	
	public static String getFormat(String name) {
		return name.substring(name.lastIndexOf(".")+1);
	}
	
	public static void makeThumbnail(String savePath, File originalFile) {
		
		String fileName = originalFile.getName();

		String format = FileUtils.getFormat(fileName);

		String newName = "s_" + fileName;

		File newFile = new File(savePath + newName);

		BufferedImage originalImg;
		
		BufferedImage destImg;
		
		try {
			originalImg = ImageIO.read(originalFile);
			
			destImg = Scalr.resize(originalImg, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_HEIGHT, 300);
			
			ImageIO.write(destImg, format.toUpperCase(), newFile);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
}
