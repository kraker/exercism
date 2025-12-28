public class SalaryCalculator {
    public double salaryMultiplier(int daysSkipped) {
        double salaryMultiplier = (daysSkipped >= 5) ? 0.85 : 1.0;
        return salaryMultiplier;
    }

    public int bonusMultiplier(int productsSold) {
        int bonusMultiplier = (productsSold >= 20) ? 13 : 10;
        return bonusMultiplier;
    }

    public double bonusForProductsSold(int productsSold) {
        return bonusMultiplier(productsSold) * productsSold;
    }

    public double finalSalary(int daysSkipped, int productsSold) {
        double finalSalary =
            salaryMultiplier(daysSkipped) * 1000.00
            + bonusForProductsSold(productsSold);
        return (finalSalary > 2000.00) ? 2000.00 : finalSalary;
    } 
}
