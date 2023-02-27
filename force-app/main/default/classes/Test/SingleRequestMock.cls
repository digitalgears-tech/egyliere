/**
 * @description       : 
 * @author            : Mohamed Tarek
 * @group             : 
 * @last modified on  : 02-26-2023
 * @last modified by  : Mohamed Tarek
**/
@isTest
public class SingleRequestMock implements HttpCalloutMock {
  protected Integer code;
  protected String status;
  protected String bodyAsString;
  protected Blob bodyAsBlob;
  protected Map<String, String> responseHeaders;

  public SingleRequestMock(
    Integer code,
    String status,
    String body,
    Map<String, String> responseHeaders
  ) {
    this.code = code;
    this.status = status;
    this.bodyAsString = body;
    this.bodyAsBlob = null;
    this.responseHeaders = responseHeaders;
  }

  public SingleRequestMock(
    Integer code,
    String status,
    Blob body,
    Map<String, String> responseHeaders
  ) {
    this.code = code;
    this.status = status;
    this.bodyAsBlob = body;
    this.bodyAsString = null;
    this.responseHeaders = responseHeaders;
  }
  // Implement this interface method
  public HTTPResponse respond(HTTPRequest req) {
    // Optionally, only send a mock response for a specific endpoint
    // Create a fake response
    HttpResponse res = new HttpResponse();
    res.setHeader('Content-Type', 'application/json');
    res.setBody('{"example":"test"}');
    res.setStatusCode(200);

    HttpResponse response = new HttpResponse();
    response.setStatusCode(code);
    response.setStatus(status);

    if (bodyAsBlob != null) {
      response.setBodyAsBlob(bodyAsBlob);
    } else {
      response.setBody(bodyAsString);
    }
    if (responseHeaders != null) {
      for (String key : responseHeaders.keySet()) {
        response.setHeader(key, responseHeaders.get(key));
      }
    }
    return response;
  }
}