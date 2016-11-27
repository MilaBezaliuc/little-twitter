package com.endava.twitter.util;

import java.io.IOException;

public class ImageUploadException extends Exception {

	public ImageUploadException(String message) {
		super(message);
	}

	public ImageUploadException(String message, IOException cause) {
		super(message, cause);
	}

}
