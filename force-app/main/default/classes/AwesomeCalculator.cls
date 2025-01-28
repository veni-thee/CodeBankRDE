/**
 * @description: Related to apex Class calculatorServices
 * @author: Veni Gonzales
 * @department: N/A
 * Test Classes: AwesomeCalculatorTest, CalculatorCalloutMock
 */
public class AwesomeCalculator {
    public static Double add(Double x, Double y) {
        calculatorServices.CalculatorImplPort calculator = new calculatorServices.CalculatorImplPort();
        return calculator.doAdd(x, y);
    }
}