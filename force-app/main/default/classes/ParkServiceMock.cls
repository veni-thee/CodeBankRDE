/**
 * @description: Related to Apex Class ParkService
 * @author: Veni Gonzales
 * @department: N/A
 * Apex Class: ParkLocator 
 * CalloutMock for Test Class: ParkLocatorTest
 */
@isTest
global class ParkServiceMock implements WebServiceMock {

    global void doInvoke(
        Object stub,
        Object request,
        Map<String, Object> response,
        String endpoint,
        String soapAction,
        String requestName,
        String responseNS,
        String responseName,
        String responseType) {
        
        // Mock response to return expected park names
        ParkService.byCountryResponse response_x = new ParkService.byCountryResponse();
        
        // Mocked park names response
        response_x.return_x = new String[]{'Amuse Me Park'};
        
        // Add the response object to the response map
        response.put('response_x', response_x);
    }
}