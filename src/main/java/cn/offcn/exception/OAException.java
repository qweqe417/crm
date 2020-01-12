package cn.offcn.exception;

public class OAException extends RuntimeException{
	
	private String message;
	
	public OAException(String message) {
		super(message);
		this.message=message;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}
	

}
