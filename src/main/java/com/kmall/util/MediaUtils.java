package com.kmall.util;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.MediaType;

public class MediaUtils {

	private static Map<String, MediaType> imageTypeMap;
	
	static {
		imageTypeMap = new HashMap<String, MediaType>();
		
		imageTypeMap.put("JPG", MediaType.IMAGE_JPEG);
		imageTypeMap.put("GIF", MediaType.IMAGE_GIF);
		imageTypeMap.put("PNG", MediaType.IMAGE_PNG);
	}
	
	public static MediaType getType(String format) {
		MediaType result = null;
		
		result = imageTypeMap.get(format.toUpperCase());
		
		return result;
	}
}
