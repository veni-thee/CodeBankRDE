/**
 * @description: Related to Apex Class ParkService
 * @author: Veni Gonzales
 * @department: N/A
 * Test Classes: ParkLocatorTest, ParkServiceMock
 */
public class ParkLocator {
    
    //Class must have a country method that uses the ParkService class 
    //Method must return a list of available park names for a particular 
    //country passed to the web service (such as Germany, India, Japan, and United States)
    //Trailhead: Apex Integration Services > Apex SOAP Callouts
    
    public static List<String> country(String country) {
        ParkService.ParksImplPort parkNames = new ParkService.ParksImplPort();
        return parkNames.byCountry(country);
    }
}