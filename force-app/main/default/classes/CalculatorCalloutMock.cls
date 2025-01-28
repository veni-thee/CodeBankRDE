/**
 * @description: Related to apex Class calculatorServices
 * @author: Veni Gonzales
 * @department: N/A
 * Apex Class: AwesomeCalculator
 * CalloutMock for Test Class: AwesomeCalculatorTest
 */
@isTest
global class CalculatorCalloutMock implements WebServiceMock {
	
    global void doInvoke (
    	Object stub,
        Object request,
        Map<String, Object> response,
        String endpoint,
        String soapAction,
        String requestName,
        String responseNS,
        String responseName,
        String responseType ) {
    
    	// start - specific the response you want to send
    	calculatorServices.doAddResponse response_x =
            new calculatorServices.doAddResponse();
            
    	response_x.return_x = 3.0;
        // end
        
        response.put('response_x', response_x);
    }
}