/**
 * @description: Related to Apex Class ParkService
 * @author: Veni Gonzales
 * @department: N/A
 * Test Class for: ParkLocator 
 * CalloutMock Class: ParkServiceMock
 */
@isTest
private class ParkLocatorTest {
	
    @isTest
    static void testCallout() {
        // Set the mock response for the web service callout
        Test.setMock(WebServiceMock.class, new ParkServiceMock());

        // Call the method that invokes a callout
        String country = 'Canada';
        List<String> expectedParkNames = new List<String>{'Amuse Me Park'};
        
        List<String> result = ParkLocator.country(country);
        
        // Validate the response
        System.assertEquals(expectedParkNames, result, 'The park names should match the expected list.');
    }
}