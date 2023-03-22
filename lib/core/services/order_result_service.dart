abstract class OrderResultService {
  double calculateMoneyResult({
    required double points,
    required double pointsPerTick,
    required double moneyByTick,
    required contractNumber,
    double? tax
  });

  double getRiskReturn();

  double calculateTaxByContract({
    required contractNumber,
    required taxByContract,
  });
}
